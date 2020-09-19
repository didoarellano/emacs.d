;;; ~/src/emacs.d/packages/comment-dwim-line/comment-dwim-line.el -*- lexical-binding: t; -*-

(defun comment-dwim-line (&optional arg)
  "If no region is selected, current line is not blank, and we are not at the
end of the line, then comment or uncomment the current line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(provide 'comment-dwim-line)
