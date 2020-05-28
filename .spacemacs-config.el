(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (org-display-inline-images)
  (setq filename
        (concat
         (make-temp-name
          (concat (file-name-nondirectory (buffer-file-name))
                  "_imgs/"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (unless (file-exists-p (file-name-directory filename))
    (make-directory (file-name-directory filename)))
                                        ; take screenshot
  (if (eq system-type 'darwin)
      (call-process "screencapture" nil nil nil "-i" filename))
                                        ; insert into file if correctly taken
  (if (file-exists-p filename)
      (insert (concat "[[file:" filename "]]"))))

;; define lambdas using "interactive" with macro shorthand !!
;; Found at https://stackoverflow.com/a/37422551/8058988 
(defmacro !! (&rest body)
  `(lambda () (interactive) ,@body))

;; some default bindings
(evil-leader/set-key
  "fec" (!! (find-file "~/.spacemacs-config.el"))
  "feo" (!! (find-file "~/.org-mode.el"))
  "S" 'my-org-screenshot
  "s!" 'shell
)

(setq vc-follow-symlinks t) ;; Always follow symlinks instead of asking

(setq dotspacemacs-auto-resume-layouts t)
;; Theming
(setq-default dotspacemacs-themes '(solarized-dark solarized-light))
(setq dotspacemacs-default-font '("Input Mono Narrow"
                                  :size 13
                                  :weight normal
                                  :width normal
                                  :powerline-scale 1.2))

(setq-default evil-want-C-i-jump t) ;; Make C-i act as vim jumplist instead

(setq solarized-use-variable-pitch nil) ;; don't use weird fonts
(setq multi-term-program "/usr/bin/zsh")
