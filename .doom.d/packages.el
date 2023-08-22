;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
(package! gruvbox-theme)

(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
