(defun d-powerline-light-set-faces ()
  (defface powerline-normal
    '((t (:inherit d-background :foreground "#eeeeee"))) "")
  (defface powerline-bright-active
    '((t (:background "#444444" :inherit powerline-normal))) "")
  (defface powerline-light-active
    '((t (:background "#cccccc" :foreground "#444444"))) "")
  (defface powerline-evil-state-active
    '((t (:slant italic :inherit powerline-light-active))) "")
  (defface powerline-dark-active
    '((t (:background "#888888" :inherit powerline-normal))) "")
  (defface powerline-darker-active
    '((t (:background "#eeeeee" :foreground "#444444"))) "")
  (defface powerline-inactive
    '((t (:slant italic :background "#eeeeee" :foreground "#444444"))) "")
  ;; (defface powerline-modified-buffer
  ;;   '((t (:))) "")

  (defface powerline-light-evil-red
    '((t (:background "#a52a2a":foreground "#eeeeee"))) "")
  (defface powerline-light-evil-green
    '((t (:background "#4e9a06" :foreground "#eeeeee"))) "")
  (defface powerline-light-evil-blue
    '((t (:background "#0084c8" :foreground "#eeeeee"))) "")

  (defface powerline-flycheck-error
    '((t (:inherit powerline-darker-active :foreground "#a52a2a"))) "")
  (defface powerline-flycheck-warning
    '((t (:inherit powerline-darker-active :foreground  "#ce5c00"))) "")
  (defface powerline-flycheck-info
    '((t (:inherit powerline-darker-active :foreground  "#0084c8"))) ""))

(defun d-powerline-light-get-evil-state-color (state is-active-window)
  (let ((powerline-evil-red-states `("I" "E" "R"))
        (powerline-evil-green-states `("V" "O"))
        (powerline-evil-blue-states `("N" "M")))
    (cond
     ((and is-active-window (member state powerline-evil-blue-states)) 'powerline-light-evil-blue)
     ((member state powerline-evil-red-states) 'powerline-light-evil-red)
     ((member state powerline-evil-green-states) 'powerline-light-evil-green)
     (t 'powerline-inactive))))

(defun d-powerline-light-left ()
  (let* ((active (eq powerline-selected-window (selected-window)))
         (bright (if active 'powerline-bright-active 'powerline-inactive))
         (light (if active 'powerline-light-active 'powerline-inactive))
         (dark (if active 'powerline-dark-active 'powerline-inactive))
         (darker (if active 'powerline-darker-active 'powerline-inactive))
         (buffer-color (if (and (buffer-file-name)
                                (file-exists-p (buffer-file-name))
                                (buffer-modified-p))
                           'powerline-light-evil-red bright))
         (flycheckp (and (boundp 'flycheck-mode)
                         (symbol-value flycheck-mode)
                         (or flycheck-current-errors
                             (eq 'running flycheck-last-status-change))))
         (flycheck-error (if active 'powerline-flycheck-error 'powerline-inactive))
         (flycheck-warning (if active 'powerline-flycheck-warning 'powerline-inactive))
         (flycheck-info (if active 'powerline-flycheck-info 'powerline-inactive)))

    (append

     ;; Buffer name
     (list
      (powerline-buffer-id buffer-color 'l)
      (powerline-raw " " buffer-color)
      (powerline-arrow-left buffer-color light))

     ;; Git branch
     (list
      (powerline-git-branch light dark)
      )

     ;; Workgroup
     ;; (list
     ;;  (powerline-workgroup dark 'l)
     ;;  (powerline-arrow-left dark darker))

     (if (not flycheckp)
         (list
          (powerline-arrow-left light 'powerline-normal))
       (list
        (powerline-arrow-left light darker)
        (powerline-raw " " darker)
        (powerline-raw (spacemacs|custom-flycheck-lighter error) flycheck-error)
        (powerline-raw " • " darker)
        (powerline-raw (spacemacs|custom-flycheck-lighter warning) flycheck-warning)
        (powerline-raw " • " darker)
        (powerline-raw (spacemacs|custom-flycheck-lighter info) flycheck-info)
        (powerline-raw " " darker)
        (powerline-arrow-left darker 'powerline-normal)))
     )))

(defun d-powerline-light-right ()
  (let* ((active (eq powerline-selected-window (selected-window)))
         (bright (if active 'powerline-bright-active 'powerline-inactive))
         (light (if active 'powerline-light-active 'powerline-inactive))
         (dark (if active 'powerline-dark-active 'powerline-inactive))
         (darker (if active 'powerline-darker-active 'powerline-inactive))
         (state-color (d-powerline-light-get-evil-state-color evil-mode-line-tag active)))

    (append

     ;; Evil state
     (list
      (powerline-arrow-right 'powerline-normal state-color)
      (powerline-evil-state state-color 'r)
      (powerline-arrow-right state-color dark))

     ;; Major mode
     (list
      (powerline-major-mode dark 'l)
      (powerline-raw " " dark)
      (powerline-arrow-right dark darker))

     ;; Line • column number
     (list
      (powerline-raw " %l" darker 'r)
      (powerline-raw "•" darker)
      (powerline-raw " %c" darker 'r)
      )


     ;; Scroll position
     (list
      (powerline-hud bright darker 2)
      (powerline-raw "" state-color))
      ;; (powerline-raw "%5p " light))
     )))

(defun d-powerline-light-setup ()
  (let ((lhs (d-powerline-light-left))
        (rhs (d-powerline-light-right)))
    (concat
     (powerline-render lhs)
     (powerline-fill 'powerline-normal (- (powerline-width rhs) 4))
     (powerline-render rhs))))

(defun d-powerline-light-init ()
  (d-powerline-light-set-faces)
  (d-define-powerline-elements)
  (setq-default mode-line-format '("%e" (:eval (d-powerline-light-setup)))))

(provide 'd-powerline-light)
