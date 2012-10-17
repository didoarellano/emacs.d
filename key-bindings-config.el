;; Make command key meta
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)


;; Evil mapppings for ace-jump-mode
(define-key evil-normal-state-map (kbd "SPC j") 'ace-jump-line-mode)
(define-key evil-normal-state-map (kbd "SPC k") 'ace-jump-line-mode)
(define-key evil-normal-state-map (kbd "SPC w") 'ace-jump-word-mode)
(define-key evil-normal-state-map (kbd "SPC c") 'ace-jump-char-mode)


;; Overwrite find-file-read-only with ido-recentf-open
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)


(provide 'key-bindings-config)
