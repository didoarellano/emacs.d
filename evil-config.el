;; Evil-mode
(require 'evil)

(evil-set-initial-state 'package-menu-mode 'motion)

;; Cursor is black without this
(setq evil-default-cursor t)

(setq evil-normal-state-tag "N"
      evil-insert-state-tag "I"
      evil-visual-state-tag "V"
      evil-motion-state-tag "M"
      evil-emacs-state-tag "E"
      evil-replace-state-tag "R"
      evil-operator-state-tag "O")

(evil-mode 1)

(require 'surround)
(global-surround-mode 1)


(provide 'evil-config)
