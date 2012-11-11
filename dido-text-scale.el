(define-globalized-minor-mode
  global-text-scale-mode
  text-scale-mode
  (lambda () (text-scale-mode 1)))

(defun global-text-scale-adjust (inc)
  "Adjust text-scale in all windows in all frames."
  (interactive)
  (text-scale-set 1)
  (kill-local-variable 'text-scale-mode-amount)
  (setq-default text-scale-mode-amount (+ text-scale-mode-amount inc))
  (global-text-scale-mode 1))

;; Use meta to scale text in all windows in all frames.
(global-set-key (kbd "M-=")
                '(lambda () (interactive) (global-text-scale-adjust 1)))
(global-set-key (kbd "M--")
                '(lambda () (interactive) (global-text-scale-adjust -1)))
(global-set-key (kbd "M-0")
                '(lambda () (interactive)
                   (global-text-scale-adjust (- text-scale-mode-amount))
                   (global-text-scale-mode -1)))

;; Use meta-super to scale text in all windows displaying the current buffer.
(global-set-key (kbd "M-s-=")
                '(lambda () (interactive) (text-scale-increase 1)))
(global-set-key (kbd "M-s--")
                '(lambda () (interactive) (text-scale-decrease 1)))
(global-set-key (kbd "M-s-0")
                '(lambda () (interactive) (text-scale-set 0)))


(provide 'dido-text-scale)
