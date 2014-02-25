;; Smaller modeline
(set-face-attribute 'mode-line nil :height 0.9 :box nil)
(set-face-attribute 'mode-line-inactive nil :height 0.9 :box nil)

(require 'powerline)

(defface powerline-normal
  '((t (:background "#121212" :foreground "#cccccc"))) "")
(defface powerline-bright-active
  '((t (:background "#ffffff" :foreground "#111111"))) "")
(defface powerline-light-active
  '((t (:background "#bbbbbb" :foreground "#111111"))) "")
(defface powerline-evil-state-active
  '((t (:slant italic :inherit powerline-light-active))) "")
(defface powerline-dark-active
  '((t (:background "#444444" :inherit powerline-normal))) "")
(defface powerline-darker-active
  '((t (:background "#222222" :inherit powerline-normal))) "")
(defface powerline-inactive
  '((t (:slant italic :background "#222222" :foreground "#aaaaaa"))) "")

(defpowerline powerline-vcs
  (let ((str " ±" ))
    (if (and (buffer-file-name (current-buffer)) vc-mode)
      (setq str (concat str (downcase (format-mode-line '(vc-mode vc-mode))) " "))
      (setq str (concat str " untracked ")))
    str))

(defpowerline powerline-workgroup
  (let ((str "∩ " ))
    (ignore-errors
      (setq str (concat str (wg-name (wg-current-workgroup)) " ")))
    str))

(defpowerline powerline-evil-state
  (concat " " (format-mode-line 'evil-mode-line-tag)))

;; Fix for modeline always being "active"
;; https://github.com/milkypostman/powerline/issues/37
(defun powerline-active-window-fix ()
  (when (not (minibuffer-selected-window))
    (setq powerline-selected-window (selected-window))))
(add-hook 'post-command-hook 'powerline-active-window-fix)

(setq-default mode-line-format
              '("%e"
                (:eval
                 (let* ((active (eq powerline-selected-window (selected-window)))
                        (bright (if active 'powerline-bright-active 'powerline-inactive))
                        (light (if active 'powerline-light-active 'powerline-inactive))
                        (dark (if active 'powerline-dark-active 'powerline-inactive))
                        (darker (if active 'powerline-darker-active 'powerline-inactive))
                        (evil (if active 'powerline-evil-state-active 'powerline-inactive))

                        (lhs (list

                              (powerline-raw "%*" bright 'l)

                              (powerline-buffer-id bright 'l)
                              (powerline-raw " " bright)
                              (powerline-arrow-left bright light)

                              (powerline-vcs light)
                              (powerline-arrow-left light dark)

                              (powerline-major-mode dark 'l)
                              (powerline-raw " " dark)
                              (powerline-arrow-left dark 'powerline-normal)

                              ))

                        (rhs (list

                              (powerline-arrow-right 'powerline-normal light)

                              (powerline-evil-state evil 'r)
                              (powerline-arrow-right light darker)

                              (powerline-raw "%4l" darker 'r)
                              (powerline-raw ":" darker)
                              (powerline-raw "%3c" darker 'r)

                              (powerline-arrow-right darker dark)
                              (powerline-raw " " dark)

                              (powerline-raw "%6p" dark 'r)

                              (powerline-hud 'powerline-bright-active 'powerline-darker-active)

                              )))
                   (concat
                    (powerline-render lhs)
                    (powerline-fill 'powerline-normal (- (powerline-width rhs) 3))
                    (powerline-render rhs))))))


(provide 'dido-modeline)
