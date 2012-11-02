(require 'ace-jump-mode)

(define-key evil-motion-state-map (kbd "SPC") 'dido-do-ace-jump-char-or-line)
(define-key evil-motion-state-map (kbd "C-SPC") 'ace-jump-word-mode)

(defun dido-do-ace-jump-char-or-line (arg)
  "[prefix] SPC executes `ace-jump-line-mode', [prefix] <x> executes `ace-jump-char-mode'
with <x> as query char."
  (interactive "p")
  (let ((next-key (read-event)))
    (if (= next-key ?\s) (ace-jump-line-mode)
      (ace-jump-char-mode next-key))))


(provide 'ace-jump-mode-config)
