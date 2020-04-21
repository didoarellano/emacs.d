;; http://www.reddit.com/r/emacs/comments/30b67j/how_can_you_reset_emacs_to_the_default_theme/cprkyl0
(defun switch-theme (theme)
  ;; This interactive call is taken from `load-theme'
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapcar 'symbol-name
                                     (custom-available-themes))))))
  (mapcar #'disable-theme custom-enabled-themes)
  (load-theme theme t))

(use-package ujelly-theme
  :ensure t
  :defer t)

(use-package tango-2-theme
  :ensure t
  :defer t)

(custom-set-faces
 '(org-link ((t (:inherit link :underline t)))))

(defun d-dark-theme ()
  (interactive)
  (load-theme 'tango-2 t)
  (custom-set-faces
   '(default ((t (:background "#000000"))))
   '(fringe  ((t (:background "#000000")))))

  (defface d-background
    '((t (:background "#000000"))) ""))

(defun d-light-theme ()
  (interactive)
  (load-theme 'adwaita t)
  (custom-set-faces
   '(default ((t (:background "#ffffff"))))
   '(fringe  ((t (:background "#ffffff"))))
   '(highlight  ((t (:foreground nil :background "#eeeeee"))))
   '(cursor  ((t (:foreground nil :background "#474747"))))
   '(secondary-selection ((t (:background "#fffacd")))))

  (defface d-background
    '((t (:background "#ffffff"))) ""))

(d-light-theme)

(provide 'd-themes)
