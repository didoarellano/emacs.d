(defun d-company-init ()
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay nil)
  (setq company-show-numbers t)
  (setq company-dabbrev-downcase nil)
  (setq company-minimum-prefix-length 2))

(defun d-company-config ()
  (global-set-key (kbd "M-<tab>") 'company-complete)
  (define-key evil-insert-state-map (kbd "C-p") 'company-complete)
  (define-key evil-insert-state-map (kbd "C-n") 'company-complete)

  (define-key company-active-map (kbd "C-d") 'company-show-doc-buffer)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-/") 'company-search-candidates)
  (define-key company-active-map (kbd "C-SPC") 'company-filter-candidates))

(defun d-company-quickhelp-init ()
  (company-quickhelp-mode 1)
  (setq company-quickhelp-delay nil)
  (defun d-company-quickhelp-show()
    (interactive)
    (company-quickhelp--show))
  (define-key company-active-map (kbd "C-d") 'd-company-quickhelp-show))

(setq-default company-backends '((company-dabbrev-code company-dabbrev) company-files))

(use-package company
  :ensure t
  :init (d-company-init)
  :config (d-company-config))

(use-package company-web
  :ensure t)

;; Disabling this until we fix this error.
;; Error running timer `company-quickhelp--show': (error "Invalid font name: -unknown-Inconsolata-dz-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
;; Related issue: https://github.com/expez/company-quickhelp/issues/5
;; (use-package company-quickhelp
;;   :ensure t
;;   :init (d-company-quickhelp-init))

(provide 'd-autocompletion)
