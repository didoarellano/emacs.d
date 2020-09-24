;;; ~/src/emacs.d/packages/shush-minibuffer/shush-minibuffer.el -*- lexical-binding: t; -*-

;; Suppress "Beginning of buffer" and "End of buffer" messages
;; https://superuser.com/a/1025827/182507
(defadvice previous-line (around silencer activate)
  (condition-case nil
    ad-do-it
    ((beginning-of-buffer))))
(defadvice next-line (around silencer activate)
  (condition-case nil
    ad-do-it
    ((end-of-buffer))))
;; The above works but this answer might be more future-proof and can work for
;; other messages we want to suppress.
;; https://superuser.com/a/1077571/182507

(provide 'shush-minibuffer)
