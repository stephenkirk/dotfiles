(setq-default dotspacemacs-configuration-layers '(
                                                  html
                                                  csv
                                                  javascript
                                                  csharp
                                                  helm
                                                  markdown
                                                  git
                                                  auto-completion
                                                  org
                                                  (osx :variables osx-option-as 'meta
                                                                  osx-right-option-as 'none)
                                                  )
)

;; Always follow symlinks instead of asking
(setq vc-follow-symlinks t)

(setq dotspacemacs-additional-packages '(org-clock-csv org-plus-contrib))
(setq dotspacemacs-excluded-packages '(powerline))

(defun dotspacemacs/user-config ()
  "Configuration function for user code."

  ;; Make evil-mode up/down operate in screen lines instead of logical lines
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  ;; Also in visual mode
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line)
  )

;; spacemacs speedup hack
(setq auto-window-vscroll nil)

(defun export-org-files()
  "Export all org files"
  (org-html-export-to-html "~/org/diary.org")
  )

;; Midnight-mode
;; (require 'midnight)
;; (midnight-delay-set 'midnight-delay "10:30am") ;; I'm usually in emacs by then
;; (add-hook 'midnight-hook (lambda
;; 			                     (with-current-buffer "*cvs*"
;; 				                     (call-interactively 'cvs-update))))

;; Theming
;; TODO Currently on hold as this seems super unreliable at the patchwork that is spacemacs
;; (setq-default dotspacemacs-themes '(solarized-light solarized-dark))
;; Disable unicode symbols in mode line to speed up performance
(setq dotspacemacs-mode-line-unicode-symbols nil)
(setq dotspacemacs-default-font '("Input Mono Narrow"
                                  :size 13
                                  :weight normal
                                  :width normal
                                  :powerline-scale 1.2))

;; Load other things
(load "~/.spacemacs-config.el")

;; Load org-related config
(load "~/.org-mode.el")

;; Option modifier - right option key for symbols; left for meta
(setq-default mac-right-option-modifier nil)

;; Make fullscreen sane
;; TODO: classic iterm style fullscreen
(setq-default dotspacemacs-fullscreen-use-non-native nil)
(setq-default dotspacemacs-maximized-at-startup t)
(setq-default ns-use-native-fullscreen nil)

;; Make C-i act as vim jumplist instead
(setq-default evil-want-C-i-jump t)

;; Use zsh as terminal
(setq multi-term-program "/usr/bin/zsh")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (macrostep elisp-slime-nav define-word auto-compile packed ws-butler winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toc-org tagedit spaceline smeargle slim-mode scss-mode sass-mode reveal-in-osx-finder restart-emacs rainbow-delimiters pug-mode popwin persp-mode pcre2el pbcopy paradox osx-trash osx-dictionary orgit org-projectile org-present org-pomodoro org-download org-clock-csv org-bullets open-junk-file omnisharp neotree move-text mmm-mode markdown-toc magit-gitflow lorem-ipsum livid-mode linum-relative link-hint less-css-mode launchctl json-mode js2-refactor js-doc info+ indent-guide hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md fuzzy flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu emmet-mode dumb-jump diminish csv-mode company-web company-tern company-statistics column-enforce-mode coffee-mode clean-aindent-mode auto-yasnippet auto-highlight-symbol aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
