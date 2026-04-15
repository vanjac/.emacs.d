;; -*- lexical-binding: t; -*-

(defvar menu-bar-mode-menu (make-sparse-keymap "Mode"))
(keymap-set-after menu-bar-edit-menu "<mode>"
  (cons "Major Mode" menu-bar-mode-menu) 'fill)
(keymap-set menu-bar-mode-menu "<conf>" '("Conf" . conf-mode))
(keymap-set menu-bar-mode-menu "<sep-conf>" menu-bar-separator)
(keymap-set menu-bar-mode-menu "<prog>" '("Prog" . prog-mode))
(keymap-set menu-bar-mode-menu "<sep-prog>" menu-bar-separator)
(keymap-set menu-bar-mode-menu "<markdown>" '("Markdown" . markdown-mode))
(keymap-set menu-bar-mode-menu "<org>" '("Org" . org-mode))
(keymap-set menu-bar-mode-menu "<text>" '("Text" . text-mode))
(keymap-set menu-bar-mode-menu "<sep-text>" menu-bar-separator)
(keymap-set menu-bar-mode-menu "<clean>" '("Clean" . clean-mode))
(keymap-set menu-bar-mode-menu "<fundamental>" '("Fundamental" . fundamental-mode))
(keymap-set menu-bar-mode-menu "<sep-fundamental>" menu-bar-separator)
(keymap-set menu-bar-mode-menu "<normal>" '("Normal" . normal-mode))
