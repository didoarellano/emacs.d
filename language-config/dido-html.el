(evil-define-key 'insert html-mode-map (kbd "<return>")
  'dido-html-expand-newline-if-between-tags)

(evil-define-key 'motion html-mode-map (kbd "%")
  'dido-html-evil-skip-to-matching-tag)

(add-hook 'html-mode-hook
          (lambda ()
            (setq mode-name "html")
            ))


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

    (cond ((looking-at "<[A-Za-z0-9]+")
           ;; We're on an opening tag.
           (sgml-skip-tag-forward 1)
           (if (not (looking-at ">"))
               ;; Point is after our closing tag's ">" which will break
               ;; toggling between opening and closing tags. So move point back
               ;; to what is presumably the closing tag's ">".
               (backward-char 1)))

          ((looking-at "<\/[A-Za-z0-9]+>")
           ;; We're on a closing tag.
           ;; Move point between "<" and "/" because if it's before "<"
           ;; `sgml-skip-tag-backward' goes to the wrong opening tag.
           (forward-char 1)
           (sgml-skip-tag-backward 1)))

    ;; Reactivate visual-line if we were called in it.
    (if visual-line (evil-visual-line))))


(provide 'dido-html)
