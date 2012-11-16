(evil-define-key 'insert css-mode-map (kbd "C-;") 'dido-insert-semicolon-at-eol)

(add-hook 'css-mode-hook
          (lambda ()
            (setq mode-name "css")
            (setq css-indent-offset 2)
            ))


(provide 'dido-css)
