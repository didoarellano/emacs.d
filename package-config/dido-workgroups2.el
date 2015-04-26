(require 'workgroups2)

(setq wg-session-file "~/Dropbox/emacs/workgroups")
(setq wg-load-last-workgroup nil)
(setq wg-open-this-wg "blank")

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
  (workgroups-mode 1))

(add-hook 'after-init-hook 'activate-workgroups-mode)


(provide 'dido-workgroups2)
