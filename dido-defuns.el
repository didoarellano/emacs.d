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

(defun dido-html-evil-skip-to-matching-tag ()
  "Sorta replicate Vim's matchit behavior with HTML tags."
  (interactive)

  ;; This breaks when in evil visual-line for some reason (point doesn't move at
  ;; all) but works fine in visual-char so check if we're called in visual-line.
  (let ((visual-line (and (evil-visual-state-p) (eq (evil-visual-type) 'line))))
    (if visual-line
        ;; Switch temporarily to visual-char.
        (progn
          (evil-exit-visual-state)
          (evil-visual-char)))

    ;; Jump to beginning of tag under point so that our naive regexes work.
    (sgml-beginning-of-tag)

    (cond ((looking-at "<[A-Za-z]+")
           ;; We're on an opening tag.
           (sgml-skip-tag-forward 1)
           (if (not (looking-at ">"))
               ;; Point is after our closing tag's ">" which will break
               ;; toggling between opening and closing tags. So move point back
               ;; to what is presumably the closing tag's ">".
               (backward-char 1)))

          ((looking-at "<\/[A-Za-z]+>")
           ;; We're on a closing tag.
           ;; Move point between "<" and "/" because if it's before "<"
           ;; `sgml-skip-tag-backward' goes to the wrong opening tag.
           (forward-char 1)
           (sgml-skip-tag-backward 1)))

    ;; Reactivate visual-line if we were called in it.
    (if visual-line (evil-visual-line))))


(defun dido-do-find-file-eproject-or-ido ()
  "If in a project that eproject recognizes (naive check for non-nil-ness of
`eproject-root'), do `eproject-find-file' otherwise fall back to
`ido-find-file'."
  (interactive)
  (if eproject-root (eproject-find-file)
    (ido-find-file)))

(provide 'dido-defuns)
