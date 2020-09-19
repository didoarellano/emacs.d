;;; ~/src/emacs.d/packages/open-terminal-here/open-terminal-here.el -*- lexical-binding: t; -*-

(defvar open-terminal-here--command "xterm -e cd")

(defun open-terminal-here ()
  (interactive)
  (call-process-shell-command
   (concat open-terminal-here--command
           " "
           (shell-quote-argument default-directory)) nil 0))

(provide 'open-terminal-here)
