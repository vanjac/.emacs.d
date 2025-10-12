;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-verbose nil)
 '(backward-delete-char-untabify-method nil)
 '(c-default-style
   '((java-mode . "java") (awk-mode . "awk") (other . "chroma")))
 '(column-number-mode t)
 '(comint-scroll-show-maximum-output nil)
 '(context-menu-mode t)
 '(cursor-type 'bar)
 '(custom-enabled-themes '(modus-operandi))
 '(delete-by-moving-to-trash t)
 '(delete-pair-blink-delay 0)
 '(delete-selection-mode t)
 '(dired-listing-switches "-al --group-directories-first")
 '(dired-mouse-drag-files 'move)
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'always)
 '(display-line-numbers-width 4)
 '(ediff-grab-mouse nil)
 '(ediff-split-window-function 'split-window-horizontally)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(editorconfig-mode t)
 '(eglot-ignored-server-capabilities '(:documentOnTypeFormattingProvider))
 '(eldoc-echo-area-prefer-doc-buffer t)
 '(electric-pair-mode t)
 '(fido-mode t)
 '(fido-vertical-mode t)
 '(frame-resize-pixelwise t)
 '(gdb-many-windows t)
 '(gdb-non-stop-setting nil)
 '(gdb-restore-window-configuration-after-quit 'if-gdb-many-windows)
 '(global-auto-revert-mode t)
 '(global-auto-revert-non-file-buffers t)
 '(global-hl-line-mode t)
 '(global-so-long-mode t)
 '(global-tab-line-mode t)
 '(global-whitespace-mode t)
 '(highlight-nonselected-windows t)
 '(icon-map-list nil)
 '(initial-buffer-choice 'messages-buffer)
 '(initial-scratch-message "")
 '(isearch-allow-scroll 'unlimited)
 '(isearch-lazy-count t)
 '(make-backup-files nil)
 '(mark-even-if-inactive nil)
 '(mode-line-percent-position nil)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount
   '(3 ((shift) . hscroll) ((meta)) ((control meta) . global-text-scale)
       ((control) . text-scale)))
 '(org-support-shift-select t)
 '(package-selected-packages '(corfu dape gptel iedit markdown-mode nhexl-mode))
 '(pixel-scroll-precision-interpolate-mice nil)
 '(pixel-scroll-precision-mode t)
 '(project-mode-line t)
 '(project-vc-merge-submodules nil)
 '(recentf-mode t)
 '(ring-bell-function 'flash-mode-line)
 '(save-place-mode t)
 '(savehist-mode t)
 '(sentence-end-double-space nil)
 '(server-stop-automatically 'delete-frame)
 '(set-mark-command-repeat-pop t)
 '(shell-command-prompt-show-cwd t)
 '(tab-line-close-button-show nil)
 '(tab-line-exclude-modes '(completion-list-mode ediff-mode))
 '(tool-bar-mode nil)
 '(treesit-font-lock-level 4)
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
(put 'mhtml-mode 'flyspell-mode-predicate #'sgml-mode-flyspell-verify)
(c-add-style "chroma"
	     '((indent-tabs-mode . t)
	       (c-basic-offset . 4)
	       (c-offsets-alist
		(arglist-cont-nonempty . +)
		(arglist-close . 0)
		(innamespace . 0)
		(label . 0))
	       ))

;;; Platform-specific:
(when (eq system-type 'gnu/linux)
  ;; note: must be installed in ~/.terminfo !
  (setopt comint-terminfo-terminal "dumb-emacs-term-color")
  (setopt mouse-wheel-tilt-scroll t)
  (setopt mouse-wheel-flip-direction t))
(when (eq system-type 'windows-nt)
  ;; Add GNU utilities to path
  (setenv "PATH" (concat "C:\\Program Files\\Git\\usr\\bin;" (getenv "PATH")))
  (push "c:/Program Files/Git/usr/bin" exec-path))

;;; Mode overrides:
(push '("\\.m?js\\'" . js-ts-mode) auto-mode-alist)
(push '("\\.ts\\'" . typescript-ts-mode) auto-mode-alist)
(push '("\\.css\\'" . css-ts-mode) auto-mode-alist)
(push '("\\.ya?ml\\'" . yaml-ts-mode) auto-mode-alist)
(push '("\\.lua\\'" . lua-ts-mode) auto-mode-alist)
(push '("\\.rs\\'" . rust-ts-mode) auto-mode-alist)

;;; Commands:
(defun visit-temp-file ()
  (interactive)
  (find-file (make-temp-file "scratch")))
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
(defun replete-start-here ()
  (interactive)
  (replete-start (project-root (project-current t)))
  (switch-to-buffer-other-window replete-buffer))
(defun set-frame-name-project (arg)
  (interactive "P")
  (set-frame-name (unless arg
		      (concat "<" (project-name (project-current)) ">"))))

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

;;; Key bindings:
(keymap-global-set "C-z" 'undo)
(keymap-global-set "C-S-z" 'undo-redo)
(keymap-global-set "C-x k" 'kill-current-buffer)
(keymap-global-set "C-x C-S-j" 'dir-jump-external)
(keymap-global-set "C-<tab>" 'previous-buffer)
(keymap-global-set "C-<iso-lefttab>" 'next-buffer)
(keymap-global-set "C-c <delete>" 'delete-pair)
(keymap-global-set "C-c t" 'visit-temp-file)
(keymap-global-set "C-c s" 'shell)
(keymap-global-set "C-c f" 'recentf-open) ;; same as Crux
(keymap-global-set "C-c c" 'quick-calc)
(keymap-global-set "C-/" project-prefix-map)
(keymap-global-set "C-/ n" 'set-frame-name-project)
(keymap-global-set "S-<down-mouse-1>" 'mouse-save-then-kill) ;; https://superuser.com/a/522183
(keymap-global-set "S-<mouse-1>" 'ignore-preserving-kill-region)
(keymap-global-set "<mode-line> C-<mouse-1>" 'tear-off-window)

;;; Other files:
(push "~/.emacs.d/lisp" load-path)
(load "drag-buffer")
(load "fix-precision-scroll")

;;; Built-in:
(use-package dired
  :bind (:map dired-mode-map
	      ("<mouse-2>" . dired-mouse-find-file))
  :hook ((dired-mode .
		     (lambda ()
		       (setq truncate-lines t)))))
(use-package project)
(use-package js
  :bind (:map js-ts-mode-map
	      ("C-x C-e" . replete-browser)
	      ("C-c /" . jsdoc-skeleton)))

;;; Installed:
(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-popupinfo-mode t)
  (corfu-popupinfo-delay '(0.5 . 0.5))
  :hook ((eglot-managed-mode . corfu-mode)
	 (mhtml-mode . corfu-mode)
	 (css-ts-mode . corfu-mode)))
(use-package iedit)
(use-package iedit-rect)
(use-package markdown-mode
  :defer t
  :custom
  (markdown-enable-wiki-links t))
(use-package nhexl-mode
  :defer t
  :init (setq nhexl--put-LF-in-string t) ; nhexl layout bug
  :bind (:map nhexl-mode-map
	      ("C-c ." . nhexl-nibble-edit-mode)))
;; https://github.com/jamesdiacono/Replete
(use-package replete
  :load-path "~/code/Replete/plugins/emacs"
  :commands replete-start
  :config
  (setq replete-default-command
	(list
	 "node"
	 (expand-file-name "~/code/Replete/replete.js")
	 "--browser_hostname=0.0.0.0"
	 "--browser_port=9325"
	 "--content_type=js:text/javascript"
	 "--content_type=mjs:text/javascript"
	 "--content_type=map:application/json"
	 "--content_type=css:text/css"
	 "--content_type=html:text/html; charset=utf-8"
	 "--content_type=wasm:application/wasm"
	 "--content_type=woff2:font/woff2"
	 "--content_type=svg:image/svg+xml"
	 "--content_type=png:image/png"
	 "--content_type=webp:image/webp"
	 "--content_type=json:application/json")))
