(defun d-jade-mode-hook ()
  (require 'company-web-jade)
  (setq-local company-backends '((company-web-jade company-dabbrev-code) company-dabbrev company-files))

  (setq mode-name "jade"))

(defun d-jade-mode-init()
  (add-hook 'jade-mode-hook 'd-jade-mode-hook))

(use-package jade-mode
  :ensure t
  :mode ("\\.jade$" "\\.pug$")
  :init (d-jade-mode-init))

(provide 'd-jade)
