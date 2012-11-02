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


;; A hacky "fix" around ace-jump to make it work in evil's visual state.
;; The gist of the fix:
;; If in visual-state, exit out of it and perform the ace-jump in
;; normal-state. Use marks to keep track of where we jumped from/to to
;; restore/expand the region.
;; Use the "^" and "+" characters as marks because we'd never use those for
;; "regular" marks.

(add-hook 'evil-visual-state-entry-hook (lambda () (evil-set-marker ?^)))
(add-hook 'ace-jump-mode-before-jump-hook 'dido-ace-jump-fix-before)
(add-hook 'ace-jump-mode-end-hook 'dido-ace-jump-fix-end)

(setq dido-visual-type-before-ace-jump nil)

(defun dido-ace-jump-fix-before ()
  (setq dido-visual-type-before-ace-jump nil)
  (when (evil-visual-state-p)
        (setq dido-visual-type-before-ace-jump (evil-visual-type))
        (evil-exit-visual-state)))

(defun dido-ace-jump-fix-end ()
  (when dido-visual-type-before-ace-jump
    ;; Set mark on where we jumped to.
    (evil-set-marker ?+)

    ;; Go to mark where we jumped from.
    (evil-goto-mark ?^)

    ;; Restore the visual-state type we were in before the jump.
    (cond ((eq dido-visual-type-before-ace-jump 'line)
           (evil-visual-line))
          ((eq dido-visual-type-before-ace-jump 'inclusive)
           (evil-visual-char)))

    ;; Go back to where we jumped to, this time with the region active.
    (evil-goto-mark ?+)))


(provide 'ace-jump-mode-config)
