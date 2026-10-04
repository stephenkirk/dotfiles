;;; init.el -*- lexical-binding: t; -*-

;; Enabled modules, in load order. Run doom sync after changing this list.
;; Press K on a module or flag to read its documentation.

(doom! :input

       :completion
       (company +childframe)
       ivy

       :ui
       doom
       doom-dashboard
       doom-quit
       hl-todo
       modeline
       neotree
       ophints
       (popup +defaults)
       vc-gutter
       vi-tilde-fringe
       workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       snippets

       :emacs
       dired
       electric
       undo
       vc

       :term
       vterm

       :checkers
       syntax

       :tools
       (eval +overlay)
       lookup
       (magit +forge)

       :os
       (:if IS-MAC macos)

       :lang
       csharp
       emacs-lisp
       json
       lua
       markdown
       org
       sh

       :email

       :app

       :config
       (default +bindings +smartparens))
