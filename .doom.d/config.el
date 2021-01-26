;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; (add-to-list 'default-frame-alist
;;             '(ns-transparent-titlebar . t))
;; (add-to-list 'default-frame-alist
;;             '(ns-appearance . light))


(setq user-full-name "Stephen"
      user-mail-address "me@thestephen.net"
      org-directory "~/org/"
      display-line-numbers-type t)

(setq-default evil-want-C-i-jump t)

;; Option modifier - right option key for symbols; left for meta
(setq-default mac-right-option-modifier nil)

(setq +magit-hub-features t)

;; Set switch project default behaviour to magit
(setq +workspaces-switch-project-function #'magit-status)

; theme
(setq doom-theme nil)
(add-hook! 'ns-system-appearance-change-functions
  (defun update-theme (appearance)
    (pcase appearance
      (`light (load-theme 'gruvbox-light-medium t))
      (`dark  (load-theme 'gruvbox-dark-medium t)))))
