(setq org-directory "~/Dropbox/org")
(setq org-agenda-files '("~/Dropbox/org/agenda"))

(setq org-mobile-directory "~/Dropbox/org-mobile")
(setq org-mobile-inbox-for-pull (concat org-directory "/dump.org"))

(setq org-agenda-restore-windows-after-quit t)

;; Syntax highlighted src blocks
(setq org-src-fontify-natively t)

;; Capturing
(setq org-capture-templates
      '(("g" "General" entry (file "dump.org")
         "* %^{Heading}\n  :PROPERTIES:\n  :Added: %T\n  :END:\n  %i%?")
        ("t" "Todo" entry (file "dump.org")
         "* TODO %^{Heading}\n  :LOGBOOK:\n  - State \"TODO\"       from \"\"           %<[%Y-%m-%d %a %H:%M]>\n  :END:\n  %i%?")))

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

;; Todos
(setq org-todo-keywords
      '((sequence "TODO(t!)"
                  "DOIT(d!)"
                  "INPROGRESS(p!)"
                  "|"
                  "DONE(x!)"
                  "CANCELED(c@)")))

;; Log state changes (including when todo is created) into :LOGBOOK: drawer
(setq org-treat-insert-todo-heading-as-state-change t)
(setq org-log-into-drawer t)

;; Habits
(require 'org)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)
(setq org-habit-preceding-days 6)
(setq org-habit-following-days 0)

(setq org-tag-persistent-alist
      '(("recurring")
        ("daily")))

(setq org-agenda-custom-commands
      '(("d" "Today's scheduled and chosen tasks"
         ((org-agenda-list 1)
          (todo "INPROGRESS")
          (todo "DOIT")))
        ("x" todo "DONE")))


(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "s-SPC") 'org-capture)
(global-set-key (kbd "C-s-SPC") (kbd "C-c a d"))
(global-set-key (kbd "C-c o") 'dido-open-org-agenda-files)
(defalias 'o 'dido-open-org-agenda-files)
(defalias 'archive 'dido-archive-done-tasks)

(evil-define-key 'motion org-agenda-mode-map (kbd "t") 'org-agenda-todo)
(evil-define-key 'motion org-agenda-mode-map (kbd "x")
  (lambda ()
    (interactive)
    (org-agenda-todo "DONE")))
(evil-define-key 'motion org-agenda-mode-map (kbd "c")
  (lambda ()
    (interactive)
    (org-agenda-todo "CANCELED")))
(evil-define-key 'motion org-agenda-mode-map (kbd "+") 'org-agenda-priority-up)
(evil-define-key 'motion org-agenda-mode-map (kbd "-") 'org-agenda-priority-down)
(evil-define-key 'motion org-agenda-mode-map (kbd "0") 'digit-argument)
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

(add-hook 'org-mode-hook
          (lambda ()
            (setq mode-name "org")
            (org-bullets-mode 1)

            ;; Relative line numbers are useless with all the folds. Regular
            ;; line numbers is still useful but how do we toggle it on a
            ;; per-buffer/per-mode basis? Turn off for now.
            (linum-mode -1)

            ;; Make my C-c SPC binding for org-capture work.
            ;; was org-table-blank-field
            (define-key org-mode-map (kbd "C-c SPC") nil)

            ))


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
