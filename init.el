(add-to-list 'load-path (concat user-emacs-directory "config"))
(add-to-list 'load-path (concat user-emacs-directory "config/languages"))
(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(mapc 'require '(
                 d-base
                 d-evil-base
                 d-functions
                 d-gui
                 d-themes
                 d-minibuffer
                 d-text-handling
                 d-project-management
                 d-buffer-file-management
                 d-magit
                 d-flycheck
                 d-powerline
                 d-autocompletion
                 d-smooth-scrolling
                 d-helm
                 d-swiper
                 d-smartparens
                 d-inbox

                 d-ag
                 d-rainbow-mode

			     d-javascript
                 d-json
                 d-web-mode
                 d-html
                 d-jade
                 d-scss-css
                 d-markdown
                 d-python
                 ;; d-php
                 d-yaml

                 d-nix
			     d-emacs-lisp
                 d-org
                 d-common-language-helpers

                 d-text-scale

                 ;; This needs to load after powerline otherwise *scratch*
                 ;; buffer starts with a stock modeline until it resurrects.
                 d-immortal-scratch-buffer

                 ;; yasnippet
                 ;; emmet-mode
                 ;; flycheck
                 ;; git-gutter-fringe
                 ;; linum-relative
                 ;; web-mode
                 ;; php-mode
                 ;; sml-mode
                 ;; vimrc-mode

                 ))

(d-ensure-small-modeline)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#ffffff"))))
 '(cursor ((t (:foreground nil :background "#474747"))))
 '(fringe ((t (:background "#ffffff"))))
 '(highlight ((t (:foreground nil :background "#eeeeee"))))
 '(js2-error ((t nil)))
 '(js2-warning ((t nil)))
 '(org-link ((t (:inherit link :underline t))))
 '(secondary-selection ((t (:background "#fffacd")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (nix-mode yaml-mode workgroups2 web-mode visual-fill-column use-package ujelly-theme tango-2-theme swiper sublimity smooth-scrolling smex smartparens skewer-mode scss-mode rjsx-mode restclient rainbow-mode projectile powerline php-mode org-bullets markdown-mode magit keychain-environment json-mode js2-refactor js-doc jade-mode ido-ubiquitous helm-dash focus flycheck-pos-tip flx-ido eyedropper evil-surround evil-numbers evil-matchit evil-leader emmet-mode elpy diff-hl company-web company-tern company-quickhelp calfw avy auto-complete ag)))
 '(safe-local-variable-values
   (quote
    ((eval add-to-list
           (quote auto-mode-alist)
           (quote
            ("\\.js$" . rjsx-mode)))
     (eval when
           (fboundp
            (function web-mode-set-engine))
           (web-mode-set-engine "django"))))))
