;; define lambdas using "interactive" with macro shorthand
;; Found at https://stackoverflow.com/a/37422551/8058988 
(defmacro !! (&rest body)
  `(lambda () (interactive) ,@body))

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

;; some default evil bindings
(evil-leader/set-key
  "fec" (!! (find-file "~/.spacemacs-config.el"))
  "feo" (!! (find-file "~/.org-mode.el"))
  "S" 'my-org-screenshot
  "s!" 'shell
)

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

