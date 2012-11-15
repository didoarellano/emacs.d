(require 'eproject)
(require 'eproject-extras)

(setq eproject-completing-read-function 'eproject--ido-completing-read)

;; Use C-x C-f for eproject-find-file if we're in a project & ido-find-file when
;; we're not
(global-set-key (kbd "C-x C-f") 'dido-do-find-file-eproject-or-ido)

;; Just in case we want regular ido-find-file in a project
(global-set-key (kbd "C-c C-x C-f") 'ido-find-file)

(global-set-key (kbd "C-x b") 'eproject-ibuffer)


(provide 'dido-eproject)
