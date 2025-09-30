;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-verbose nil)
 '(backup-by-copying t)
 '(backup-directory-alist '((".*" . "~/.emacs_backups/")))
 '(backward-delete-char-untabify-method nil)
 '(c-default-style
   '((java-mode . "java") (awk-mode . "awk") (other . "chroma")))
 '(column-number-mode t)
 '(comint-scroll-show-maximum-output nil)
 '(comint-terminfo-terminal "dumb-emacs-term-color")
 '(context-menu-mode t)
 '(corfu-auto t)
 '(corfu-popupinfo-delay '(0.5 . 0.5))
 '(corfu-popupinfo-mode t)
 '(cursor-type 'bar)
 '(custom-enabled-themes '(modus-operandi))
 '(delete-by-moving-to-trash t)
 '(delete-pair-blink-delay 0)
 '(delete-selection-mode t)
 '(dired-hide-details-hide-information-lines nil)
 '(dired-hide-details-hide-symlink-targets nil)
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
 '(global-tab-line-mode t)
 '(global-whitespace-mode t)
 '(highlight-nonselected-windows t)
 '(icon-map-list nil)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice 'recentf-open-files)
 '(initial-scratch-message "")
 '(isearch-allow-scroll 'unlimited)
 '(isearch-lazy-count t)
 '(mark-even-if-inactive nil)
 '(markdown-enable-wiki-links t)
 '(mode-line-percent-position nil)
 '(mouse-wheel-flip-direction t)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-tilt-scroll t)
 '(package-selected-packages '(corfu dape iedit markdown-mode nhexl-mode))
 '(pixel-scroll-precision-interpolate-mice nil)
 '(pixel-scroll-precision-mode t)
 '(project-mode-line t)
 '(project-vc-merge-submodules nil)
 '(recentf-mode t)
 '(ring-bell-function 'flash-mode-line)
 '(savehist-mode t)
 '(sentence-end-double-space nil)
 '(server-stop-automatically 'delete-frame)
 '(set-mark-command-repeat-pop t)
 '(tab-line-close-button-show nil)
 '(tab-line-exclude-modes '(completion-list-mode ediff-mode))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(treesit-font-lock-level 4)
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

(require 'dired-x)
(require 'iedit)
(require 'iedit-rect)
;; https://github.com/jamesdiacono/Replete
(require 'replete "~/code/Replete/plugins/emacs/replete.el")

;; Additional (manual) customization:
(setq-default electric-indent-inhibit t)
(put 'mhtml-mode 'flyspell-mode-predicate #'sgml-mode-flyspell-verify)
(setq nhexl--put-LF-in-string t) ;; nhexl layout bug
(setq replete-command
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
	"--content_type=json:application/json"))

;; Mode overrides:
(push '("\\.m?js\\'" . js-ts-mode) auto-mode-alist)
(push '("\\.ts\\'" . typescript-ts-mode) auto-mode-alist)
(push '("\\.css\\'" . css-ts-mode) auto-mode-alist)
(push '("\\.ya?ml\\'" . yaml-ts-mode) auto-mode-alist)
(push '("\\.lua\\'" . lua-ts-mode) auto-mode-alist)
(push '("\\.rs\\'" . rust-ts-mode) auto-mode-alist)

;; Commands:
(defun visit-temp-file ()
  (interactive)
  (find-file (make-temp-file "scratch")))
(defun replete-start-here ()
  (interactive)
  (setq replete-cwd (project-root (project-current t)))
  (replete-start)
  (switch-to-buffer-other-window "*replete*"))
(defun set-frame-name-project (arg)
  (interactive "P")
  (set-frame-name (unless arg
		      (concat "<" (project-name (project-current)) ">"))))
(defun mouse-drag-buffer (event)
  "Drag the buffer name in the mode line to another window or a new frame."
  (interactive "e")
  (mouse-drag-buffer-impl event nil))
(defun mouse-move-buffer (event)
  "Drag the buffer name in the mode line to another window or a new frame.
   Close the buffer in the previous window"
  (interactive "e")
  (mouse-drag-buffer-impl event t))
(defun mouse-drag-buffer-impl (event move)
  (if-let* ((window1 (posn-window (event-start event)))
	    (buffer1 (window-buffer window1))
	    (mouse-pos (mouse-position))
	    (frame2 (car mouse-pos))
	    (x2 (cadr mouse-pos))
	    (y2 (cddr mouse-pos)))
      (when-let* ((window2 (window-at x2 y2 frame2)))
	  (set-window-buffer window2 buffer1)
	  (when (and move (not (eq window1 window2)))
	    (switch-to-prev-buffer window1 'bury)))
    (display-buffer buffer1 '(display-buffer-pop-up-frame))
    (when move (switch-to-prev-buffer window1 'bury))))
;; https://def.lakaban.net/2023-03-05-high-quality-scrolling-emacs/
(defun filter-mwheel-always-coalesce (orig &rest args)
  "A filter function suitable for :around advices that ensures only
   coalesced scroll events reach the advised function."
  (if mwheel-coalesce-scroll-events
      (apply orig args)
    (setq mwheel-coalesce-scroll-events t)))
(defun filter-mwheel-never-coalesce (orig &rest args)
  "A filter function suitable for :around advices that ensures only
   non-coalesced scroll events reach the advised function."
  (if mwheel-coalesce-scroll-events
      (setq mwheel-coalesce-scroll-events nil)
    (apply orig args)))
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

;; Skeletons:
(define-skeleton jsdoc-skeleton "Insert JSDoc comment" nil
  "/**" _ "*/")

;; Hooks:
(add-hook 'comint-output-filter-functions 'comint-osc-process-output)
(add-hook 'compilation-filter-hook 'colorize-compilation)
(add-hook 'dired-mode-hook
	  (lambda ()
	    (dired-hide-details-mode t)))
(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode 1)
	    (visual-wrap-prefix-mode 1)))
(add-hook 'comint-mode-hook
	  (lambda ()
	    (setq tab-width 8)))
(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (setq tab-width 8)))
(add-hook 'eglot-managed-mode-hook
	  (lambda ()
	    (corfu-mode t)))
(add-hook 'mhtml-mode-hook
	  (lambda ()
	    (corfu-mode t)))
(add-hook 'css-ts-mode-hook
	  (lambda ()
	    (corfu-mode t)))
(add-hook 'python-mode-hook
	  (lambda ()
	   (setq tab-width 4)))
(add-hook 'overwrite-mode-hook
	  (lambda ()
	    (setq-local cursor-type (if overwrite-mode 'box 'bar))))

;; Advice:
;; https://def.lakaban.net/2023-03-05-high-quality-scrolling-emacs/
(advice-add 'pixel-scroll-precision :around #'filter-mwheel-never-coalesce)
(advice-add 'mwheel-scroll          :around #'filter-mwheel-always-coalesce)
(advice-add 'mouse-wheel-text-scale :around #'filter-mwheel-always-coalesce)
(advice-add 'tab-line-hscroll-left  :around #'filter-mwheel-always-coalesce)
(advice-add 'tab-line-hscroll-right :around #'filter-mwheel-always-coalesce)
(advice-add 'flymake--mode-line-counter-scroll-next :around #'filter-mwheel-always-coalesce)
(advice-add 'flymake--mode-line-counter-scroll-prev :around #'filter-mwheel-always-coalesce)

;; Key bindings:
(keymap-global-set "C-z" 'undo)
(keymap-global-set "C-S-z" 'undo-redo)
(keymap-global-set "C-/" project-prefix-map)
(keymap-global-set "C-x k" 'kill-current-buffer)
(keymap-global-set "S-<down-mouse-1>" 'mouse-save-then-kill) ;; https://superuser.com/a/522183
(keymap-global-set "S-<mouse-1>" 'ignore-preserving-kill-region)
(keymap-global-set "C-<tab>" 'previous-buffer)
(keymap-global-set "C-<iso-lefttab>" 'next-buffer)
(keymap-global-set "C-c <delete>" 'delete-pair)
(keymap-global-set "C-c t" 'visit-temp-file)
(keymap-global-set "C-c s" 'shell)
(keymap-global-set "C-c f" 'recentf-open) ;; same as Crux
(keymap-global-set "C-c c" 'quick-calc)
(keymap-global-set "C-/ n" 'set-frame-name-project)
(keymap-global-set "<mode-line> C-<mouse-1>" 'tear-off-window)
(keymap-set dired-mode-map "<mouse-2>" 'dired-mouse-find-file)
(keymap-set mode-line-buffer-identification-keymap "<mode-line> <down-mouse-1>" 'ignore)
(keymap-set mode-line-buffer-identification-keymap "<mode-line> <drag-mouse-1>" 'mouse-move-buffer)
(keymap-set mode-line-buffer-identification-keymap "<mode-line> C-<drag-mouse-1>" 'mouse-drag-buffer)
(with-eval-after-load "nhexl-mode"
  (keymap-set nhexl-mode-map "C-c ." 'nhexl-nibble-edit-mode))
(add-hook 'js-ts-mode-hook
	  (lambda ()
	    (keymap-local-set "C-x C-e" 'replete-browser)
	    (keymap-local-set "C-c /" 'jsdoc-skeleton)))

;; Formatting:
(c-add-style "chroma"
	     '((indent-tabs-mode . t)
	       (c-basic-offset . 4)
	       (c-offsets-alist
		(arglist-cont-nonempty . +)
		(arglist-close . 0)
		(innamespace . 0)
		(label . 0))
	       ))

;; Enabled commands
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
