;;; ~/src/emacs.d/packages/toggle-visual-wrap/toggle-visual-wrap.el -*- lexical-binding: t; -*-

(defun toggle-visual-wrap ()
  (interactive)
  (if (null visual-line-mode)
      (progn
        (visual-line-mode)
        (visual-fill-column-mode))
    (visual-line-mode 0)
    (visual-fill-column-mode 0)))

(provide 'toggle-visual-wrap)
