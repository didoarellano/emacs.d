(require 'workgroups)

(setq wg-switch-on-load nil)
(wg-load "~/Dropbox/emacs/workgroups")
(setq wg-prefix-key (kbd "C-a"))
(setq wg-morph-on nil)
(setq wg-mode-line-left-brace "")
(setq wg-mode-line-right-brace "")

(workgroups-mode 1)


(provide 'dido-workgroups)
