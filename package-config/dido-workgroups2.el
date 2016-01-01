(require 'workgroups2)

(setq wg-use-default-session-file nil)
(setq wg-default-session-file "~/.emacs.d/.emacs_workgroups")
(setq wg-load-last-workgroup nil)
(setq wg-open-this-wg "blank")
(setq wg-mess-with-buffer-list t)

(setq wg-prefix-key (kbd "C-c w"))
(global-set-key (kbd "C-c b") 'wg-switch-to-buffer)
(define-key wg-prefixed-map (kbd "s") 'wg-save-session)


;; (defadvice wg-save-session (around dont-save-help-buffers-advice activate)
;;   (kill-help-buffers) ad-do-it)

;; (defun kill-help-buffers ()
;;   (dolist (buffer (buffer-list))
;;     (if (string= "*Help*" (buffer-name buffer))
;;         (kill-buffer buffer))))

(defun activate-workgroups-mode()
  (workgroups-mode 1)
  ;; (wg-open-session "~/.emacs.d/.emacs_workgroups")
  )

(add-hook 'after-init-hook 'activate-workgroups-mode)

(provide 'dido-workgroups2)
