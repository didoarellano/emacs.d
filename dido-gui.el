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
(set-face-attribute 'linum nil :height 0.8)
(set-face-attribute 'linum nil :slant 'italic)

;; Relative line numbers
(require 'linum-relative)
(setq linum-relative-current-symbol "▶")
(setq linum-format 'linum-relative)
(custom-set-faces
 '(linum-relative-current-face ((t :inherit linum :foreground "#ffffff"))))

(defun dido-toggle-linum-format ()
  (if (eq linum-format 'linum-relative)
      (setq linum-format " %2d")
    (setq linum-format 'linum-relative)))

;; (add-hook 'evil-insert-state-entry-hook 'dido-toggle-linum-format)
;; (add-hook 'evil-insert-state-exit-hook  'dido-toggle-linum-format)

;; No error dings
(setq ring-bell-function 'ignore visible-bell nil)

;; Initial frame size and position.
;; (setq initial-frame-alist (append
;;                            '((top . 0)
;;                              (left . 0)
;;                              (width . 99))
;;                            initial-frame-alist))
;; (add-to-list 'initial-frame-alist
;;              ;; Height of display minus OS chrome (menu bar and app title bar on
;;              ;; OSX) divided by height of a char.
;;              (cons 'height (/ (- (x-display-pixel-height) 45)
;;                               (frame-char-height))))

(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Frame title bar
(setq frame-title-format
  '(" " (:eval (if (buffer-file-name)
                (abbreviate-file-name (buffer-file-name))
                  "%b"))))

;; Modeline
(require 'dido-modeline)


(provide 'dido-gui)
