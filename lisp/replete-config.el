;; -*- lexical-binding: t; -*-

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

(defun replete-start-here ()
  (interactive)
  (replete-start (project-root (project-current t)))
  (switch-to-buffer-other-window replete-buffer))
