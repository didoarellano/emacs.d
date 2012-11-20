(setq org-capture-templates
      '(("d" "Dump file" entry (file "~/Dropbox/org/dump.org")
         "* %^{Heading} %T\n\n%i%?")))

(global-set-key (kbd "C-c SPC") 'org-capture)

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


(provide 'dido-org)
