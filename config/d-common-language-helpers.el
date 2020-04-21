(defun d-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command. If no region is selected, and
current line is not blank, and we are not at the end of the line, then
comment current line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key (kbd "M-;") 'd-comment-dwim-line) ; was comment-dwim

(defun d-insert-semicolon-at-eol ()
  "Insert a semicolon at end-of-line and maintain position of point."
  (interactive)
  (save-excursion
    (end-of-line)
    (insert ";")))

;; TODO Refactor into a generic function that takes pairs to check to make it
;; work with html-mode for example (see `d-html-expand-newline-if-between-tags').
(defun d-expand-bracket-pair ()
  (interactive)
  (if (not (or (and (looking-back "{") (looking-at "}")) (and (looking-back "\\[") (looking-at "]"))))
      (newline)
    (progn
      (newline-and-indent)
      (newline-and-indent)
      (previous-line)
      (indent-according-to-mode))))

(d-evil-define-multiple '(js2-mode-map
                          js-mode-map
                          php-mode-map
                          css-mode-map
                          scss-mode-map)
                        '(('insert (kbd "C-;") d-insert-semicolon-at-eol)
                          ('insert (kbd "<RET>") d-expand-bracket-pair)))

(defun d-html-expand-newline-if-between-tags ()
  "Expand newline like when between html tags and fall back to `evil-ret' if
not."
  (interactive)
  (if (not (and (looking-at "<") (looking-back ">")))
      (evil-ret)
    (progn
      (newline-and-indent)
      (newline-and-indent)
      (previous-line)
      (indent-according-to-mode))))
(d-evil-define-multiple '(html-mode-map
                          web-mode-map)
                          '(('insert (kbd "<RET>") d-html-expand-newline-if-between-tags)))

(provide 'd-common-language-helpers)
