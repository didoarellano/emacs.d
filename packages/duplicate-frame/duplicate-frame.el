;;; ~/src/emacs.d/packages/duplicate-frame/duplicate-frame.el -*- lexical-binding: t; -*-

(defun duplicate-frame ()
  (interactive)
  (let (new-frame (make-frame)
                  (current-buffer (current-buffer)))
    (switch-to-buffer-other-frame new-frame)
    (switch-to-buffer current-buffer)))

(provide 'duplicate-frame)
