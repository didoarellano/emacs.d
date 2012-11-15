(require 'smex)
(smex-initialize)
(setq smex-key-advice-ignore-menu-bar t)

;; Don't poop in my home directory
(setq smex-save-file (concat dido-tmp-directory "smex-items"))

;; Smexify my M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; This is the old M-x
(global-set-key (kbd "C-c M-x") 'execute-extended-command)


(provide 'dido-smex)
