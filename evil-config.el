;; Evil-mode
(require 'evil)
(evil-mode 1)

(evil-set-initial-state 'package-menu-mode 'motion)

;; Cursor is black without this
(setq evil-default-cursor t)

(require 'surround)
(global-surround-mode 1)


(provide 'evil-config)
