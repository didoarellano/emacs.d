(defvar d-tmp-directory (expand-file-name (concat user-emacs-directory "tmp/")))

;; Try and keep emacs from pooping all over my home directory with backups,
;; save-files, ido, smex, etc
(setq backup-directory-alist `(("." . ,d-tmp-directory)))
(setq auto-save-file-name-transforms `((".*" ,d-tmp-directory t)))
(setq create-lockfiles nil)
(setq auto-save-default nil)

; Make backups even when using version control
(setq vc-make-backup-files t)

;; Move files to trash when deleting
(setq delete-by-moving-to-trash t)

(global-unset-key (kbd "C-h h")) ; was `view-hello-file'

;; This keybinding is now brining up some other help file
(global-unset-key (kbd "C-h C-h")) ; was `help-for-help'

(provide 'd-base)
