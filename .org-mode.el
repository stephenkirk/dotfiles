;; Custom key binding for agenda
(global-set-key (kbd "<f12>") 'org-agenda)


;; Org and Agenda folders
(setq org-agenda-files '("~/org") )
(setq org-directory "~/org")
(setq org-default-notes-file "~/org/refile.org")


;; Allow refile to target anything 3 layers down in org folder
(setq org-refile-targets (quote ((nil :maxlevel . 3)
                                 (org-agenda-files :maxlevel . 3))))


;; TODO states (with GTD as principle)
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "HOLD(h)")
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
              ("g" "Gratitude" entry (file+datetree "~/org/diary.org")
               "* Today's gratitude :JOURNAL:GRATEFULNESS:\n%U\n%?")
              )))


;; Enter insert mode after creating template
(add-hook 'org-capture-mode-hook 'evil-insert-state)

;; I like beautiful colours
(setq org-todo-keyword-faces
      '(
        ("TODO" . "#fb4934")
        ("NEXT" . "#fabd2f")
        ("HOLD" . "#fdf4c1")
        ("DONE" . "#b8bb26")
        )
      )
