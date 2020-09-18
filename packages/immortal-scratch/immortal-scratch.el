;;; ~/src/emacs.d/packages/immortal-scratch/immortal-scratch.el -*- lexical-binding: t; -*-

;; Immortal *scratch* buffer
;; Credit to whoever wrote this. I've forgotten where I found this.
;; "ctto" *barf*
(defun immortal-scratch--kill-scratch-buffer ()
  ;; The next line is just in case someone calls this manually
  (set-buffer (get-buffer-create "*scratch*"))
  ;; Kill the current (*scratch*) buffer
  (remove-hook 'kill-buffer-query-functions 'immortal-scratch--kill-scratch-buffer)
  (kill-buffer (current-buffer))
  ;; make a brand new *scratch* buffer
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'immortal-scratch--kill-scratch-buffer)
  ;; Since we killed it, don't let caller do that
  nil)

(save-excursion
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'immortal-scratch--kill-scratch-buffer))

(provide 'immortal-scratch)
