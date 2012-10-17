(require 'recentf)

(recentf-mode 1)
(setq recentf-max-menu-items 30)

;; Use ido for recentf
;; from http://www.masteringemacs.org/articles/2011/01/27/find-files-faster-recent-files-package/#comment-397
(defun ido-recentf-open ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (let ((home (expand-file-name (getenv "HOME"))))
    (find-file
     (ido-completing-read "Recentf open: "
                          (mapcar (lambda (path)
                                    (replace-regexp-in-string home "~" path))
                                  recentf-list)
                          nil t))))

(provide 'recentf-ido-config)
