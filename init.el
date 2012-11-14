(defvar dotemacs-dir (file-name-directory
                      (or (buffer-file-name) load-file-name)))
(defvar package-config-dir (concat dotemacs-dir "package-config/"))
(defvar language-config-dir (concat dotemacs-dir "language-config/"))

(add-to-list 'load-path dotemacs-dir)
(add-to-list 'load-path package-config-dir)
(add-to-list 'load-path language-config-dir)

;; Try and keep emacs from pooping all over my home directory with
;; backups, save-files, ido, smex, etc
(defvar dido-tmp-directory (expand-file-name
                            (concat dotemacs-dir "tmp/")))

(mapc 'require '(
                 dido-defuns
                 dido-packages
                 dido-minibuffer
                 dido-general-keys-and-aliases
                 dido-gui
                 dido-coding
                 dido-misc
                 dido-immortal-scratchbuff
                 dido-text-scale
                 ))
