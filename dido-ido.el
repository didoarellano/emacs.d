(require 'ido)
(ido-mode t)

(add-to-list 'ido-ignore-files "\\.DS_Store")
(setq ido-enable-flex-matching t)

;; Recentf mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 30)

(global-set-key (kbd "C-x C-i") 'ido-imenu)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-r") 'ido-recentf-open) ; was find-file-read-only

;; Display ido results vertically, rather than horizontally
;; from http://emacswiki.org/emacs/InteractivelyDoThings#toc20
(add-hook 'ido-minibuffer-setup-hook
          (lambda () (set (make-local-variable 'truncate-lines) nil) ))
(setq ido-decorations
      (quote ("\n-> "
              ""
              "\n   "
              "\n   ..."
              "["
              "]"
              " [No match]"
              " [Matched]"
              " [Not readable]"
              " [Too big]"
              " [Confirm]")))


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

;; Use ido for imenu
;; from https://gist.github.com/2360578
(require 'imenu)
(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))

                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))

                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))

                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                     (if (string-match regexp symbol) symbol))
                                                   symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))

      ;; Push mark here instead of using Magnars'
      ;; https://gist.github.com/2350388. Works for me so far.
      (push-mark)
      (goto-char position))))


(provide 'dido-ido)
