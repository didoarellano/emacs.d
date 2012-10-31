(require 'tango-2-theme)
(load-theme 'tango-2 t)

(set-face-attribute 'default nil :font "Menlo-11")
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


;; Modeline

;; Show column number in modeline
(setq column-number-mode t)

;; Smaller modeline
(set-face-attribute 'mode-line nil :height 0.9)
(set-face-attribute 'mode-line-inactive nil :height 0.9)

;; Clean up with diminish
(require 'diminish)

;; Hide minor modes
(eval-after-load "autopair"
  '(diminish 'autopair-mode))
(eval-after-load "eproject"
  '(diminish 'eproject-mode))
(eval-after-load "undo-tree"
  '(diminish 'undo-tree-mode))
(eval-after-load "workgroups"
  '(diminish 'workgroups-mode))
(eval-after-load "yasnippet"
  '(diminish 'yas-minor-mode))
(eval-after-load "zencoding-mode"
  '(diminish 'zencoding-mode))

(provide 'gui-config)
