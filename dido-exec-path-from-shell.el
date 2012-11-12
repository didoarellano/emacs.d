(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


(provide 'dido-exec-path-from-shell)
