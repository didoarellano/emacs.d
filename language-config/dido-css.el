(evil-define-key 'insert css-mode-map (kbd "C-;") 'dido-insert-semicolon-at-eol)

(add-hook 'css-mode-hook
          (lambda ()
            (setq mode-name "css")
            (setq css-indent-offset 2)
            ))

(add-hook 'scss-mode-hook
          (lambda ()
            (setq mode-name "scss")
            (setq scss-compile-at-save nil)
            (flycheck-mode)
            ))

(provide 'dido-css)
