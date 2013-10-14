(require 'projectile)

(projectile-global-mode)
(add-to-list 'projectile-globally-ignored-directories "node_modules")
(add-to-list 'projectile-globally-ignored-directories "elpa")


(provide 'dido-projectile)
