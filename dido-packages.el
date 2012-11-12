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
                        exec-path-from-shell
                        smooth-scrolling
                        smex
                        ace-jump-mode
                        magit

                        ;; Language modes
                        js2-mode
                        markdown-mode

                        ;; Color themes
                        tango-2-theme

                        ))

(dolist (p dido-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; If dido-[package-name].el exists, we require dido-[package-name].
(dolist (p dido-packages)
  (let ((config-name (concat "dido-" (symbol-name p))))
    (if (file-exists-p (concat package-config-dir config-name ".el"))
       (require (intern config-name)))))


;; Some packages will be added as git submodules because they're not on M/ELPA
;; or other reasons.

;; Powerline
;; https://github.com/milkypostman/powerline
;; Powerline is in MELPA but we get an error[1] when it is installed and compiled
;; through package.el. We should file an issue on github.
;; [1]: Symbol's function definition is void: gensym
;; Powerline configuration is in modeline-config.el
(add-to-list 'load-path (concat dotemacs-dir "site-lisp/powerline"))


(provide 'dido-packages)
