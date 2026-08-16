;; -*- lexical-binding: t; -*-

;; Speed up startup
(setopt gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setopt gc-cons-threshold (car (get 'gc-cons-threshold 'standard-value)))))

(setopt custom-enabled-themes '(modus-operandi))
