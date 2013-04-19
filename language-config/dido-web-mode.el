(add-hook 'web-mode-hook
          (lambda()
            (setq mode-name "web")
            (setq web-mode-code-indent-offset 4)
            ))

(provide 'dido-web-mode)
