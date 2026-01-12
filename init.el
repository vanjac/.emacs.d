;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-verbose nil)
 '(backward-delete-char-untabify-method nil)
 '(column-number-mode t)
 '(comint-scroll-show-maximum-output nil)
 '(completion-styles '(flex))
 '(context-menu-mode t)
 '(cursor-type 'bar)
 '(custom-enabled-themes '(modus-operandi))
 '(delete-by-moving-to-trash t)
 '(delete-pair-blink-delay 0)
 '(delete-selection-mode t)
 '(display-line-numbers-width 4)
 '(editorconfig-mode t)
 '(electric-pair-mode t)
 '(enable-recursive-minibuffers t)
 '(frame-resize-pixelwise t)
 '(global-auto-revert-mode t)
 '(global-auto-revert-non-file-buffers t)
 '(global-hl-line-mode t)
 '(global-so-long-mode t)
 '(global-tab-line-mode t)
 '(global-whitespace-mode t)
 '(highlight-nonselected-windows t)
 '(initial-buffer-choice 'messages-buffer)
 '(initial-scratch-message "")
 '(isearch-allow-scroll 'unlimited)
 '(isearch-lazy-count t)
 '(make-backup-files nil)
 '(mark-even-if-inactive nil)
 '(minibuffer-depth-indicate-mode t)
 '(mode-line-percent-position nil)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount
   '(3 ((shift) . hscroll) ((meta)) ((control meta) . global-text-scale)
       ((control) . text-scale)))
 '(mouse-wheel-tilt-scroll t)
 '(package-selected-packages '(corfu dape gptel iedit markdown-mode nhexl-mode vertico))
 '(read-buffer-completion-ignore-case t)
 '(read-extended-command-predicate 'command-completion-default-include-p)
 '(read-file-name-completion-ignore-case t)
 '(recentf-mode t)
 '(register-use-preview nil)
 '(ring-bell-function 'flash-mode-line)
 '(save-place-mode t)
 '(savehist-mode t)
 '(sentence-end-double-space nil)
 '(server-stop-automatically 'delete-frame)
 '(set-mark-command-repeat-pop t)
 '(shell-command-prompt-show-cwd t)
 '(tab-line-close-button-show nil)
 '(tab-line-exclude-modes '(completion-list-mode ediff-mode))
 '(tab-line-tab-name-function 'tab-line-tab-name-truncated-buffer)
 '(tool-bar-mode nil)
 '(use-package-compute-statistics t)
 '(use-package-verbose t)
 '(whitespace-global-modes '(prog-mode))
 '(whitespace-line-column 100)
 '(whitespace-style
   '(face trailing tabs lines missing-newline-at-eof empty indentation
	  space-after-tab space-before-tab tab-mark))
 '(window-divider-mode t)
 '(window-resize-pixelwise t)
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka Fixed" :foundry "UKWN" :slant normal :weight regular :height 120 :width normal)))))

;;; Additional (manual) customization:
(setq-default electric-indent-inhibit t)
(setq frame-title-format
      '(""
	(:eval (let ((project (project-current)))
		 (when project
		   (format "%s - " (project-name project)))))
	"%b"))

;;; Platform-specific:
(when (eq system-type 'gnu/linux)
  ;; note: must be installed in ~/.terminfo !
  (setopt comint-terminfo-terminal "dumb-emacs-term-color")
  (setopt mouse-wheel-flip-direction t))
(when (eq system-type 'windows-nt)
  ;; Add GNU utilities to path
  (setenv "PATH" (concat "C:\\Program Files\\Git\\usr\\bin;" (getenv "PATH")))
  (push "c:/Program Files/Git/usr/bin" exec-path)
  (setenv "PYTHONUNBUFFERED" "1")
  (keymap-global-set "<right-fringe> C-<mouse-2>" 'mouse-split-window-vertically)
  ;; Broken on Windows:
  (fmakunbound 'pcomplete/git))

;;; Mode overrides:
(push '("\\.m?js\\'" . js-ts-mode) auto-mode-alist)
(push '("\\.ts\\'" . typescript-ts-mode) auto-mode-alist)
(push '("\\.css\\'" . css-ts-mode) auto-mode-alist)
(push '("\\.ya?ml\\'" . yaml-ts-mode) auto-mode-alist)
(push '("\\.lua\\'" . lua-ts-mode) auto-mode-alist)
(push '("\\.rs\\'" . rust-ts-mode) auto-mode-alist)
(push '("\\.go\\'" . go-ts-mode) auto-mode-alist)

;;; Commands:
(defun insert-surrounding-spaces ()
  (interactive)
  (let (deactivate-mark)
    (save-excursion
      (goto-char (region-beginning))
      (insert " "))
    (save-excursion
      (goto-char (region-end))
      (insert-before-markers " "))))
(defun visit-temp-file ()
  (interactive)
  (find-file (make-temp-file "scratch-")))
(defun git-diff ()
  "Show diff between working tree and staging area."
  (interactive)
  (let ((bufname "*git-diff*"))
    (when (get-buffer bufname)
      (kill-buffer bufname))
    (with-current-buffer (get-buffer-create bufname)
      (insert (shell-command-to-string "git diff"))
      (diff-mode)
      (read-only-mode)
      (beginning-of-buffer)
      (pop-to-buffer (current-buffer)))))
(defvar file-manager-dbus-name "org.freedesktop.FileManager1")
(defun dir-jump-external ()
  (interactive)
  (let ((path (or buffer-file-name (expand-file-name default-directory))))
    (when (eq system-type 'gnu/linux)
      (call-process "gdbus" nil 0 nil "call" "--session"
		    "--dest" file-manager-dbus-name
		    "--object-path" "/org/freedesktop/FileManager1"
		    "--method" "org.freedesktop.FileManager1.ShowItems"
		    (concat "['file://" path "']")
		    ""))))
(defun project-delete-frame ()
  (interactive)
  (if (project-kill-buffers)
      (delete-frame)))

(defun flash-mode-line ()
  "Visual bell function from EmacsWiki"
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil #'invert-face 'mode-line))
;; from: https://endlessparentheses.com/ansi-colors-in-the-compilation-buffer-output.html
(defun colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(define-skeleton jsdoc-skeleton "Insert JSDoc comment" nil
  "/**" _ "*/")

;;; Enabled commands:
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;;; Hooks:
(add-hook 'comint-output-filter-functions 'comint-osc-process-output)
(add-hook 'compilation-filter-hook 'colorize-compilation)
(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode 1)
	    (visual-wrap-prefix-mode 1)
	    (setq tab-width 4)))
(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (setq tab-width 8)))
(add-hook 'overwrite-mode-hook
	  (lambda ()
	    (setq-local cursor-type (if overwrite-mode 'box 'bar))))

;;; Menus:
(keymap-set-after menu-bar-file-menu "<temp-file>"
  '("Temporary File" . visit-temp-file) 'new-file)
(keymap-set-after menu-bar-file-menu "<dir-jump-external>"
  '("Show in Folder" . dir-jump-external) 'project-dired)
(keymap-set-after menu-bar-file-menu "<rename-file>"
  '("Move To..." . rename-visited-file) 'write-file)
(keymap-unset menu-bar-file-menu "<make-tab>")
(keymap-unset menu-bar-file-menu "<close-tab>")
(keymap-unset menu-bar-file-menu "<separator-tab>")
(keymap-set-after menu-bar-tools-menu "<locate>"
  '("Locate..." . locate) 'rgrep)
(keymap-set-after menu-bar-shell-commands-menu "<term>"
  '("Terminal Emulator" . ansi-term))

;;; Key bindings:
(keymap-global-set "C-z" 'undo)
(keymap-global-set "C-S-z" 'undo-redo)
(keymap-global-set "C-x k" 'kill-current-buffer)
(keymap-global-set "C-<tab>" 'previous-buffer)
(keymap-global-set "C-<iso-lefttab>" 'next-buffer)
(keymap-global-set "C-S-<tab>" 'next-buffer)
(keymap-global-set "C-c <delete>" 'delete-pair)
(keymap-global-set "C-c SPC" 'insert-surrounding-spaces)
(keymap-global-set "C-c t" 'visit-temp-file)
(keymap-global-set "C-c s" 'shell)
(keymap-global-set "C-c c" 'quick-calc)
(keymap-global-set "C-/" project-prefix-map)
(keymap-global-set "C-/ 4" 'project-other-window-command)
(keymap-global-set "C-/ 5" 'project-other-frame-command)
(keymap-global-set "C-/ 0" 'project-delete-frame)
(keymap-global-set "S-<down-mouse-1>" 'mouse-save-then-kill) ;; https://superuser.com/a/522183
(keymap-global-set "S-<mouse-1>" 'ignore-preserving-kill-region)
(keymap-global-set "<mode-line> C-<mouse-1>" 'tear-off-window)

;;; Other files:
(push "~/.emacs.d/lisp" load-path)
(load "drag-buffer")
(load "custom-comint")
(load "replete-config")

;;; Built-in:
(use-package dired
  :bind (:map dired-mode-map
	      ("<mouse-2>" . dired-mouse-find-file))
  :config
  (keymap-set-after dired-mode-immediate-menu "<find-name>"
    '("Find Name Recursively..." . find-name-dired) 'Isearch\ Regexp\ in\ File\ Names...)
  :custom
  (dired-listing-switches "-al --group-directories-first")
  (dired-mouse-drag-files 'move)
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  :hook ((dired-mode .
		     (lambda ()
		       (setq truncate-lines t)))))
(use-package project
  :config
  (push '(project-dired "Dired") project-switch-commands)
  :custom
  (project-mode-line t)
  (project-vc-merge-submodules nil))
(use-package treesit
  :defer t
  :custom
  (treesit-font-lock-level 4))
(use-package eldoc
  :defer t
  :custom
  (eldoc-echo-area-prefer-doc-buffer t)
  (eldoc-minor-mode-string nil))
(use-package eglot
  :defer t
  :custom
  (eglot-ignored-server-capabilities '(:documentOnTypeFormattingProvider)))
(use-package vc-git
  :defer t
  :config
  (defun vc-git-mode-line-string (file) "Git"))
(use-package ediff
  :defer t
  :custom
  (ediff-grab-mouse nil)
  (ediff-split-window-function 'split-window-horizontally)
  (ediff-window-setup-function 'ediff-setup-windows-plain))
(use-package term
  :defer t
  :hook ((term-mode .
		    (lambda ()
		      (setq-local global-hl-line-mode nil)
		      (setq-local cursor-type 'box)))))
(use-package gdb-mi
  :defer t
  :custom
  (gdb-many-windows t)
  (gdb-non-stop-setting nil)
  (gdb-restore-window-configuration-after-quit 'if-gdb-many-windows))
(use-package locate
  :defer t
  :custom
  (locate-update-path "/sudo::")
  (locate-update-when-revert t))
(use-package doc-view
  :defer t
  :custom
  (doc-view-continuous t))
(use-package org
  :defer t
  :custom
  (org-support-shift-select t))
(use-package cc-mode
  :defer t
  :config
  (c-add-style "chroma"
	       '((indent-tabs-mode . t)
		 (c-basic-offset . 4)
		 (c-offsets-alist
		  (arglist-cont-nonempty . +)
		  (arglist-close . 0)
		  (innamespace . 0)
		  (label . 0))
		 ))
  :custom
  (c-default-style
   '((java-mode . "java") (awk-mode . "awk") (other . "chroma"))))
(use-package js
  :bind (:map js-ts-mode-map
	      ("C-x C-e" . replete-browser)
	      ("C-c /" . jsdoc-skeleton)))
(use-package mhtml-mode
  :defer t
  :config
  (put 'mhtml-mode 'flyspell-mode-predicate #'sgml-mode-flyspell-verify))
(use-package tcl
  :defer t
  :custom
  (tcl-application "tclsh"))

;;; Installed:
(use-package vertico
  :custom
  (vertico-mouse-mode t)
  :init
  (vertico-mode))
(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-popupinfo-mode t)
  (corfu-popupinfo-delay '(0.5 . 0.5))
  :hook ((prog-mode . corfu-mode)
	 (comint-mode . corfu-mode)
	 (sgml-mode . corfu-mode)))
(use-package iedit)
(use-package iedit-rect)
(use-package markdown-mode
  :defer t
  :custom
  (markdown-enable-wiki-links t))
(use-package nhexl-mode
  :init (setq nhexl--put-LF-in-string t) ; nhexl layout bug
  :bind (:map nhexl-mode-map
	      ("C-c ." . nhexl-nibble-edit-mode)))
