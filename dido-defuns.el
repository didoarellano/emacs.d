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

(defun dido-do-find-file-eproject-or-ido ()
  "If in a project that eproject recognizes (naive check for non-nil-ness of
`eproject-root'), do `eproject-find-file' otherwise fall back to
`ido-find-file'."
  (interactive)
  (if eproject-root (eproject-find-file)
    (ido-find-file)))


;; From:
;; http://tuxicity.se/emacs/elisp/2010/03/26/rename-file-and-buffer-in-emacs.html
;; TODO
;; 1. Incorporate this variation[1] which allows renaming of buffers that aren't
;; visiting a file.
;; [1]: http://www.stringify.com/2006/apr/24/rename/
(defun rename-this-buffer-and-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (cond ((get-buffer new-name)
               (error "A buffer named '%s' already exists!" new-name))
              (t
               (rename-file filename new-name 1)
               (rename-buffer new-name)
               (set-visited-file-name new-name)
               (set-buffer-modified-p nil)
               (message "File '%s' successfully renamed to '%s'" name (file-name-nondirectory new-name))))))))


(provide 'dido-defuns)
