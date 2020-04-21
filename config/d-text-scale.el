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

(defun --scale-linum ()
  (let ((height (+ (* 10 text-scale-mode-amount) 72)))
    (if (= text-scale-mode-amount 0) (setq linum-format " %3d"))
    (if (> text-scale-mode-amount 3) (setq linum-format "%3d "))
    (if (> text-scale-mode-amount 6) (setq linum-format "%3d  "))
    (if (> text-scale-mode-amount 8) (setq linum-format "%3d   "))
    (set-face-attribute 'linum nil :height height)))

;; Use meta to scale text in all windows displaying the current buffer.
(global-set-key (kbd "C-=")
                '(lambda ()
                   (interactive)
                   (text-scale-increase 1)
                   (--scale-linum)))

(global-set-key (kbd "C--")
                '(lambda ()
                   (interactive)
                   (text-scale-decrease 1)
                   (--scale-linum)
                   )) ; was `negative-argument'

(global-set-key (kbd "C-0")
                '(lambda ()
                   (interactive)
                   (text-scale-set 0)
                   (--scale-linum)
                   )) ; was `digit-argument'

;; Use meta-super to scale text in all windows in all frames.
(global-set-key (kbd "M-=")
                '(lambda ()
                   (interactive)
                   (global-text-scale-adjust 1)
                   (--scale-linum))) ; was `count-words'

(global-set-key (kbd "M--")
                '(lambda ()
                   (interactive)
                   (global-text-scale-adjust -1)
                   (--scale-linum))) ; was `negative-argument'

(global-set-key (kbd "M-0")
                '(lambda ()
                   (interactive)
                   (global-text-scale-adjust (- text-scale-mode-amount))
                   (global-text-scale-mode -1)
                   (--scale-linum))) ; was `digit-argument'

(provide 'd-text-scale)
