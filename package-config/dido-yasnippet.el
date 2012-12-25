(require 'yasnippet)

(defvar dido-snippets-dir (concat dotemacs-dir "snippets"))
(setq yas-snippet-dirs dido-snippets-dir)

(yas-global-mode 1)

(defun snippet--js-function-punctuation ()
  (if (save-excursion
        (search-backward "function")
        (looking-back "= "))
      ";" ""))


(provide 'dido-yasnippet)
