(defun d-yaml-mode-init ()
  (defun d-yaml-mode-hook ()
    (setq mode-name "yaml"))
  (add-hook 'yaml-mode-hook 'd-yaml-mode-hook))

(use-package yaml-mode
  :ensure t
  :init (d-yaml-mode-init))

(provide 'd-yaml)
