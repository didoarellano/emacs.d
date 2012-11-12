(setq mode-name "js2")

(setq-default js2-indent-on-enter-key t)
(setq-default js2-enter-indents-newline t)
(setq-default js2-allow-keywords-as-property-names nil)
(setq-default js2-idle-timer-delay 0.1)
(setq-default js2-strict-inconsistent-return-warning nil)
(setq-default js2-include-rhino-externs nil)
(setq-default js2-include-gears-externs nil)
(setq-default js2-concat-multiline-strings 'eol)

;; Unset js2-mode's C-a (js2-beginning-of-line) mapping. I want my tmux-like
;; workgroups prefix.
(define-key js2-mode-map (kbd "C-a") nil)

(define-key evil-insert-state-local-map
  (kbd "C-;") 'dido-insert-semicolon-at-eol)


(provide 'dido-js2-mode-hook)
