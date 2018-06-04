
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

;; Make fullscreen great again
(setq ns-use-native-fullscreen nil)
