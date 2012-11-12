(require 'eproject)
(require 'eproject-extras)

(setq eproject-completing-read-function 'eproject--ido-completing-read)

;; Use C-x C-f for eproject-find-file if we're in a project & ido-find-file when
;; we're not
(global-set-key (kbd "C-x C-f") 'dido-do-find-file-eproject-or-ido)

(global-set-key (kbd "C-x b") 'eproject-ibuffer)


(provide 'dido-eproject)
