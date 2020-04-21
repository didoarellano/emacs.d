(defun d-html-mode-hook ()
  (setq mode-name "html"))
(add-hook 'html-mode-hook 'd-html-mode-hook)

(provide 'd-html)
