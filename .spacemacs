
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

(setq dotspacemacs-additional-packages '(color-theme-solarized org-clock-csv))

;; Set a sane theme
(setq-default dotspacemacs-themes '(solarized-light solarized-dark))

;; Load config file with user defined functions
(load "~/.spacemacs-config.el")

;; Load org-related config files
(load "~/.org-mode.el")

;; Option modifier - right option key for symbols; left for meta
(setq-default mac-right-option-modifier nil)

;; Font
(setq dotspacemacs-default-font '("Fira Code"
                                  :size 13
                                  :weight normal
                                  :width normal
                                  :powerline-scale 1.1))

(setq multi-term-program "/usr/bin/zsh")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(package-selected-packages
   (quote
    (rjsx-mode web-mode tagedit slim-mode scss-mode sass-mode pug-mode less-css-mode helm-css-scss haml-mode emmet-mode company-web web-completion-data csv-mode org-clock-csv solarized-theme web-beautify livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc company-tern dash-functional tern coffee-mode macrostep elisp-slime-nav define-word auto-compile packed ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline smeargle reveal-in-osx-finder restart-emacs rainbow-delimiters popwin persp-mode pcre2el pbcopy paradox osx-trash osx-dictionary orgit org-projectile org-present org-pomodoro org-mime org-download org-bullets open-junk-file omnisharp neotree move-text mmm-mode markdown-toc magit-gitflow lorem-ipsum linum-relative link-hint launchctl indent-guide hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md fuzzy flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu dumb-jump diminish company-statistics column-enforce-mode color-theme-solarized clean-aindent-mode auto-yasnippet auto-highlight-symbol aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 '(variable-pitch ((t (:family "Fira Sans")))))
