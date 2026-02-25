;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; (add-to-list 'default-frame-alist
;;             '(ns-transparent-titlebar . t))
;; (add-to-list 'default-frame-alist
;;             '(ns-appearance . light))


;; Encoding — set early so vterm inherits UTF-8
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(setenv "LANG" "en_US.UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")

(setq user-full-name "Stephen"
      user-mail-address "me@thestephen.net"
      org-directory "~/org/"
      display-line-numbers-type t)

;; Make emacs use bash instead of fish to prevent garbage output
(setq shell-file-name (executable-find "bash"))

;; ...but use fish for terminal emulators
    (setq-default vterm-shell (executable-find "fish"))
(setq-default explicit-shell-file-name (executable-find "fish")) 


(setq-default evil-want-C-i-jump t)

;; Option modifier - right option key for symbols; left for meta
(setq-default mac-right-option-modifier nil)

; magit
(setq +magit-hub-features t)
;; Set switch project default behaviour to magit
(setq +workspaces-switch-project-function #'magit-status)

; Set theme based on system appearance
(setq doom-theme nil)
(add-hook! 'ns-system-appearance-change-functions
  (defun update-theme (appearance)
    (pcase appearance
      (`light (load-theme 'gruvbox-light-medium t))
      (`dark  (load-theme 'gruvbox-dark-medium t)))))

(use-package magit-delta
  :hook (magit-mode . magit-delta-mode))

(defun magit-insert-local-branches-with-age ()
  "Insert a section showing local branches with their age."
  (magit-insert-section (local-branches-age)
    (magit-insert-heading "Local branches:")
    (let* ((current (magit-get-current-branch))
           (branches (magit-list-local-branch-names))
           (entries
            (sort
             (mapcar
              (lambda (branch)
                (let ((time (string-to-number
                             (or (magit-git-string
                                  "log" "-1" "--format=%ct" branch)
                                 "0"))))
                  (list branch time
                        (magit-git-string
                         "log" "-1" "--format=%cr" branch))))
              branches)
             (lambda (a b) (> (cadr a) (cadr b)))))
           (entries
            (let ((cur (seq-find (lambda (e) (equal (car e) current)) entries))
                  (rest (seq-remove (lambda (e) (equal (car e) current)) entries)))
              (append (when cur (list cur))
                      (seq-take rest (if cur 9 10))))))
      (dolist (entry entries)
        (let ((branch (car entry))
              (age (caddr entry)))
          (magit-insert-section (branch branch)
            (insert (if (equal branch current) "* " "  ")
                    (propertize (truncate-string-to-width branch 40 nil ?\s)
                                'font-lock-face
                                (if (equal branch current)
                                    'magit-branch-current
                                  'magit-branch-local))
                    " "
                    (propertize age 'font-lock-face 'magit-log-date)
                    "\n")))))
    (insert "\n")))

(defun magit-insert-worktrees ()
  "Insert a section showing git worktrees."
  (let ((worktrees (magit-git-lines "worktree" "list" "--porcelain")))
    (when worktrees
      (magit-insert-section (worktrees)
        (magit-insert-heading "Worktrees:")
        (let ((current-toplevel (magit-toplevel))
              path branch bare locked prunable)
          (dolist (line (append worktrees '("")))
            (cond
             ((string-prefix-p "worktree " line)
              (when path
                (let* ((name (abbreviate-file-name path))
                       (currentp (string= (file-name-as-directory path)
                                          current-toplevel)))
                  (magit-insert-section (worktree path)
                    (insert (if currentp "* " "  ")
                            (propertize (truncate-string-to-width name 40 nil ?\s)
                                        'font-lock-face
                                        (if currentp 'magit-branch-current
                                          'magit-filename))
                            " "
                            (propertize (or branch "(detached)")
                                        'font-lock-face
                                        (if currentp 'magit-branch-current
                                          'magit-branch-local))
                            (if bare " (bare)" "")
                            (if locked " (locked)" "")
                            (if prunable " (prunable)" "")
                            "\n"))))
              (setq path (substring line 9)
                    branch nil bare nil locked nil prunable nil))
             ((string-prefix-p "branch " line)
              (setq branch (replace-regexp-in-string
                            "^refs/heads/" "" (substring line 7))))
             ((string= "bare" line) (setq bare t))
             ((string-prefix-p "locked" line) (setq locked t))
             ((string-prefix-p "prunable" line) (setq prunable t))
             ((string= "" line)
              (when path
                (let* ((name (abbreviate-file-name path))
                       (currentp (string= (file-name-as-directory path)
                                          current-toplevel)))
                  (magit-insert-section (worktree path)
                    (insert (if currentp "* " "  ")
                            (propertize (truncate-string-to-width name 40 nil ?\s)
                                        'font-lock-face
                                        (if currentp 'magit-branch-current
                                          'magit-filename))
                            " "
                            (propertize (or branch "(detached)")
                                        'font-lock-face
                                        (if currentp 'magit-branch-current
                                          'magit-branch-local))
                            (if bare " (bare)" "")
                            (if locked " (locked)" "")
                            (if prunable " (prunable)" "")
                            "\n")))
                (setq path nil))))))
        (insert "\n")))))

(after! magit
  (magit-add-section-hook 'magit-status-sections-hook
                          #'magit-insert-local-branches-with-age
                          #'magit-insert-stashes
                          'append)
  (magit-add-section-hook 'magit-status-sections-hook
                          #'magit-insert-worktrees
                          #'magit-insert-local-branches-with-age
                          'append))

(setq doom-font (font-spec :family "Iosevka Term" :size 14))

;; Glyph fallback for nerd font / powerline symbols in vterm
(after! fontset
  (set-fontset-font t 'symbol "Symbols Nerd Font Mono" nil 'prepend))
