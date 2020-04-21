(defun d-web-mode-hook ()
  ;; (tern-mode t)
  (define-key web-mode-map (kbd "M-RET") 'web-mode-block-close)
  (require 'company-web-html)
  (flycheck-mode)
  (setq-local company-backends '((company-web-html company-dabbrev-code) company-dabbrev company-files))
  (setq mode-name "web"))

(defun d-web-mode-init ()
  (setq web-mode-auto-close-style 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-style-padding 2)
  (setq web-mode-script-padding 2)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-engine-detection t)

  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.twig$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

  (setq web-mode-engines-alist
        '(("php"    . "\\.php?\\'")
          ("django" . "\\.djhtml\\'")))

  (evil-define-key 'insert web-mode-map (kbd "<RET>") 'd-html-expand-newline-if-between-tags)
  (add-hook 'web-mode-hook 'd-web-mode-hook))

(use-package web-mode
  :ensure t
  :init (d-web-mode-init))

(provide 'd-web-mode)
