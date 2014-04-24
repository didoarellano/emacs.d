(require 'yasnippet)

(defvar dido-snippets-dir (concat dotemacs-dir "snippets"))
(setq yas-snippet-dirs dido-snippets-dir)
(setq yas-triggers-in-field t)

(yas-global-mode 1)

(defun yas-js-semicolon-or-parens ()
  (save-excursion
    (search-backward "function")
    (cond
     ((looking-back "= ") ";")
     ;; passing anon as callback turns into iife as callback. That's wrong.
     ;; ((looking-back "somechar(") "dido-insert-semicolon-at-eol")
     ((or (looking-back "(") (looking-back "= ("))
      (dido-insert-semicolon-at-eol) "()")
     (t ""))))


(provide 'dido-yasnippet)
