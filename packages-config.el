(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar dido-packages '(
                        evil
                        surround
                        tango-2-theme
                        smooth-scrolling
                        ace-jump-mode
                        autopair
                        smex
                        zencoding-mode

                        js2-mode

                        ))

(dolist (p dido-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; Packages that aren't in M/ELPA are added as git submodules.

;; eproject
;; https://github.com/jrockway/eproject
(add-to-list 'load-path (concat dotemacs-dir "site-lisp/eproject"))
(require 'eproject)
(require 'eproject-extras)
(setq eproject-completing-read-function 'eproject--ido-completing-read)


(provide 'packages-config)
