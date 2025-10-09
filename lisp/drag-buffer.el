;; -*- lexical-binding: t; -*-

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

(keymap-set mode-line-buffer-identification-keymap "<mode-line> <down-mouse-1>" 'ignore)
(keymap-set mode-line-buffer-identification-keymap "<mode-line> <drag-mouse-1>" 'mouse-move-buffer)
(keymap-set mode-line-buffer-identification-keymap
	    "<mode-line> C-<drag-mouse-1>" 'mouse-drag-buffer)
