(defvar dotemacs-dir (file-name-directory
                      (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path dotemacs-dir)

;; Try and keep emacs from pooping all over my home directory with
;; backups, save-files, ido, smex, etc
(defvar dido-tmp-directory (expand-file-name
				(concat dotemacs-dir "tmp/")))

(mapc 'require '(
                 packages-config
                 evil-config
                 minibuffer-config
                 ace-jump-mode
                 autopair-config
                 yasnippet-config
                 workgroups-config
                 key-bindings-config
                 gui-config
                 coding-config
                 misc-config
                 ))
