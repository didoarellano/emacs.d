(add-hook 'sgml-mode-hook
          (lambda ()
            (require 'zencoding-mode)
            (zencoding-mode)
            (setq zencoding-indentation sgml-basic-offset)
            (define-key zencoding-mode-keymap (kbd "C-j") nil)
            (define-key zencoding-mode-keymap (kbd "<C-return>") nil)
            (define-key zencoding-mode-keymap (kbd "<M-return>") 'zencoding-expand-line)))


(provide 'zencoding-mode-config)
