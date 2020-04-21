(defun d-smartparens-init ()
  (smartparens-global-mode t)
  (require 'smartparens-config)
  (setq sp-highlight-pair-overlay nil))

(use-package smartparens
  :ensure t
  :init (d-smartparens-init)
  :config (sp-local-pair 'web-mode "{" "}" :actions nil))
;; (use-package evil-smartparens
;;   :ensure t)

(provide 'd-smartparens)
