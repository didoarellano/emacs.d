(require 'workgroups2)

(setq wg-default-session-file "~/Dropbox/emacs/workgroups")

;; (defadvice wg-save-session (around dont-save-help-buffers-advice activate)
;;   (kill-help-buffers) ad-do-it)

;; (defun kill-help-buffers ()
;;   (dolist (buffer (buffer-list))
;;     (if (string= "*Help*" (buffer-name buffer))
;;         (kill-buffer buffer))))

(defun activate-workgroups-mode()
  (workgroups-mode 1))

(add-hook 'after-init-hook 'activate-workgroups-mode)


(provide 'dido-workgroups)
