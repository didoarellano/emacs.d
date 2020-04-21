(defun d-flycheck-toggle-highlighting ()
  (interactive)
  (if (eq flycheck-highlighting-mode 'symbols)
      (progn
        (setq flycheck-highlighting-mode nil)
        (setq flycheck-display-errors-function nil))
    (progn
      (setq flycheck-highlighting-mode 'symbols)
      (setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
  (flycheck-buffer))

(defun d-flycheck-init ()
  ;; (add-hook 'after-init-hook #'global-flycheck-mode)
  (setq flycheck-completion-system 'ido)
  (setq flycheck-highlighting-mode nil)
  (setq flycheck-indication-mode nil)
  (setq flycheck-display-errors-function nil)
  (setq flycheck-display-errors-delay 0.3)

  (evil-leader/set-key "es" 'd-flycheck-toggle-highlighting)
  (evil-leader/set-key "el" 'flycheck-list-errors)
  (evil-leader/set-key "ef" 'flycheck-first-error)
  (evil-leader/set-key "en" 'flycheck-next-error)
  (evil-leader/set-key "ep" 'flycheck-previous-error)
)

(use-package flycheck
  :ensure t
  :init (d-flycheck-init))
(use-package flycheck-pos-tip
  :ensure t)

(provide 'd-flycheck)
