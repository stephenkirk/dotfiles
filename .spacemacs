
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


;; Set a sane theme
(setq dotspacemacs-additional-packages '(color-theme-solarized))
(setq-default dotspacemacs-themes '(solarized-light solarized-dark))

;; Load config file with user defined functions
(load "~/.spacemacs-config.el")

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
;; Allow refile to target anything 3 layers down in org folder
(setq org-refile-targets (quote ((nil :maxlevel . 3)
                                 (org-agenda-files :maxlevel . 3))))

;; (setq org-agenda-prefix-format "%l")

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
              ("j" "Journal" entry (file+datetree "~/org/diary.org")
               "* %? :JOURNAL:\n%U\n")
              ("d" "Diary" entry (file+datetree "~/org/diary.org")
               "* %? :DIARY:\n%U\n")
)))

(setq org-todo-keyword-faces
      '(
        ("TODO" . "#fb4934")
        ("NEXT" . "#fabd2f")
        ("HOLD" . "#fdf4c1")
        ("DONE" . "#b8bb26")
        )
)

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
    (solarized-theme web-beautify livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc company-tern dash-functional tern coffee-mode macrostep elisp-slime-nav define-word auto-compile packed ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline smeargle reveal-in-osx-finder restart-emacs rainbow-delimiters popwin persp-mode pcre2el pbcopy paradox osx-trash osx-dictionary orgit org-projectile org-present org-pomodoro org-mime org-download org-bullets open-junk-file omnisharp neotree move-text mmm-mode markdown-toc magit-gitflow lorem-ipsum linum-relative link-hint launchctl indent-guide hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md fuzzy flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu dumb-jump diminish company-statistics column-enforce-mode color-theme-solarized clean-aindent-mode auto-yasnippet auto-highlight-symbol aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
