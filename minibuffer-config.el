;; Ido mode
(require 'ido)
(ido-mode t)
(add-to-list 'ido-ignore-files "\\.DS_Store")

;; AKA "fuzzy matching"
(setq ido-enable-flex-matching t)

;; Display ido results vertically, rather than horizontally
;; from http://emacswiki.org/emacs/InteractivelyDoThings#toc20
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)


;; Recentf mode
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


;; Smex
(require 'smex)
(smex-initialize)
(setq smex-key-advice-ignore-menu-bar t)

;; Don't poop in my home directory
(setq smex-save-file (concat dido-tmp-directory "smex-items"))

;; Smexify my M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; This is the old M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


(provide 'minibuffer-config)