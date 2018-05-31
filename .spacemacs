(setq-default dotspacemacs-configuration-layers '(
                                                  helm
                                                  markdown
                                                  auto-completion
                                                  org
                                                  (osx :variables osx-option-as 'meta
                                                                  osx-right-option-as 'none)
                                                  )
)

;; Set a sane theme
(setq dotspacemacs-additional-packages '(color-theme-solarized))

;; Custom key bindings
(global-set-key (kbd "<f12>") 'org-agenda)

;; Option modifier for using right option key for symbols and left as meta
(setq-default mac-right-option-modifier nil)

;; Font
(setq dotspacemacs-default-font '("Roboto Mono"
                                  :size 14
                                  :weight normal
                                  :width normal
                                  :powerline-scale 1.1))

;; Org and Agenda folders
(setq org-agenda-files '("~/org") )
(setq org-directory "~/org")
(setq org-default-notes-file "~/org/refile.org")

                                        ; Refile
;; Allow refile to target anything in org folder
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

;; TODO states (with GTD as principle)
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "HOLD(h@/!)")
              )))

;; Capture templates
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/org/refile.org")
               "* TODO %?\n%U\n")
              ("r" "next" entry (file "~/org/refile.org")
               "* NEXT %?\n%U\n")
              ("n" "note" entry (file "~/org/refile.org")
               "* %? :NOTE:\n%U\n")
              ("m" "Meeting" entry (file "~/org/refile.org")
               "* MEETING with %? :MEETING:\n%U\n")
)))

(setq org-todo-keyword-faces
      '(
        ("TODO" . "#fb4934")
        ("NEXT" . "#fabd2f")
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

