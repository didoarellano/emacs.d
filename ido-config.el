(require 'ido)

(ido-mode t)

;; AKA "fuzzy matching"
(setq ido-enable-flex-matching t)

(add-to-list 'ido-ignore-files "\\.DS_Store")

;; Display ido results vertically, rather than horizontally
;; from http://emacswiki.org/emacs/InteractivelyDoThings#toc20
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

(provide 'ido-config)
