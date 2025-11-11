;; -*- lexical-binding: t; -*-

(defun frotz-comint (filename)
  (interactive "fStory file: ")
  (switch-to-buffer (make-comint "dfrotz" "dfrotz" nil "-m" (expand-file-name filename))))
