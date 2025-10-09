;; -*- lexical-binding: t; -*-
;; Based on: https://def.lakaban.net/2023-03-05-high-quality-scrolling-emacs/

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

(advice-add 'pixel-scroll-precision :around #'filter-mwheel-never-coalesce)
(advice-add 'mwheel-scroll          :around #'filter-mwheel-always-coalesce)
(advice-add 'mouse-wheel-text-scale :around #'filter-mwheel-always-coalesce)
(advice-add 'tab-line-hscroll-left  :around #'filter-mwheel-always-coalesce)
(advice-add 'tab-line-hscroll-right :around #'filter-mwheel-always-coalesce)
(advice-add 'flymake--mode-line-counter-scroll-next :around #'filter-mwheel-always-coalesce)
(advice-add 'flymake--mode-line-counter-scroll-prev :around #'filter-mwheel-always-coalesce)
