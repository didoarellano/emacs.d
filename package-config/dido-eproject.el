(require 'eproject)
(require 'eproject-extras)

(setq eproject-completing-read-function 'eproject--ido-completing-read)

(define-key eproject-mode-map (kbd "C-c C-f") nil)
(define-key eproject-mode-map (kbd "C-c C-b") nil)

(global-set-key (kbd "C-c B") 'eproject-ibuffer)

(provide 'dido-eproject)
