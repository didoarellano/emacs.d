;;; ~/src/emacs.d/packages/duplicate-frame/duplicate-frame.el -*- lexical-binding: t; -*-

(defun duplicate-frame ()
  (interactive)
  (let ((current-buffer (current-buffer)))
    (make-frame)
    (switch-to-buffer current-buffer)))

(provide 'duplicate-frame)
