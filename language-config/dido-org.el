(evil-define-key 'normal org-mode-map (kbd "<M-return>")
  (lambda ()
    (interactive)
    (end-of-line)
    (org-meta-return)
    (evil-insert-state)))

(evil-define-key 'normal org-mode-map (kbd "<M-S-return>")
  (lambda ()
    (interactive)
    (end-of-line)
    (call-interactively 'org-insert-todo-heading)
    (evil-insert-state)))

(require 'org-bullets)

(add-hook 'org-mode-hook
          (lambda ()
            (setq mode-name "org")
            (org-bullets-mode 1)
            ))

(provide 'dido-org)
