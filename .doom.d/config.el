;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; (add-to-list 'default-frame-alist
;;             '(ns-transparent-titlebar . t))
;; (add-to-list 'default-frame-alist
;;             '(ns-appearance . light))


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

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(use-package magit-delta
  :hook (magit-mode . magit-delta-mode))
