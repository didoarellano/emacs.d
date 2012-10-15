(setq mode-name "JS2")

(setq-default js2-indent-on-enter-key t)
(setq-default js2-enter-indents-newline t)
(setq-default js2-allow-keywords-as-property-names nil)
(setq-default js2-idle-timer-delay 0.1)
(setq-default js2-strict-inconsistent-return-warning nil)
(setq-default js2-include-rhino-externs nil)
(setq-default js2-include-gears-externs nil)
(setq-default js2-concat-multiline-strings 'eol)


(provide 'js2-mode-config)
