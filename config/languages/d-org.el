(defconst ORG-TODO-KEYWORD-TODO "✪ TODO")
(defconst ORG-TODO-KEYWORD-NOTE "♫ NOTE")
(defconst ORG-TODO-KEYWORD-DONE "✔ DONE")
(defconst ORG-TODO-KEYWORD-WAITING "⚑ WAITING")
(defconst ORG-TODO-KEYWORD-CANCELED "✘ CANCELED")

(evil-set-initial-state 'org-agenda-mode 'motion)
(setq org-agenda-restore-windows-after-quit t)
;; Syntax highlighted src blocks
(setq org-src-fontify-natively t)
(setq org-startup-indented t)

(setq org-directory "~/Dropbox/org")
(setq org-agenda-files '("~/Dropbox/org/agenda"))

;; Capturing
(setq d-org-inbox-file "~/Dropbox/org/inbox.org")
;; (setq org-capture-templates
;;       '(("n" "Note" entry (file d-org-inbox-file)
;;          "* %^{Heading}%?")
;;         ("t" "Todo" entry (file d-org-inbox-file)
;;          "* TODO %^{Heading}%?")))
(setq org-capture-templates
      `(("n" "Note" entry (file d-org-inbox-file)
         ,(concat "* " ORG-TODO-KEYWORD-NOTE " " "%^{Heading}%?"))
        ("t" "Todo" entry (file d-org-inbox-file)
         ,(concat "* " ORG-TODO-KEYWORD-TODO " " "%^{Heading}%?"))))

;; Refiling
(setq org-refile-targets '((org-agenda-files :maxlevel . 1)))
(setq org-refile-allow-creating-parent-nodes (quote confirm))
(setq org-completion-use-ido t)
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(add-hook 'org-after-refile-insert-hook 'org-save-all-org-buffers)

;; Archiving
;; Archive directory is prefixed with an underscore to make archive files appear
;; after agenda files in `eproject-find-file'.
(setq org-archive-location (concat org-directory "/_archive/%s_archive::"))
(add-to-list 'projectile-globally-ignored-directories "~/Dropbox/org/_archive")

;; Todos
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)"
;;                   "NOTE(n)"
;;                   "|"
;;                   "DONE(d)"
;;                   "WAITING(w)"
;;                   "CANCELED(c)")))
(setq org-todo-keywords
      `((sequence ,(concat ORG-TODO-KEYWORD-TODO "(t)")
                  ,(concat ORG-TODO-KEYWORD-NOTE "(n)")
                  ,(concat ORG-TODO-KEYWORD-WAITING "(w)")
                  "|"
                  ,(concat ORG-TODO-KEYWORD-DONE "(d)")
                  ,(concat ORG-TODO-KEYWORD-CANCELED "(c)"))))
(setq org-log-done "time")

;; (setq org-todo-keyword-faces
      ;; '(("NOTE" :foreground "red")))

;; (setq org-agenda-custom-commands
;;       '(("d" todo "DONE|CANCELED")))
(setq org-agenda-custom-commands
      `(("d" todo ,(concat ORG-TODO-KEYWORD-DONE "|" ORG-TODO-KEYWORD-CANCELED))))


(defun d-org-insert-heading-below (org-insert-fn)
  ;; Use `org-end-of-line' in `evil-emacs-state' instead of
  ;; `evil-end-of-line'/regular `end-of-line' because the latter two will
  ;; insert the heading above the org property drawer.
  (evil-emacs-state)
  (org-end-of-line)
  (call-interactively org-insert-fn)
  (evil-insert-state))

(defun d-org-open-agenda-files (file)
  (interactive (list (ido-completing-read
                      "Agenda files: "
                      (mapcar 'file-name-nondirectory (org-agenda-files))
                      nil t)))
  (find-file (concat (car org-agenda-files) "/" file)))

(evil-define-key 'normal org-mode-map (kbd "<M-return>")
  (lambda () (interactive)
    (d-org-insert-heading-below 'org-meta-return))) ; was `org-meta-return'
(evil-define-key 'insert org-mode-map (kbd "<M-return>")
  (lambda () (interactive)
    (d-org-insert-heading-below 'org-meta-return))) ; was `org-meta-return'
(evil-define-key 'normal org-mode-map (kbd "<M-S-return>")
  (lambda () (interactive)
    (d-org-insert-heading-below 'org-insert-todo-heading))) ; was `org-insert-todo-heading'
(evil-define-key 'insert org-mode-map (kbd "<M-S-return>")
  (lambda () (interactive)
    (d-org-insert-heading-below 'org-insert-todo-heading))) ; was `org-insert-todo-heading'
(define-key org-src-mode-map (kbd "C-s") 'org-edit-src-save)

(evil-leader/set-key-for-mode 'org-mode "ma" 'org-agenda)

;; (evil-leader/set-key-for-mode 'org-mode "mt" (lambda () (interactive) (org-todo "TODO")))
;; (evil-leader/set-key-for-mode 'org-mode "md" (lambda () (interactive) (org-todo "DONE")))
;; (evil-leader/set-key-for-mode 'org-mode "mc" (lambda () (interactive) (org-todo "CANCELED")))
(evil-leader/set-key-for-mode 'org-mode "mt" (lambda () (interactive) (org-todo ORG-TODO-KEYWORD-TODO)))
(evil-leader/set-key-for-mode 'org-mode "mn" (lambda () (interactive) (org-todo ORG-TODO-KEYWORD-NOTE)))
(evil-leader/set-key-for-mode 'org-mode "md" (lambda () (interactive) (org-todo ORG-TODO-KEYWORD-DONE)))
(evil-leader/set-key-for-mode 'org-mode "mw" (lambda () (interactive) (org-todo ORG-TODO-KEYWORD-WAITING)))
(evil-leader/set-key-for-mode 'org-mode "mc" (lambda () (interactive) (org-todo ORG-TODO-KEYWORD-CANCELED)))

;; TODO Add org-deadline mapping (C-c C-d)
(evil-leader/set-key-for-mode 'org-mode "ms" (lambda () (interactive) (org-schedule "Today" (d-today))))
(evil-leader/set-key-for-mode 'org-mode "mT" 'org-set-tags-command)
(evil-leader/set-key-for-mode 'org-mode "mA" 'd-org-archive-done-canceled-tasks)
(evil-leader/set-key-for-mode 'org-mode "mR" 'org-refile)

(defun d-org-archive-done-canceled-tasks ()
  (interactive)
  (defun d-org-archive-tree-set-up-for-next ()
    (org-archive-subtree)
    (setq org-map-continue-from (outline-previous-heading)))
  (when (y-or-n-p "Archive all DONE and CANCELED tasks in this file?")
    (org-map-entries
     'd-org-archive-tree-set-up-for-next
     (concat "TODO=" "\"" ORG-TODO-KEYWORD-DONE "\"" "|" "TODO=" "\"" ORG-TODO-KEYWORD-CANCELED "\"")
     'file)))

(defun d-org-mode-hook ()
  (setq mode-name "org")
  (define-key org-src-mode-map (kbd "C-c C-'") 'org-edit-src-exit)
  (define-key org-mode-map (kbd "C-c C-'") 'org-edit-special)
  (toggle-truncate-lines)

  ;; Relative line numbers are useless with all the folds. Regular
  ;; line numbers is still useful but how do we toggle it on a
  ;; per-buffer/per-mode basis? Turn off for now.
  (linum-mode 0))
(add-hook 'org-mode-hook 'd-org-mode-hook)

(defun d-org-agenda-mode-hook ()
  (linum-mode 0)
  (define-key org-agenda-mode-map (kbd "C-s") 'org-save-all-org-buffers)
  (evil-define-key 'motion org-agenda-mode-map (kbd "R") 'org-agenda-redo)
  (evil-define-key 'motion org-agenda-mode-map (kbd "B") 'org-agenda-bulk-action)
  (evil-define-key 'motion org-agenda-mode-map (kbd "m") 'org-agenda-bulk-mark)
  (evil-define-key 'motion org-agenda-mode-map (kbd "*") 'org-agenda-bulk-mark-all)
  (evil-define-key 'motion org-agenda-mode-map (kbd "A") 'org-agenda-archive)
  (evil-define-key 'motion org-agenda-mode-map (kbd "t") (lambda () (interactive) (org-agenda-todo ORG-TODO-KEYWORD-TODO)))
  (evil-define-key 'motion org-agenda-mode-map (kbd "n") (lambda () (interactive) (org-agenda-todo ORG-TODO-KEYWORD-NOTE)))
  (evil-define-key 'motion org-agenda-mode-map (kbd "d") (lambda () (interactive) (org-agenda-todo ORG-TODO-KEYWORD-DONE)))
  (evil-define-key 'motion org-agenda-mode-map (kbd "w") (lambda () (interactive) (org-agenda-todo ORG-TODO-KEYWORD-WAITING)))
  (evil-define-key 'motion org-agenda-mode-map (kbd "c") (lambda () (interactive) (org-agenda-todo ORG-TODO-KEYWORD-CANCELED)))
  ;; TODO Toggle scheduled state with "s"
  (evil-define-key 'motion org-agenda-mode-map (kbd "s") (lambda () (interactive) (org-agenda-schedule "Today" (d-today))))
  (evil-define-key 'motion org-agenda-mode-map (kbd "S") (lambda () (interactive) (let ((current-prefix-arg '(4))) (call-interactively 'org-agenda-schedule)))))
(add-hook 'org-agenda-mode-hook 'd-org-agenda-mode-hook)

(defun d-configure-floating-org-frame ()
  "Change the selected frame's title to agenda. `emacsclient` doesn't have a
  --title flag, which we need for i3 to float the frame."
  (interactive)
  (modify-frame-parameters (selected-frame)
                           (list (cons 'name "agenda")))
  (find-file d-org-inbox-file))

(defun d-org-bullets-config ()
  ;; Choose characters from:
  ;; http://nadeausoftware.com/articles/2007/11/latency_friendly_customized_bullets_using_unicode_characters
  ;; (setq org-bullets-bullet-list '("◉" "◎" "⚫" "○" "►" "◇"))
  (defun d-activate-org-bullets ()
    (org-bullets-mode 1))
  (add-hook 'org-mode-hook 'd-activate-org-bullets))

(setq org-hide-emphasis-markers t)

;; http://www.howardism.org/Technical/Emacs/orgmode-wordprocessor.html
;; This doesn't seem to be working
;; (font-lock-add-keywords 'org-mode
;;                         '(("^ +\\([-*]\\) "
;;                            (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(use-package org-bullets
  :ensure t
  :config (d-org-bullets-config))

(provide 'd-org)
