(defun d-python-mode-hook ()
  (setq python-shell-interpreter "python3")
  (flycheck-mode)
  (setq mode-name "py"))
(add-hook 'python-mode-hook 'd-python-mode-hook)

(use-package elpy
  :ensure t
  :config
  (setq elpy-modules '(elpy-module-company
                       elpy-module-eldoc
                       elpy-module-pyvenv
                       elpy-module-sane-defaults))
  (elpy-enable)
  ;; (setq elpy-rpc-python-command "python3")
  ;; (setq elpy-interactive-python-command "python3")
  (setq elpy-rpc-backend "jedi"))

(defun d-elpy-mode-hook ()
  (setq company-idle-delay nil)
  (evil-leader/set-key-for-mode 'python-mode "m." 'elpy-goto-definition)
  (evil-leader/set-key-for-mode 'python-mode "md" 'elpy-doc)
  (evil-leader/set-key-for-mode 'python-mode "mr" 'elpy-multiedit-python-symbol-at-point)
  (evil-leader/set-key-for-mode 'python-mode "mo" 'elpy-occur-definitions)
  (evil-leader/set-key-for-mode 'python-mode "mt" 'elpy-test) ; at point
  (evil-leader/set-key-for-mode 'python-mode "mvw" 'pyvenv-workon)
  (evil-leader/set-key-for-mode 'python-mode "mva" 'pyvenv-activate)
  (evil-leader/set-key-for-mode 'python-mode "mvd" 'pyvenv-deactivate)
  ;; (evil-leader/set-key-for-mode 'python-mode "mT" 'elpy-test) ; whole project
  (advice-add 'elpy-goto-definition :before #'push-mark))
(add-hook 'elpy-mode-hook 'd-elpy-mode-hook)

;; (defun --pamigay-temporary-elpy-PATH-fix ()
;;   (interactive)
;;   (setenv "PATH"
;;           (concat
;;            "/home/dido/.virtualenvs/pamigay/bin"
;;            ":"
;;            (getenv "PATH"))))

(provide 'd-python)
