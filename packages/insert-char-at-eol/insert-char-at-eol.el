;;; ~/src/emacs.d/packages/insert-char-at-eol/insert-char-at-eol.el -*- lexical-binding: t; -*-

(defun insert-char-at-eol (char)
  "Append char at end-of-line and maintain position of point"
  (interactive)
  (save-excursion
    (end-of-line)
    (insert char)))

(provide 'insert-char-at-eol)
