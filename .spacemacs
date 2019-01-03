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

(setq dotspacemacs-additional-packages '(org-clock-csv))

;; Disable unicode symbols in mode line to speed up performance
(setq dotspacemacs-mode-line-unicode-symbols nil)


;; Themeing
;; (setq-default dotspacemacs-themes '(solarized-light solarized-dark))

(setq dotspacemacs-default-font '("Fira Code"
                                  :size 13
                                  :weight normal
                                  :width normal
                                  :powerline-scale 1.1))


;; Load other things
(load "~/.spacemacs-config.el")

;; Load org-related config
(load "~/.org-mode.el")

;; Option modifier - right option key for symbols; left for meta
(setq-default mac-right-option-modifier nil)

;; Make fullscreen sane
;; TODO: still not iterm style fullscreen
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
   '(web-mode web-beautify tagedit powerline smeargle slim-mode scss-mode sass-mode reveal-in-osx-finder pug-mode pbcopy spinner osx-trash osx-dictionary orgit org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download org-clock-csv omnisharp flycheck markdown-toc markdown-mode magit-gitflow livid-mode skewer-mode simple-httpd launchctl json-snatcher json-reformat js2-refactor multiple-cursors js-doc hydra htmlize parent-mode projectile pkg-info epl helm-gitignore helm-css-scss helm-company helm-c-yasnippet haml-mode gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md fuzzy flx evil-magit magit magit-popup git-commit ghub treepy graphql with-editor smartparens iedit anzu evil goto-chg undo-tree highlight emmet-mode f csharp-mode company-web web-completion-data company-tern s dash-functional tern company color-theme-solarized color-theme bind-map bind-key auto-yasnippet helm avy helm-core async ac-ispell auto-complete popup solarized-theme yasnippet ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text mmm-mode lorem-ipsum linum-relative link-hint json-mode js2-mode indent-guide hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu dumb-jump diminish csv-mode company-statistics column-enforce-mode coffee-mode clean-aindent-mode auto-highlight-symbol aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(variable-pitch ((t (:family "Fira Sans")))))
