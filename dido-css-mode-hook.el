(setq mode-name "css")
(setq css-indent-offset 2)

(define-key evil-insert-state-local-map
  (kbd "C-;") 'dido-insert-semicolon-at-eol)


(provide 'dido-css-mode-hook)
