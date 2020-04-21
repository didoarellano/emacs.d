(require 'd-powerline-dark)
(require 'd-powerline-light)

;; Fix powerline confusing which window is active when making new frames.
;; https://github.com/milkypostman/powerline/issues/37
(defun d-powerline-active-window-fix ()
  (when (not (minibuffer-selected-window))
    (setq powerline-selected-window (selected-window))))
(add-hook 'post-command-hook 'd-powerline-active-window-fix)

;; https://github.com/syl20bnr/spacemacs/blob/fa3c610a426a216fce036bd5ac0bc9cd22941189/contrib/syntax-checking/packages.el#L70
(defmacro spacemacs|custom-flycheck-lighter (error)
  "Return a formatted string for the given ERROR (error, warning, info)."
  `(let* ((error-counts (flycheck-count-errors
                         flycheck-current-errors))
          (errorp (flycheck-has-current-errors-p ',error))
          (err (or (cdr (assq ',error error-counts)) "?"))
          (running (eq 'running flycheck-last-status-change)))
     (if (or errorp running) (format "%s" err) "0")))

(defface powerline-evil-red
  '((t (:background "#e74c3c" :foreground "#111111"))) "")
(defface powerline-evil-green
  '((t (:background "#2ecc71" :foreground "#111111"))) "")
(defface powerline-evil-blue
  '((t (:background "#5f87af" :foreground "#eeeeee"))) "")

(defun d-get-evil-state-color (state is-active-window)
  (let ((powerline-evil-red-states `("I" "E" "R"))
        (powerline-evil-green-states `("V" "O"))
        (powerline-evil-blue-states `("N" "M")))
    (cond
     ((and is-active-window (member state powerline-evil-blue-states)) 'powerline-evil-blue)
     ((member state powerline-evil-red-states) 'powerline-evil-red)
     ((member state powerline-evil-green-states) 'powerline-evil-green)
     (t 'powerline-inactive))))

(defun d-define-powerline-elements ()
  (defpowerline powerline-git-branch
    ;; TODO Colorize when git dirty
    ;; (vc-state buffer-file-name)  ; Will break on scratch buffer and other no-file buffers
    (let ((str " ± "))
      (when (not (string-equal d-git-branch-name ""))
        (setq str (concat str d-git-branch-name " ")))
      str))

  (defpowerline powerline-vcs
    (let ((str " ±" ))
      (if (and (buffer-file-name (current-buffer)) vc-mode)
          (setq str (concat str (downcase (format-mode-line '(vc-mode vc-mode))) " "))
        (setq str (concat str " ")))
      str))

  (defpowerline powerline-workgroup
    (let ((str "∩ " ))
      (ignore-errors
        (setq str (concat str (wg-workgroup-name (wg-current-workgroup t)) " ")))
      str))

  (defpowerline powerline-evil-state
    (concat " " (format-mode-line 'evil-mode-line-tag)))
  )

(use-package powerline
  :ensure t
  :init (d-powerline-light-init))

(provide 'd-powerline)
