;; Load private config shared from dropbox
;; TODO: symlink
(mapc 'load (file-expand-wildcards "~/Dropbox/dotfiles_private/*.el"))

;; evil bindings for important files
(defun find-refile-file ()
  (interactive)
  (find-file "~/org/refile.org"))

;; keep a separate refile for beorg notes - this reduces conflicts slightly
(defun find-mobile-refile-file ()
  (interactive)
  (find-file "~/org/refile_mobile.org"))

(evil-leader/set-key
  "orr" 'find-refile-file
  "orm" 'find-mobile-refile-file)

;; Custom key binding for agenda
(global-set-key (kbd "<f12>") 'org-agenda)

;; Org and Agenda folders
(setq org-agenda-files '("~/org") )
(setq org-directory "~/org")
(setq org-default-notes-file "~/org/refile.org")

;; i prefer slightly longer weeks in org agenda
(setq org-agenda-span 10
      org-agenda-start-on-weekday nil
      org-agenda-start-day "-3d")

;; Allow refile to target anything 3 layers down in org files
;; TODO: Separate levels for separate files
;; ;; EXAMPLE
;; (setq org-refile-targets (quote (("tickler.org" :maxlevel . 1)
;;                                  ("organizer.org" :level . 1)
;;                                  ("someday.org" :level . 2))))

(setq org-refile-targets (quote ((nil :maxlevel . 3)
                                 (org-agenda-files :maxlevel . 3))))

; Refile in a single go
(setq org-outline-path-complete-in-steps nil)

; Show full paths for refiling
(setq org-refile-use-outline-path t)

;; TODO states (with GTD as principle)
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "HOLD(h)")
              )))

;; Capture templates
(setq org-capture-templates
      (quote
              (("t" "todo" entry (file "~/org/refile.org")
               "* TODO %?\n%U\n")
              ("T" "todo, schedule today" entry (file "~/org/refile.org")
               "* TODO %?\n%U\n SCHEDULED: <%(org-read-date nil nil \"+0d\")>\n")
              ("r" "next" entry (file "~/org/refile.org")
               "* NEXT %?\n%U\n")
              ("R" "next, schedule today" entry (file "~/org/refile.org")
               "* NEXT %?\n%U\n SCHEDULED: <%(org-read-date nil nil \"+0d\")>\n")
              ("m" "Meeting" entry (file "~/org/refile.org")
               "* MEETING with %? :MEETING:\n%U\n")
              ("M" "Book meeting with" entry (file "~/org/refile.org")
               "* Book meeting with %? :MEETING:\n%U\n SCHEDULED: <%(org-read-date nil nil \"+5d\")>\n")

              ("s" "emacs shortcut" entry (file "~/org/shortcuts.org")
               "* %? :SHORTCUT:\n%U\n")

              ;; Journal
              ("j" "Journal" entry (file+datetree "~/org/diary.org")
               "* %? :JOURNAL:\n%U\n")
              ("d" "Diary" entry (file+datetree "~/org/diary.org")
               "* %? :DIARY:\n%U\n")
              ("n" "note" entry (file+datetree "~/org/diary.org")
               "* %? :NOTE:\n%U\n")
              ("b" "Bucket list" entry (file+datetree "~/org/diary.org")
              "* %? :BUCKETLIST:JOURNAL:\n%U\n")
              ("g" "Gratitude" entry (file+datetree "~/org/diary.org")
              "* Today's gratitude :JOURNAL:GRATEFULNESS:\n%U\n%?")
)))


;; Enter insert mode after creating template
(add-hook 'org-capture-mode-hook 'evil-insert-state)

;; (org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . nil)
   (R . t)
   (shell . t)
  )
