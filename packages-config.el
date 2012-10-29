(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar dido-packages '(

                        ;; Evil vimulation. Emacs' missing editor
                        evil
                        surround

                        ;; Coding helpers
                        yasnippet
                        zencoding-mode
                        autopair

                        ;; Buffer/window/project management
                        workgroups
                        eproject

                        ;; Other utils
                        smooth-scrolling
                        smex
                        ace-jump-mode

                        ;; Language modes
                        js2-mode
                        markdown-mode

                        ;; Color themes
                        tango-2-theme

                        ))

(dolist (p dido-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; If [package-name]-config.el exists, we require [package-name]-config.
(dolist (p dido-packages)
  (let ((config-name (concat (symbol-name p) "-config")))
    (if (file-exists-p (concat dotemacs-dir config-name ".el"))
       (require (intern config-name)))))


(provide 'packages-config)
