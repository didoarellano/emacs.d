(require 'smex)

(smex-initialize)

;; Smexify my M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; This is the old M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Don't poop in my home directory
(setq smex-save-file (concat user-tmp-directory "smex-items"))

(setq smex-key-advice-ignore-menu-bar t)

(provide 'smex-config)
