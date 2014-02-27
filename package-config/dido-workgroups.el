(require 'workgroups2)

(setq wg-default-session-file "~/Dropbox/emacs/workgroups")


(defun activate-workgroups-mode()
  (workgroups-mode 1))

(add-hook 'after-init-hook 'activate-workgroups-mode)


(provide 'dido-workgroups)
