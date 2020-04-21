(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq frame-title-format
  '(" " (:eval (if (buffer-file-name)
                (abbreviate-file-name (buffer-file-name))
                  "%b"))))
(setq ring-bell-function 'ignore visible-bell nil)

(setq initial-frame-alist '((font . "Fira Mono Medium-10")))
(setq default-frame-alist '((font . "Fira Mono Medium-10")
                            (vertical-scroll-bars . nil)))
(setq-default line-spacing 0.15)

;; https://www.reddit.com/r/emacs/comments/4c5g4i/help_how_do_i_change_the_cursor_to_have_the_same/
(use-package eyedropper
  :ensure t
  :config
  (setq d-cursor-invert-active nil)
  (defun d-invert-cursor-color ()
    (interactive)
    (if d-cursor-invert-active
        (set-cursor-color (eyedrop-foreground-at-point))))
  (add-hook 'post-command-hook 'd-invert-cursor-color))

(blink-cursor-mode 0)
(global-hl-line-mode t)
(set-face-attribute 'region nil :background "#5f87af" :foreground "#eeeeee")
(global-linum-mode 1)
(setq linum-format " %3d")
(fringe-mode `(8 . 0))
;; Removes "$" symbol in the right fringe when line is truncated.
(set-display-table-slot standard-display-table 0 ?\ )
(define-fringe-bitmap 'left-curly-arrow
  [#b00000000
   #b00000000
   #b00000000
   #b00000000
   #b00000000
   #b00000000
   #b00000000
   #b10010010])
(set-face-attribute 'fringe nil :foreground "#888a85")

;; Smaller GUI. Line numbers, modeline.
(set-face-attribute 'linum nil :height 70 :slant 'italic :weight 'semi-light)

;; Smaller `mode-line-inactive' face doesn't stick when new frames are created
;; sometimes. Force it with a hook.
(defun d-ensure-small-modeline (&optional frame)
  (interactive)
  (set-face-attribute 'mode-line          nil :height 72 :box nil :weight 'semi-bold)
  (set-face-attribute 'mode-line-inactive nil :height 72 :box nil :weight 'semi-bold))
(d-ensure-small-modeline)
(add-hook 'after-make-frame-functions 'd-ensure-small-modeline)

;; Show matching parens
(show-paren-mode 1)
(setq show-paren-delay 0.0)

;; Show keystrokes in progress
(setq echo-keystrokes 0.1)

(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
; https://github.com/avar/dotemacs/blob/master/.emacs#L149
(defun display-startup-echo-area-message ()
  "If it wasn't for this you'd be GNU/Spammed by now"
  (message ""))
(setq initial-scratch-message nil)

;; "y" and "n" instead of "yes" and "no"
(defalias 'yes-or-no-p 'y-or-n-p)

;; Uniquify buffer with parts of directory name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(provide 'd-gui)
