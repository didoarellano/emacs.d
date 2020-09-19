;;; ~/src/emacs.d/packages/open-terminal-here/open-terminal-here.el -*- lexical-binding: t; -*-

(defun open-terminal-here ()
  (interactive)
  (call-process-shell-command
   (concat "kitty --directory " (shell-quote-argument
                                 default-directory)) nil 0))

(provide 'open-terminal-here)
