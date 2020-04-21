(defun d-powerline-dark-set-faces ()
  (defface powerline-normal
    '((t (:inherit d-background :foreground "#cccccc"))) "")
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
  (defface powerline-flycheck-error
    '((t (:inherit powerline-darker-active :foreground "#ff5d53"))) "")
  (defface powerline-flycheck-warning
    '((t (:inherit powerline-darker-active :foreground  "#c7c57b"))) "")
  (defface powerline-flycheck-info
    '((t (:inherit powerline-darker-active :foreground  "#7da5cd"))) ""))

(defun d-powerline-dark-left ()
  (let* ((active (eq powerline-selected-window (selected-window)))
         (bright (if active 'powerline-bright-active 'powerline-inactive))
         (light (if active 'powerline-light-active 'powerline-inactive))
         (dark (if active 'powerline-dark-active 'powerline-inactive))
         (darker (if active 'powerline-darker-active 'powerline-inactive))
         (buffer-color (if (and (buffer-file-name)
                                (file-exists-p (buffer-file-name))
                                (buffer-modified-p))
                           'powerline-evil-red bright))
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

(defun d-powerline-dark-right ()
  (let* ((active (eq powerline-selected-window (selected-window)))
         (bright (if active 'powerline-bright-active 'powerline-inactive))
         (light (if active 'powerline-light-active 'powerline-inactive))
         (dark (if active 'powerline-dark-active 'powerline-inactive))
         (darker (if active 'powerline-darker-active 'powerline-inactive))
         (state-color (d-get-evil-state-color evil-mode-line-tag active)))

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

(defun d-powerline-dark-setup ()
  (let ((lhs (d-powerline-dark-left))
        (rhs (d-powerline-dark-right)))
    (concat
     (powerline-render lhs)
     (powerline-fill 'powerline-normal (- (powerline-width rhs) 4))
     (powerline-render rhs))))

(defun d-powerline-dark-init ()
  (d-powerline-dark-set-faces)
  (d-define-powerline-elements)
  (setq-default mode-line-format '("%e" (:eval (d-powerline-dark-setup)))))

(provide 'd-powerline-dark)
