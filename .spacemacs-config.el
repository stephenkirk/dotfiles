
;; (defun switch-to-previous-buffer ()
;;   "Switch to previously open buffer.
;; Repeated invocations toggle between the two most recently open buffers."
;;   (interactive)
;;   (switch-to-buffer (other-buffer (current-buffer) 1)))

;; (global-set-key (kbd "M-x b") 'switch-to-previous-buffer)


(defun config-file ()
  "Return the path to this config file."
  "~/.spacemacs-config.el"
  )

(defun find-config-file ()
  (interactive)
  (find-file (config-file)))

(evil-leader/set-key
  "fec" 'find-config-file)

(evil-leader/set-key
  "s!" 'shell)

(add-hook 'org-mode-hook
          '(lambda ()
             ;; (setq line-spacing 0.2) ;; Add more line padding for readability
             (variable-pitch-mode 1) ;; All fonts with variable pitch.
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



;; Make fullscreen great again
(setq ns-use-native-fullscreen nil)
