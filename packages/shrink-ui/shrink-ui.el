;;; ~/src/emacs.d/packages/shrink-ui/shrink-ui.el -*- lexical-binding: t; -*-

(defun shrink-ui--line-numbers ()
  (interactive)
  (set-face-attribute 'line-number nil :height 72 :slant 'italic :weight 'ultra-light :background "#ffffff")
  (set-face-attribute 'line-number-current-line nil :height 72 :slant 'italic :weight 'bold :background "#ffffff"))

(defun shrink-ui--modeline ()
  (interactive)
  (set-face-attribute 'mode-line nil :height 72 :box nil :weight 'semi-bold)
  (set-face-attribute 'mode-line-inactive nil :height 72 :box nil :weight 'semi-bold))

(defun shrink-ui--shrink-all ()
  (shrink-ui--line-numbers)
  (shrink-ui--modeline))

(after! display-line-numbers (shrink-ui--line-numbers))

(provide 'shrink-ui)
