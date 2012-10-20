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


;; Use C-x C-f for eproject-find-file if we're in a project & ido-find-file
;; when we're not
(global-set-key (kbd "C-x C-f")
                '(lambda ()
                   (interactive)
                   (if eproject-root (eproject-find-file)
                     (ido-find-file))))

;; Just in case we want regular ido-find-file in a project
(global-set-key (kbd "C-c C-x C-f") 'ido-find-file)


(provide 'key-bindings-config)
