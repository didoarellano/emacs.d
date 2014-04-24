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
(defface powerline-evil-red
  '((t (:background "#e74c3c" :foreground "#111111"))) "")
(defface powerline-evil-green
  '((t (:background "#2ecc71" :foreground "#111111"))) "")
(defface powerline-evil-blue
  '((t (:background "#5f87af" :foreground "#eeeeee"))) "")

(defun get-evil-state-color (state is-active-window)
  (let ((powerline-evil-red-states `("I" "E" "R"))
        (powerline-evil-green-states `("V" "O"))
        (powerline-evil-blue-states `("N" "M")))
    (cond
     ((and is-active-window (member state powerline-evil-blue-states)) 'powerline-evil-blue)
     ((member state powerline-evil-red-states) 'powerline-evil-red)
     ((member state powerline-evil-green-states) 'powerline-evil-green)
     (t 'powerline-inactive))))

(defpowerline powerline-vcs
  (let ((str " ±" ))
    (if (and (buffer-file-name (current-buffer)) vc-mode)
      (setq str (concat str (downcase (format-mode-line '(vc-mode vc-mode))) " "))
      (setq str (concat str " untracked ")))
    str))

(defpowerline powerline-workgroup
  (let ((str "∩ " ))
    (ignore-errors
      (setq str (concat str (wg-workgroup-name (wg-current-workgroup t)) " ")))
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
                        (state-color (get-evil-state-color evil-mode-line-tag active))
                        (buffer-color (if (and (buffer-file-name)
                                               (file-exists-p (buffer-file-name))
                                               (buffer-modified-p))
                                          'powerline-evil-red bright))

                        (lhs (list

                              (powerline-buffer-id buffer-color 'l)
                              (powerline-raw " " buffer-color)
                              (powerline-arrow-left buffer-color light)

                              (powerline-vcs light)
                              (powerline-arrow-left light dark)

                              (powerline-workgroup dark 'l)
                              (powerline-arrow-left dark darker)

                              (powerline-major-mode darker 'l)
                              (powerline-raw " " darker)
                              (powerline-arrow-left darker 'powerline-normal)

                              ))

                        (rhs (list

                              (powerline-arrow-right 'powerline-normal state-color)
                              (powerline-evil-state state-color 'r)
                              (powerline-arrow-right state-color darker)

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
