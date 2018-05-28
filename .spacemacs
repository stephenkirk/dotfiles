(setq-default dotspacemacs-configuration-layers '(
                                                  ruby
                                                  html
                                                  markdown
                                                  auto-completion
                                                  org
                                                  (osx :variables osx-option-as 'meta
                                                                  osx-right-option-as 'none)
                                                  )
)

;; Option modifier for using right option key for symbols and left as meta
(setq-default mac-right-option-modifier nil)

;; Temporary theme workaround
(load-file "~/spacemacs/dash.el")
(load-file "~/spacemacs/autothemer.el")

;; Font
(setq dotspacemacs-default-font '("Roboto Mono"
                                  :size 14
                                  :weight normal
                                  :width normal
                                  :powerline-scale 1.1))

;; Org and Agenda
(setq org-agenda-files '("~/org" "~/org/todos") )
;; Custom TODO states
(setq org-todo-keywords
      '((sequence "TODO"
                  "WORKING"
                  "HOLD"
                  "|"
                  "DONE"))
)

(setq org-todo-keyword-faces
      '(
        ("TODO" . "#fb4934")
        ("WORKING" . "#fabd2f")
        ("HOLD" . "#fdf4c1")
        ("DONE" . "#b8bb26")
        )
)

;; Themes
(setq dotspacemacs-themes '(gruvbox))


(setq multi-term-program "/usr/bin/zsh")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby bundler inf-ruby dash-functional ws-butler winum which-key web-mode volatile-highlights vi-tilde-fringe uuidgen use-package toc-org tagedit spaceline slim-mode scss-mode sass-mode reveal-in-osx-finder restart-emacs request rainbow-delimiters pug-mode popwin persp-mode pcre2el pbcopy paradox osx-trash osx-dictionary org-projectile org-present org-pomodoro org-download org-bullets open-junk-file neotree move-text mmm-mode markdown-toc macrostep lorem-ipsum linum-relative link-hint less-css-mode launchctl info+ indent-guide hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag gruvbox-theme google-translate golden-ratio gnuplot gh-md fuzzy flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu emmet-mode elisp-slime-nav dumb-jump diminish define-word company-web company-statistics column-enforce-mode clean-aindent-mode auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 16777215)) (:background "#282828" :foreground "#fdf4c1")) (((class color) (min-colors 255)) (:background "#262626" :foreground "#ffffaf")))))

