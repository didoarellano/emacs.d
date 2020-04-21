(defun d-magit-mode-hook ()
  ;; Turn off evil-surround to make magit keybindings in visual state work.
  (evil-surround-mode -1))

(defun d-magit-stage-item-visual-state ()
  )

(defun d-magit-init ()
  (setq magit-last-seen-setup-instructions "1.4.0")
  (setq magit-status-buffer-switch-function 'switch-to-buffer)
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  (evil-leader/set-key "gb" 'magit-blame-mode)
  (evil-leader/set-key "gl" 'magit-log)
  (evil-leader/set-key "gs" 'magit-status)
  (evil-leader/set-key "gC" 'magit-commit)

  (evil-set-initial-state 'magit-popup-mode 'emacs)
  (add-hook 'magit-mode-hook 'd-magit-mode-hook))

(defun d-magit-config ()
  ;; TODO Include the whole evil-rebellion repo as a git subtree
  ;; (require 'evil-magit-rebellion)

  ;; (evil-define-key 'motion magit-mode-map "j" 'next-line)
  ;; (evil-define-key 'motion magit-mode-map "k" 'previous-line)
  ;; (evil-define-key 'motion magit-mode-map "}" 'magit-goto-next-section)
  ;; (evil-define-key 'motion magit-mode-map "{" 'magit-goto-previous-section)
  ;; (evil-define-key 'motion magit-mode-map "v" 'evil-visual-char)
  ;; (evil-define-key 'motion magit-mode-map "V" 'evil-visual-line)

  ;; (evil-define-key 'visual magit-mode-map "s" 'magit-stage-item)
  ;; (evil-define-key 'visual magit-mode-map "u" 'magit-unstage-item)
  ;; (evil-define-key 'visual magit-mode-map "d" 'magit-discard-item)

  (setq magit-completing-read-function 'magit-ido-completing-read))

(use-package magit
  :ensure t
  :init (d-magit-init)
  :config (d-magit-config))

(use-package evil-magit
  :ensure t)

(provide 'd-magit)
