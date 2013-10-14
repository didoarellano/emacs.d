(require 'projectile)

(projectile-global-mode)
(add-to-list 'projectile-globally-ignored-directories "node_modules")
(add-to-list 'projectile-globally-ignored-directories "elpa")
(setq projectile-known-projects-file
      (expand-file-name "projectile-bookmarks.eld" dido-tmp-directory))

(global-set-key (kbd "C-c f") 'dido-do-find-file-projectile-or-ido)


(provide 'dido-projectile)
