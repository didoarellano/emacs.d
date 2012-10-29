;;; eproject-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (eproject-eshell-cd-here eproject-multi-isearch-buffers
;;;;;;  eproject-todo eproject-grep eproject-revisit-project eproject-kill-project-buffers
;;;;;;  eproject-ibuffer eproject--project-buffers eproject-find-file)
;;;;;;  "eproject-extras" "eproject-extras.el" (20622 22638))
;;; Generated autoloads from eproject-extras.el

(autoload 'eproject-find-file "eproject-extras" "\
Present the user with a list of files in the current project.
to select from, open file when selected.

\(fn)" t nil)

(autoload 'eproject--project-buffers "eproject-extras" "\
Return an alist mapping each project root to its open buffers.

Does not list the project if it doesn't have any buffers.

\(fn)" nil nil)

(autoload 'eproject-ibuffer "eproject-extras" "\
Open an IBuffer window showing all buffers in the current project, or named project if PREFIX arg is supplied.

\(fn PREFIX)" t nil)

(autoload 'eproject-kill-project-buffers "eproject-extras" "\
Kill every buffer in the current project, including the current buffer.

If PREFIX is specified, prompt for a project name and kill those
buffers instead.

\(fn PREFIX)" t nil)

(autoload 'eproject-revisit-project "eproject-extras" "\
Given a project name, visit the root directory.

If PREFIX arg is supplied, run `eproject-find-file'.

\(fn PREFIX)" t nil)

(autoload 'eproject-grep "eproject-extras" "\
Search all files in the current project for REGEXP.

\(fn REGEXP)" t nil)

(autoload 'eproject-todo "eproject-extras" "\
Display a project TODO list.

Customize `eproject-todo-expressions' to control what this function looks for.

\(fn)" t nil)

(autoload 'eproject-multi-isearch-buffers "eproject-extras" "\
Do a `multi-isearch' on opened buffers in the current project.

Run `eproject-open-all-project-files' first or just
`eproject-grep' if you want to search all project files.

\(fn)" t nil)

(autoload 'eproject-eshell-cd-here "eproject-extras" "\
If there is an EShell buffer, cd to the project root in that buffer.

With the prefix arg LOOK-IN-INVISIBLE-BUFFERS looks in buffers that are not currently displayed.

\(fn &optional LOOK-IN-INVISIBLE-BUFFERS)" t nil)

;;;***

;;;### (autoloads nil nil ("eproject-pkg.el" "eproject-tests.el"
;;;;;;  "eproject.el") (20622 22638 505501))

;;;***

(provide 'eproject-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; eproject-autoloads.el ends here
