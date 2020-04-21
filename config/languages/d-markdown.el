(defun d-markdown-mode-init ()
  (defun d-markdown-mode-hook ()
    (setq mode-name "markdown"))
  (add-hook 'markdown-mode-hook 'd-markdown-mode-hook))

(use-package markdown-mode
  :ensure t
  :init (d-markdown-mode-init))

(provide 'd-markdown)
