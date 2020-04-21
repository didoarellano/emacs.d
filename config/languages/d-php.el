(defun d-php-mode-init ()
  (add-hook 'php-mode-hook 'd-php-mode-hook))

(defun d-php-mode-hook ()
  (flycheck-mode)
  (setq mode-name "php"))

(use-package php-mode
  :ensure t
  :init (d-php-mode-init))

(provide 'd-php)
