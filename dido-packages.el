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
                        evil-numbers

                        ;; Coding helpers
                        yasnippet
                        zencoding-mode
                        autopair
                        flycheck

                        ;; Buffer/window/project management
                        projectile
                        flx-ido

                        ;; Other utils
                        exec-path-from-shell
                        smooth-scrolling
                        smex
                        ace-jump-mode
                        magit
                        git-gutter-fringe

                        ;; Language modes
                        js2-mode
                        scss-mode
                        markdown-mode
                        jade-mode
                        php-mode
                        web-mode
                        sml-mode
                        vimrc-mode

                        ;; Color themes
                        tango-2-theme

                        org-bullets

                        ;; You use Emacs for what??
                        jabber
                        ))

(dolist (p dido-packages)
  (when (not (package-installed-p p))
    (package-install p))

  ;; If dido-[package-name].el exists, we require dido-[package-name].
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

;; linum-relative
;; https://github.com/coldnew/linum-relative
(add-to-list 'load-path (concat dotemacs-dir "site-lisp/linum-relative"))
;; Configuration is in dido-gui.el

;; workgroups2
;; https://github.com/pashinin/workgroups2
(add-to-list 'load-path (concat dotemacs-dir "site-lisp/workgroups2/src"))
(require 'dido-workgroups)


(provide 'dido-packages)
