(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar user-packages '(
                        evil
                        surround
                        tango-2-theme
                        smooth-scrolling
                        ace-jump-mode
                        autopair
                        smex

                        js2-mode

                        ))

(dolist (p user-packages)
  (when (not (package-installed-p p))
    (package-install p)))


(provide 'package-config)
