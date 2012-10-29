(defun dido-do-ace-jump-char-or-line (arg)
  "[prefix] SPC executes `ace-jump-line-mode', [prefix] <x> executes `ace-jump-char-mode'
with <x> as query char."
  (interactive "p")
  (let ((next-key (read-event)))
    (if (= next-key ?\s) (ace-jump-line-mode)
      (ace-jump-char-mode next-key))))

(defun dido-insert-newline-below ()
  "Insert newline below and mantain position of point."
  (interactive)
  (save-excursion
    (end-of-line)
    (newline)))

(defun dido-insert-newline-above ()
  "Insert newline above and mantain position of point."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (newline)))

(defun dido-insert-semicolon-at-eol ()
  "Insert a semicolon at end-of-line and maintain position of point."
  (interactive)
  (save-excursion
    (end-of-line)
    (insert ";")))

(defun dido-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command. If no region is selected, and
current line is not blank, and we are not at the end of the line, then
comment current line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(defun dido-evil-scroll-line-down ()
  "Scroll down by bigger increments."
  (interactive)
  (evil-scroll-line-down 5))

(defun dido-evil-scroll-line-up ()
  "Scroll up by bigger increments."
  (interactive)
  (evil-scroll-line-up 5))

(defun dido-html-expand-newline-if-between-tags ()
  "Expand newline like `autopair-newline' when between html tags and fall back
to `evil-ret' if not."
  (interactive)
  (if (not (and (looking-at "<") (looking-back ">")))
      (evil-ret)
    (progn
      (newline-and-indent)
      (newline-and-indent)
      (previous-line)
      (indent-according-to-mode))))

(defun dido-do-find-file-eproject-or-ido ()
  "If in a project that eproject recognizes (naive check for non-nil-ness of
`eproject-root'), do `eproject-find-file' otherwise fall back to
`ido-find-file'."
  (interactive)
  (if eproject-root (eproject-find-file)
    (ido-find-file)))

(provide 'dido-defuns)
