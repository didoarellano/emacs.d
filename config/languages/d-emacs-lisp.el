(defun d-emacs-lisp-mode-hook ()
  (setq mode-name "el"))
(add-hook 'emacs-lisp-mode-hook 'd-emacs-lisp-mode-hook)

(provide 'd-emacs-lisp)
