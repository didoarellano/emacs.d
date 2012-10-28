(require 'yasnippet)

(defvar dido-snippets-dir (concat dotemacs-dir "snippets"))
(setq yas-snippet-dirs dido-snippets-dir)

(yas-global-mode 1)

(provide 'yasnippet-config)
