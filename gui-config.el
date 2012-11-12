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

;; Initial frame size and position.
(setq initial-frame-alist (append
                           '((top . 0)
                             (left . 0)
                             (width . 99))
                           initial-frame-alist))
(add-to-list 'initial-frame-alist
             ;; Height of display minus OS chrome (menu bar and app title bar on
             ;; OSX) divided by height of a char.
             (cons 'height (/ (- (x-display-pixel-height) 45)
                              (frame-char-height))))

(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Frame title bar
(setq frame-title-format
  '(" " (:eval (if (buffer-file-name)
                (abbreviate-file-name (buffer-file-name))
                  "%b"))))

;; Modeline
(require 'modeline-config)


(provide 'gui-config)
