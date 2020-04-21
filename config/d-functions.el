(defun d-today ()
  (format-time-string "%Y-%m-%d %a"))

;; http://www.reddit.com/r/emacs/comments/2u5uzq/i_wrote_a_somewhat_useful_elisp_macro/co5lfvr
(defun d-evil-define-multiple (keymaps bindings)
  "Define evil keymaps for multiple modes."
  (dolist (keymap keymaps)
    (dolist (x bindings)
      (cl-destructuring-bind (mode key cmd)
          x
        (eval `(evil-define-key ,mode ,keymap ,key ',cmd))))))

;; Case twiddling
;; http://lists.gnu.org/archive/html/help-gnu-emacs/2008-10/msg00677.html
(defun toggle-letter-case ()
  "Toggle the letter case of current word or text selection. Toggles from 3
    cases: upper case, lower case, title case, in that cyclic order."
  (interactive)
  (let (pos1 pos2 (deactivate-mark nil) (case-fold-search nil))
    (if (and transient-mark-mode mark-active)
        (setq pos1 (region-beginning)
              pos2 (region-end))
      (setq pos1 (car (bounds-of-thing-at-point 'word))
            pos2 (cdr (bounds-of-thing-at-point 'word))))

    (when (not (eq last-command this-command))
      (save-excursion
        (goto-char pos1)
        (cond
         ((looking-at "[[:lower:]][[:lower:]]") (put this-command 'state "all lower"))
         ((looking-at "[[:upper:]][[:upper:]]") (put this-command 'state "all caps"))
         ((looking-at "[[:upper:]][[:lower:]]") (put this-command 'state "init caps"))
         (t (put this-command 'state "all lower")))))

    (cond
     ((string= "all lower" (get this-command 'state))
      (upcase-initials-region pos1 pos2) (put this-command 'state "init caps"))
     ((string= "init caps" (get this-command 'state))
      (upcase-region pos1 pos2) (put this-command 'state "all caps"))
     ((string= "all caps" (get this-command 'state))
      (downcase-region pos1 pos2) (put this-command 'state "all lower")))))

;; Use ido for recentf
;; http://www.masteringemacs.org/articles/2011/01/27/find-files-faster-recent-files-package/#comment-397
(defun d-ido-recentf-open ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (let ((home (expand-file-name (getenv "HOME"))))
    (find-file
     (ido-completing-read "Recent files: "
                          (mapcar (lambda (path)
                                    (replace-regexp-in-string home "~" path))
                                  recentf-list)
                          nil t))))

(defun d-kill-this-buffer ()
  "Kill current buffer without confirmation."
  (interactive)
  (kill-buffer (current-buffer)))

(defun d-projectile-or-ido-find-file ()
  "If in a projectile project do `projectile-find-file' otherwise fall back to
`ido-find-file'."
  (interactive)
  (if (projectile-project-p) (projectile-find-file)
    (ido-find-file)))

(defun d-projectile-or-ido-switch-buffer ()
  "If in a projectile project do `projectile-switch-to-buffer' otherwise fall back to
`ido-switch-buffer'."
  (interactive)
  (if (projectile-project-p) (projectile-switch-to-buffer)
    (ido-switch-buffer)))

;; From:
;; http://tuxicity.se/emacs/elisp/2010/03/26/rename-file-and-buffer-in-emacs.html
;; TODO: Incorporate this variation[1] which allows renaming of buffers that aren't
;; visiting a file.
;; [1]: http://www.stringify.com/2006/apr/24/rename/
(defun rename-file-and-buffer ()
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

;; Adapted from:
;; http://rejeep.github.io/emacs/elisp/2010/11/16/delete-file-and-buffer-in-emacs.html
;; Changes: Make sure the file gets moved to trash instead of deleting even
;; though we set `delete-by-moving-to-trash' to t already.
(defun delete-file-and-buffer ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename t)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(defvar d-git-branch-name "")
(defun d-get-git-branch-name (&optional frame)
  (let ((branch "")
        (shell-output (substring (shell-command-to-string "git rev-parse --abbrev-ref HEAD &") 0 -1)))
    (when (not (string-match "fatal:" shell-output))
      (setq branch shell-output))
    (setq-local d-git-branch-name branch)))
;; TODO Add magit branch-related hooks
(add-hook 'focus-in-hook 'd-get-git-branch-name)
(add-hook 'after-make-frame-functions 'd-get-git-branch-name)

(provide 'd-functions)
