;; Zencoding mode
(require 'zencoding-mode)
(zencoding-mode)
(setq zencoding-indentation 2)
(define-key zencoding-mode-keymap (kbd "C-j") nil)
(define-key zencoding-mode-keymap (kbd "<C-return>") nil)
(define-key zencoding-mode-keymap (kbd "<M-return>") 'zencoding-expand-line)


(provide 'html-mode-hook-config)
