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
             (lambda (a b) (> (cadr a) (cadr b))))))
      (dolist (entry (seq-take entries 10))
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

(after! magit
  (magit-add-section-hook 'magit-status-sections-hook
                          #'magit-insert-local-branches-with-age
                          #'magit-insert-stashes
                          'append))

(setq doom-font (font-spec :family "Iosevka Term" :size 14))

;; Glyph fallback for nerd font / powerline symbols in vterm
(after! fontset
  (set-fontset-font t 'symbol "Symbols Nerd Font Mono" nil 'prepend))
