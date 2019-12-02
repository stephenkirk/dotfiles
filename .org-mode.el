;; Replace ugly #+BEGIN_SRC blocks in org-mode documents with lambda symbol
;; I use <sTAB anyway to insert
(setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . "λ")))
(add-hook 'org-mode-hook 'prettify-symbols-mode)

;; Hide leading stars; replace '...' in org headings with a less in-your-face symbol
(setq org-hide-leading-stars t)
(setq org-ellipsis "⤵")

;; Don’t ask me if I want to run an babel code block. I know what I’m doing.
(setq org-confirm-babel-evaluate nil)

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

;; List stuck projects when pressing A in agenda view
;; TODO: Define stuck projects
(setq org-agenda-custom-commands
      (quote (("A" "Custom Agenda"
                (stuck ""
                       ((org-agenda-overriding-header "Stuck Projects")))))))

(defun export-org-files()
  "Export all org files"
  (org-html-export-to-html "~/org/diary.org")
  )

;; Allow refile to target anything 3 layers down in org files
;; TODO: Separate levels for separate files
;; ;; EXAMPLE
;; (setq org-refile-targets (quote (("tickler.org" :maxlevel . 1)
;;                                  ("organizer.org" :level . 1)
;;                                  ("someday.org" :level . 2))))

(setq org-refile-targets (quote ((nil :maxlevel . 3)
                                 (org-agenda-files :maxlevel . 3))))

;; TODO states
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "HOLD(h)")
              )))

; Refile in a single go
(setq org-outline-path-complete-in-steps nil)

; Show full paths for refiling
(setq org-refile-use-outline-path t)

; Refile start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))


;; evil bindings for important files
(evil-leader/set-key
  "orr" (!! (find-file "~/org/refile.org"))
  "orm" (!! (find-file "~/org/refile_mobile.org")) ;; keep separate refile for beorg notes - reduces conflicts slightly
  )

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
              ("j" "Journal" entry (file+datetree+prompt "~/org/diary.org")
               "* %? :JOURNAL:\n%U\n")
              ("d" "Diary" entry (file+datetree+prompt "~/org/diary.org")
               "* %? :DIARY:\n%U\n")
              ("n" "note" entry (file+datetree+prompt "~/org/diary.org")
               "* %? :NOTE:\n%U\n")
              ("b" "Bucket list" entry (file+datetree+prompt "~/org/diary.org")
              "* %? :BUCKETLIST:JOURNAL:\n%U\n")
              ("g" "Gratitude" entry (file+datetree+prompt "~/org/diary.org")
              "* Today's gratitude :JOURNAL:GRATEFULNESS:\n%U\n%?")
)))

;; font customizations
(add-hook 'org-mode-hook
          '(lambda ()
             ;; (setq line-spacing 0.2) ;; Add more line padding for readability
             ;; (variable-pitch-mode 1) ;; All fonts with variable pitch.
             (mapc
              (lambda (face) ;; Other fonts with fixed-pitch.
                (set-face-attribute face nil :inherit 'fixed-pitch))
              (list 'org-code
                    'org-link
                    'org-block
                    'org-table
                    'org-verbatim
                    'org-block-begin-line
                    'org-block-end-line
                    'org-meta-line
                    'org-document-info-keyword))))

;; Enter insert mode after creating template
(add-hook 'org-capture-mode-hook 'evil-insert-state)

;; (org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . nil)
   (R . t)
   (shell . t)
  )
