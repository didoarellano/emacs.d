(defun d-evil-init ()
  (evil-mode 1)
  (setq evil-echo-state nil)
  (setq evil-want-fine-undo "Very fine")
  (setq evil-normal-state-tag   "N"
        evil-insert-state-tag   "I"
        evil-visual-state-tag   "V"
        evil-motion-state-tag   "M"
        evil-emacs-state-tag    "E"
        evil-replace-state-tag  "R"
        evil-operator-state-tag "O")

  (defun d-evil-scroll-line-down ()
    "Scroll down by bigger increments."
    (interactive)
    (evil-scroll-line-down 5))

  (defun d-evil-scroll-line-up ()
    "Scroll up by bigger increments."
    (interactive)
    (evil-scroll-line-up 5))

  (defun d-insert-newline-below ()
    "Insert newline below and mantain position of point."
    (interactive)
    (save-excursion
      (end-of-line)
      (newline)))

  (defun d-insert-newline-above ()
    "Insert newline above and mantain position of point."
    (interactive)
    (save-excursion
      (beginning-of-line)
      (newline)))

  (define-key evil-motion-state-map (kbd "C-e") 'd-evil-scroll-line-down)
  (define-key evil-motion-state-map (kbd "C-y") 'd-evil-scroll-line-up)
  (define-key evil-normal-state-map (kbd "<return>") 'd-insert-newline-below)
  (define-key evil-normal-state-map (kbd "<S-return>") 'd-insert-newline-above)
  (define-key evil-visual-state-map "~" 'toggle-letter-case)
  (define-key evil-insert-state-map (kbd "C-y") 'yank) ; was evil-copy-from-above

  ;; Readline bindings in Insert state. Apart from C-h,everything is default in non-Evil Emacs.
  (define-key evil-insert-state-map (kbd "C-a") 'move-beginning-of-line) ; was evil-paste-last-insertion
  (define-key evil-insert-state-map (kbd "C-h") 'backward-delete-char) ; was help character
  (define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line) ; was evil-copy-from-below
  (define-key evil-insert-state-map (kbd "C-d") 'delete-forward-char) ; was evil-shift-left-line
  (define-key evil-insert-state-map (kbd "C-k") 'kill-line) ; was evil-insert-digraph
  )

(defun d-evil-leader-init ()
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>"))

(defun d-evil-surround-init ()
  (global-evil-surround-mode 1)
  (evil-define-key 'visual evil-surround-mode-map "S" 'evil-substitute)
  (evil-define-key 'visual evil-surround-mode-map "s" 'evil-surround-region))

(defun evilmi-customize-keybinding ()
  (evil-define-key 'normal evil-matchit-mode-map "%" 'evilmi-jump-items)
  (evil-define-key 'visual evil-matchit-mode-map "%" 'd-evilmi-fix-jump-items-in-visual-mode))

(defun d-evilmi-fix-jump-items-in-visual-mode ()
  (interactive)
  (let ((visual-type (evil-visual-type)))
    (evil-exit-visual-state)
    (evil-set-marker ?\&)
    (evilmi-jump-items)
    (evil-visual-make-selection (evil-get-marker ?\&) (point) visual-type)))

(defun d-evil-matchit-init ()
  (global-evil-matchit-mode 1))

(defun d-evil-numbers-init ()
  (define-key evil-normal-state-map (kbd "+") 'evil-numbers/inc-at-pt) ; was evil-previous-line-first-non-blank
  (define-key evil-normal-state-map (kbd "-") 'evil-numbers/dec-at-pt) ; was evil-next-line-first-non-blank
  )

;; evil-leader needs to load before evil itself
(use-package evil-leader
  :ensure t
  :init (d-evil-leader-init))
(use-package evil
  :ensure t
  :init (d-evil-init))
(use-package evil-surround
  :ensure t
  :init (d-evil-surround-init))
(use-package evil-matchit
  :ensure t
  :init (d-evil-matchit-init))
(use-package evil-numbers
  :ensure t
  :init (d-evil-numbers-init))

(evil-set-initial-state 'package-menu-mode 'motion)
(evil-set-initial-state 'Custom-mode 'motion)

(provide 'd-evil-base)
