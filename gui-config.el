(require 'tango-2-theme)
(load-theme 'tango-2 t)

;; (set-face-attribute 'default nil :font "Menlo-11")
; (setq default-frame-alist '((font . "Menlo-11")))
(set-frame-font "Menlo-11")
(setq-default line-spacing 0.25)

;; Cursor, cursorline and mouse settings
(blink-cursor-mode 0)
(global-hl-line-mode t)
(setq mouse-highlight nil)

;; Line numbers
(global-linum-mode 1)
(setq linum-format " %2d")
(set-face-attribute 'linum nil :height 0.8)
(set-face-attribute 'linum nil :slant 'italic)

;; No error dings
(setq ring-bell-function 'ignore visible-bell nil)

(tool-bar-mode 0)
(scroll-bar-mode 0)

; Show buffer boundaries/scrollability in right fringe
(setq-default indicate-buffer-boundaries (quote right))

;; Show column number in modeline
(setq column-number-mode t)


(provide 'gui-config)
