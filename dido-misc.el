(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
; https://github.com/avar/dotemacs/blob/master/.emacs#L149
(defun display-startup-echo-area-message ()
  "If it wasn't for this you'd be GNU/Spammed by now"
  (message ""))

(setq initial-scratch-message nil)

(setq auto-save-default nil)

;; Show keystrokes in progress
(setq echo-keystrokes 0.1)

;; Move files to trash when deleting
(setq delete-by-moving-to-trash t)

;; "y" and "n" instead of "yes" and "no"
(defalias 'yes-or-no-p 'y-or-n-p)

;; Uniquify buffer with parts of directory name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(setq backup-directory-alist `(("." . ,dido-tmp-directory)))
(setq auto-save-file-name-transforms `((".*" ,dido-tmp-directory t)))
(setq create-lockfiles nil)

; Make backups even when using version control
(setq vc-make-backup-files t)

;; OSX
;; Don't make new frames when opening files from other apps (Finder,
;; Quicksilver, etc).
(setq ns-pop-up-frames nil)

;; Point emacs to the firefox executable
(add-to-list 'exec-path "~/lib/firefox")

(provide 'dido-misc)
