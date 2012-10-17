(defvar dotemacs-dir (file-name-directory
                      (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path dotemacs-dir)

;; Try and keep emacs from pooping all over my home directory with
;; backups, save-files, ido, smex, etc
(defvar user-tmp-directory (expand-file-name
				(concat dotemacs-dir "tmp/")))

(mapc 'require '(
                 package-config
                 evil-config
                 ido-config
                 recentf-ido-config
                 smex-config
                 ace-jump-mode
                 autopair-config
                 key-bindings-config
                 gui-config
                 coding-config
                 misc-config
                 ))
