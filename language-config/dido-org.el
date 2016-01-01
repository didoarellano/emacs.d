(setq org-directory "~/Dropbox/org")
(setq org-agenda-files '("~/Dropbox/org/agenda"))

(setq org-agenda-restore-windows-after-quit t)

;; Syntax highlighted src blocks
(setq org-src-fontify-natively t)

(setq dido-org-inbox-file "~/Dropbox/org/agenda/inbox.org")

;; Capturing
(setq org-capture-templates
      '(("n" "Note" entry (file dido-org-inbox-file)
         "* %^{Heading}%?")
        ("t" "Todo" entry (file dido-org-inbox-file)
         "* TODO %^{Heading}%?")))

;; Refiling
(setq org-refile-targets '((org-agenda-files :maxlevel . 1)))
(setq org-refile-allow-creating-parent-nodes (quote confirm))
(setq org-completion-use-ido t)
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)

;; Archiving
;; Archive directory is prefixed with an underscore to make archive files appear
;; after agenda files in `eproject-find-file'.
(setq org-archive-location (concat org-directory "/_archive/%s_archive::"))
(add-to-list 'projectile-globally-ignored-directories "~/Dropbox/org/_archive")

;; Todos
(setq org-todo-keywords
      '((sequence "TODO(t)"
                  "|"
                  "DONE(d)"
                  "CANCELED(c)")))

(setq org-log-done "time")

;; (setq org-agenda-custom-commands
;;       '(("d" "Today's scheduled and chosen tasks"
;;          ((org-agenda-list 1)
;;           (todo "INPROGRESS")
;;           (todo "DOIT")))
;;         ("x" todo "DONE")))


(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c o") 'dido-open-org-agenda-files)

(evil-define-key 'motion org-agenda-mode-map (kbd "t")
  (lambda ()
    (interactive)
    (org-agenda-todo "TODO")))
(evil-define-key 'motion org-agenda-mode-map (kbd "d")
  (lambda ()
    (interactive)
    (org-agenda-todo "DONE")))
(evil-define-key 'motion org-agenda-mode-map (kbd "c")
  (lambda ()
    (interactive)
    (org-agenda-todo "CANCELED")))
(evil-define-key 'motion org-agenda-mode-map (kbd "s")
  (lambda ()
    (interactive)
    (org-agenda-schedule "Today")))
(evil-define-key 'motion org-agenda-mode-map (kbd "B") 'org-agenda-bulk-action)
(evil-define-key 'normal org-mode-map (kbd "<M-return>")
  (lambda ()
    (interactive)
    (dido-insert-org-heading-from-normal-state 'org-meta-return)))
(evil-define-key 'normal org-mode-map (kbd "<M-S-return>")
  (lambda ()
    (interactive)
    (dido-insert-org-heading-from-normal-state 'org-insert-todo-heading)))


(require 'org-bullets)

(defun dido-org-mode-hook ()
  (setq mode-name "org")
  (org-bullets-mode 1)

  ;; Relative line numbers are useless with all the folds. Regular
  ;; line numbers is still useful but how do we toggle it on a
  ;; per-buffer/per-mode basis? Turn off for now.
  (linum-mode -1))
(add-hook 'org-mode-hook 'dido-org-mode-hook)


(defun dido-insert-org-heading-from-normal-state (org-insert-fn)
  ;; Use `org-end-of-line' in `evil-emacs-state' instead of
  ;; `evil-end-of-line'/regular `end-of-line' because the latter two will
  ;; insert the heading above the org property drawer.
  (evil-emacs-state)
  (org-end-of-line)

  (call-interactively org-insert-fn)
  (evil-insert-state))

(defun dido-open-org-agenda-files (file)
  (interactive (list (ido-completing-read
                      "Agenda files: "
                      (mapcar 'file-name-nondirectory (org-agenda-files))
                      nil t)))
  (find-file (concat (car org-agenda-files) "/" file)))

(defun dido-archive-done-tasks ()
  "Archive DONE and CANCELED tasks"
  ;; TODO Find out if there's a way to restore scroll position.
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'tree)
  (org-map-entries 'org-archive-subtree "/CANCELED" 'tree))

(provide 'dido-org)
