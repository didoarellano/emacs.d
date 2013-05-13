(setq flycheck-highlighting-mode 'lines)

(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'emacs-lisp-mode-hook
          (lambda()
            (flycheck-mode -1)))


(provide 'dido-flycheck)
