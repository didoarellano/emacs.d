(add-to-list 'magic-mode-alist '("#!/usr/bin/env node" . js-mode))

(defun d-common-js-settings (mode mode-map)
  ;; (tern-mode t)
  (setq-local company-backends '((company-tern) company-dabbrev-code company-dabbrev company-files))

  (setq-default js2-basic-offset 2)
  (setq js-indent-level 2)

  (setq flycheck-checker 'javascript-standard)
  ;; (flycheck-mode)

  (evil-define-key 'normal mode-map (kbd "*") 'tern-highlight-refs) ; was `evil-search-word-forward'
  (evil-leader/set-key-for-mode mode "*" 'evil-search-word-forward)
  (evil-leader/set-key-for-mode mode "mr" 'tern-rename-variable)
  (evil-leader/set-key-for-mode mode "m." 'tern-find-definition)
  (evil-leader/set-key-for-mode mode "m," 'tern-pop-find-definition)
  (evil-leader/set-key-for-mode mode "md" 'tern-get-docs)
  (evil-leader/set-key-for-mode mode "mt" 'tern-get-type)

  (evil-define-key 'normal mode-map (kbd "M-.") 'tern-find-definition)
  (evil-define-key 'normal mode-map (kbd "M-,") 'tern-pop-find-definition)

  ;; These two might be better as snippets instead
  (evil-leader/set-key-for-mode mode "mc" 'js-doc-insert-function-doc)
  (evil-leader/set-key-for-mode mode "mC" 'js-doc-insert-file-doc)

  (evil-leader/set-key-for-mode mode "ss" 'run-skewer)
  (evil-leader/set-key-for-mode mode "sb" 'skewer-load-buffer)
  (evil-leader/set-key-for-mode mode "sf" 'skewer-eval-defun)
  ;; skewer-eval-last-expression
  ;; skewer-eval-print-last-expression
  ;; skewer-repl

  (evil-define-key 'insert mode-map (kbd "@") 'js-doc-insert-tag))


(defun d-js-mode-hook()
  (setq mode-name "js")
  (d-common-js-settings 'js-mode js-mode-map))
(add-hook 'js-mode-hook 'd-js-mode-hook)

(defun d-js2-mode-hook ()
  (setq mode-name "js2")
  (js2-refactor-mode)
  (require 'js2-imenu-extras)
  (js2-imenu-extras-setup)
  (d-common-js-settings 'js2-mode js2-mode-map))

(defun d-js2-jsx-mode-hook ()
  (setq mode-name "jsx")
  (d-common-js-settings 'js2-jsx-mode js2-jsx-mode-map))

(defun d-company-tern-init ()
  (add-to-list 'company-backends 'company-tern)
  (setq company-tern-meta-as-single-line t))

(defun d-js2-mode-init ()
  (autoload 'js2-mode "js2-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx$" . js2-jsx-mode))
  (add-to-list 'magic-mode-alist '("#!/usr/bin/env node" . js2-mode))

  (setq js2-indent-on-enter-key t)
  (setq js2-enter-indents-newline t)
  (setq js2-indent-switch-body t)
  (setq js2-allow-keywords-as-property-names nil)
  (setq js2-idle-timer-delay 0.1)
  (setq js2-strict-inconsistent-return-warning nil)
  (setq js2-include-rhino-externs nil)
  (setq js2-include-gears-externs nil)
  (setq js2-include-node-externs t)
  (setq js2-include-browser-externs t)
  (setq js2-concat-multiline-strings 'eol)
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil)
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-strict-trailing-comma-warning nil)
  (setq js2-strict-var-redeclaration-warning nil)

  (custom-set-faces
   '(js2-error ((t nil)))
   '(js2-warning ((t nil))))

  (evil-leader/set-key-for-mode 'js2-mode "ml" 'js2r-log-this)
  (evil-leader/set-key-for-mode 'js2-mode "mi" 'imenu)

  (add-hook 'js2-jsx-mode-hook 'd-js2-jsx-mode-hook)
  (add-hook 'js2-mode-hook 'd-js2-mode-hook))

(defun d-js-doc-init ()
  (setq js-doc-mail-address "dido@semicolonstudios.com")
  (setq js-doc-author (format "Dido Arellano <%s>" js-doc-mail-address))
  (setq js-doc-url "http://dido.ph")
  (setq js-doc-license "MIT"))

(use-package js2-mode
  :ensure t
  :init (d-js2-mode-init))
(use-package js2-refactor
  :ensure t)
(use-package js-doc
  :ensure t
  :init (d-js-doc-init))

(add-to-list 'load-path "~/code/tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)

;; TODO Make `tern-flash-region' "permanent" and toggleable instead of a timer.
(setq tern-flash-timeout 1.2)

;; (require 'tern-lint)
;; (with-eval-after-load 'tern
;;   (add-to-list 'flycheck-checkers 'tern-lint t)
;;   (flycheck-add-next-checker 'javascript-jshint '(t . tern-lint)))

(use-package company-tern
  :ensure t
  :init (d-company-tern-init))

(use-package ember-mode
  :ensure t
  :disabled t)

(use-package skewer-mode
  :ensure t
  :init
  (add-hook 'js2-mode-hook 'skewer-mode)
  (add-hook 'js-mode-hook 'skewer-mode))

(use-package rjsx-mode
  :ensure t)

(defvar d-tern-last-search-type nil)

(defun d-tern-do-highlight (data)
  (message "%s" data))

(defun d-tern-search-refs ()
  (interactive)
  (setq d-tern-last-search-type "refs")
  (tern-run-query #'d-tern-do-highlight "refs" (point)))

(provide 'd-javascript)
