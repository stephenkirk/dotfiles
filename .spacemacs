;; define interactive lambda with !!
;; https://stackoverflow.com/a/37422551/8058988
(defmacro !! (&rest body)
  `(lambda () (interactive) ,@body))

(setq custom-file "~/.custom.el")

(setq vc-follow-symlinks t)
(setq-default dotspacemacs-configuration-layers '(
                                                  yaml
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
(setq dotspacemacs-additional-packages '(org-clock-csv org-plus-contrib solarized-theme helm-rg))
(setq dotspacemacs-excluded-packages '(powerline magit-gitflow company-tern yasnippet))
;; spacemacs speedup hack
(setq auto-window-vscroll nil)

;; Disable unicode symbols in mode line to speed up performance
(setq dotspacemacs-mode-line-unicode-symbols nil)

;; Option modifier - right option key for symbols; left for meta
(setq-default mac-right-option-modifier nil)

;; Make fullscreen sane
(setq-default dotspacemacs-fullscreen-use-non-native nil)
(setq-default dotspacemacs-maximized-at-startup t)
(setq-default ns-use-native-fullscreen nil)

(evil-leader/set-key
  "feo" (!! (find-file "~/.org-mode.el"))
  "S" 'my-org-screenshot
  "s!" 'shell
)

;; on one of my computers, melpa as a package endpoint doesn't exist for some reason
(require 'package)
(add-to-list 'package-archives
              '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;; (package-refresh-contents)

dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

(defun dotspacemacs/user-config ()
  "Configuration function for user code."
  ;; make evil-mode up/down operate in screen lines instead of logical lines
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  ;; ..also in visual mode
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line)
  )

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

;; Load rest of config
(load "~/.org-mode.el")

;; private config shared from dropbox
;; where i keep all my custom configuration that i don't want to share in version control
;; for example, i have different org files for each client i work with in my org folder
;; this allows me to have bindings such as "go to org file for client", without cluttering my public repo
(mapc 'load (file-expand-wildcards "~/Dropbox/dotfiles_private/*.el"))

(defun ediff-copy-both-to-C ()
  "Copy both diff A and B to buffer C."
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
                   (concat
                    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
(defun add-d-to-ediff-mode-map () (define-key ediff-mode-map "d" 'ediff-copy-both-to-C))
(add-hook 'ediff-keymap-setup-hook 'add-d-to-ediff-mode-map)
