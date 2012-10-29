;; UTF-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Show matching parens
(show-paren-mode 1)
(setq show-paren-delay 0.0)

;; Spaces over tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Wrap lines at 80 chars not 70
(setq-default fill-column 80)

;; Don't wrap by default. Toggle with M-x toggle-truncate-lines
(setq-default truncate-lines t)

;; Wrap on word boundaries when toggling truncation
(setq-default word-wrap t)

;; Delete trailing whitespace on write
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; ==============================
;; Mode mappings & quick settings
;; ==============================

;; JavaScript
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))
(add-to-list 'magic-mode-alist '("#!/usr/bin/env node" . js2-mode))
(add-hook 'js2-mode-hook (lambda () (require 'js2-mode-config)))

;; HTML
(add-hook 'sgml-mode-hook (lambda () (require 'html-mode-config)))

;; CSS
(setq css-indent-offset 2)

;; Markdown
(autoload 'markdown-mode "markdown-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

(provide 'coding-config)
