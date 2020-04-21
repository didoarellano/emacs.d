;; UTF-8
;; https://www.reddit.com/r/emacs/comments/bnwajk/my_minimal_emacs_config/enayfv7/
;; (setq locale-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (prefer-coding-system 'utf-8)

;; Spaces over tabs. Display tabs as 4 spaces.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-stop-list (number-sequence 4 120 4))

;; Show spaces and tabs when whitespace-mode is toggled
(setq whitespace-style '(face spaces tabs space-mark tab-mark))

;; Delete trailing whitespace on write
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq-default require-final-newline t)

;; Wrap lines at 80 chars not 70
(setq-default fill-column 80)

;; Don't wrap by default. Toggle with M-x toggle-truncate-lines
(setq-default truncate-lines t)

;; Wrap on word boundaries when toggling truncation
(setq-default word-wrap t)

(defun d-visual-fill-column-config ()
  (setq-default visual-fill-column-width 120)
  (setq-default fringes-outside-margins nil))

(defun wrap ()
  (interactive)
  (if (null visual-line-mode)
      (progn
        (visual-line-mode)
        (visual-fill-column-mode))
    (visual-line-mode 0)
    (visual-fill-column-mode 0)))
(evil-leader/set-key "bw" 'wrap)

(use-package visual-fill-column
  :ensure t
  :config (d-visual-fill-column-config))

(provide 'd-text-handling)
