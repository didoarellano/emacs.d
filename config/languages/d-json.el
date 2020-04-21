(defun d-json-mode-init ()
  (defun d-json-mode-hook ()
    (setq mode-name "json")
    (setq flycheck-checker 'json-jsonlint)
    (flycheck-mode)
    (setq tab-width 2)
    (setq-local js-indent-level 2))
  (add-hook 'json-mode-hook 'd-json-mode-hook))

(use-package json-mode
  :ensure t
  :mode (".jshintrc" ".tern-project")
  :init (d-json-mode-init))
(use-package json-reformat
  :ensure t
  :init (setq json-reformat:indent-width 2))

(provide 'd-json)
