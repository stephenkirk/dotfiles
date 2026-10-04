;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-



;; Encoding — set early so vterm inherits UTF-8
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(setenv "LANG" "en_US.UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")

(setq user-full-name "Stephen"
      org-directory "~/org/"
      display-line-numbers-type t)

;; Load private settings from the gitignored symlink to dotfiles-private.
(let ((private (expand-file-name "private.el" doom-user-dir)))
  (when (file-exists-p private)
    (load private nil 'nomessage)))

;; Use bash for subprocesses that expect POSIX shell syntax.
(setq shell-file-name (executable-find "bash"))

;; Use fish in interactive terminals.
    (setq-default vterm-shell (executable-find "fish"))
(setq-default explicit-shell-file-name (executable-find "fish"))


(setq-default evil-want-C-i-jump t)

;; Let right Option type symbols instead of acting as Meta.
(setq-default mac-right-option-modifier nil)

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
           (lines (magit-git-lines
                   "for-each-ref" "--sort=-committerdate"
                   "--format=%(refname:short)\t%(committerdate:relative)"
                   "refs/heads/"))
           (entries (mapcar
                     (lambda (line)
                       (let ((parts (split-string line "\t")))
                         (list (car parts) (cadr parts))))
                     lines))
           (entries
            (let ((cur (seq-find (lambda (e) (equal (car e) current)) entries))
                  (rest (seq-remove (lambda (e) (equal (car e) current)) entries)))
              (append (when cur (list cur))
                      (seq-take rest (if cur 9 10))))))
      (dolist (entry entries)
        (let ((branch (car entry))
              (age (cadr entry)))
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
  "Insert a section showing git worktrees, sorted by HEAD recency.
The main worktree is pinned on top (git always emits it first in
--porcelain output)."
  (let ((porcelain (magit-git-lines "worktree" "list" "--porcelain")))
    (when porcelain
      (magit-insert-section (worktrees)
        (magit-insert-heading "Worktrees:")
        (let ((current-toplevel (magit-toplevel))
              (entries nil)
              path head branch bare locked prunable)
          (dolist (line (append porcelain '("")))
            (cond
             ((string-prefix-p "worktree " line)
              (when path
                (push (list path head branch bare locked prunable) entries))
              (setq path (substring line 9)
                    head nil branch nil bare nil locked nil prunable nil))
             ((string-prefix-p "HEAD " line)
              (setq head (substring line 5)))
             ((string-prefix-p "branch " line)
              (setq branch (replace-regexp-in-string
                            "^refs/heads/" "" (substring line 7))))
             ((string= "bare" line) (setq bare t))
             ((string-prefix-p "locked" line) (setq locked t))
             ((string-prefix-p "prunable" line) (setq prunable t))
             ((string= "" line)
              (when path
                (push (list path head branch bare locked prunable) entries)
                (setq path nil)))))
          (setq entries (nreverse entries))
          (let* ((main-entry (car entries))
                 (rest (cdr entries))
                 (shas (delq nil (mapcar #'cadr rest)))
                 (times (make-hash-table :test 'equal)))
            (when shas
              (dolist (l (apply #'magit-git-lines
                                "show" "-s" "--format=%H %ct" shas))
                (let ((parts (split-string l " ")))
                  (puthash (car parts) (string-to-number (cadr parts)) times))))
            (setq entries
                  (cons main-entry
                        (sort rest
                              (lambda (a b)
                                (> (or (gethash (cadr a) times) 0)
                                   (or (gethash (cadr b) times) 0)))))))
          (dolist (entry entries)
            (let* ((p (nth 0 entry))
                   (b (nth 2 entry))
                   (br (nth 3 entry))
                   (lk (nth 4 entry))
                   (pr (nth 5 entry))
                   (name (abbreviate-file-name p))
                   (currentp (string= (file-name-as-directory p)
                                      current-toplevel)))
              (magit-insert-section (worktree p)
                (insert (if currentp "* " "  ")
                        (propertize (truncate-string-to-width name 40 nil ?\s)
                                    'font-lock-face
                                    (if currentp 'magit-branch-current
                                      'magit-filename))
                        " "
                        (propertize (or b "(detached)")
                                    'font-lock-face
                                    (if currentp 'magit-branch-current
                                      'magit-branch-local))
                        (if br " (bare)" "")
                        (if lk " (locked)" "")
                        (if pr " (prunable)" "")
                        "\n")))))
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
