(define-key minibuffer-local-map (kbd "<escape>") 'keyboard-escape-quit)
(define-key minibuffer-local-map (kbd "<escape>") 'keyboard-escape-quit)
(define-key minibuffer-local-ns-map (kbd "<escape>") 'keyboard-escape-quit)
(define-key minibuffer-local-completion-map (kbd "<escape>") 'keyboard-escape-quit)
(define-key minibuffer-local-must-match-map (kbd "<escape>") 'keyboard-escape-quit)

(define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word) ; was `kill-region'

(require 'ido)
(ido-mode t)
(ido-everywhere)
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
(setq ido-auto-merge-work-directories-length -1)
(setq ido-decorations
      (quote ("\n ▶ "
              ""
              "\n   "
              "\n   ..."
              "  ▶ "
              ""
              "  ✗ No match"
              "  ✓ Matched"
              "  ✗ Not readable"
              "  ✗ Too big"
              "  ↵ Confirm")))

(defun d-ido-minibuffer-setup-hook()
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match) ; was next-line
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match) ; was ido-toggle-prefix

  ;; Display ido results vertically, rather than horizontally
  ;; from http://emacswiki.org/emacs/InteractivelyDoThings#toc20
  (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'd-ido-minibuffer-setup-hook)

(defun d-flx-ido-init ()
  (flx-ido-mode 1)
  (setq ido-use-faces nil))

(defun d-ido-ubiquitous-init ()
  (ido-ubiquitous-mode t))

(defun d-smex-init ()
  (smex-initialize)
  (setq smex-key-advice-ignore-menu-bar t)

  ;; Don't poop in my home directory
  (setq smex-save-file (concat d-tmp-directory "smex-items"))

  ;; Smexify my M-x
  (global-set-key (kbd "M-x") 'smex)
  (define-key evil-motion-state-map (kbd ";") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)

  ;; This is the old M-x
  (global-set-key (kbd "C-c M-x") 'execute-extended-command))

(use-package flx-ido
  :ensure t
  :init (d-flx-ido-init))
(use-package ido-ubiquitous
  :ensure t
  :init (d-ido-ubiquitous-init))
(use-package smex
  :ensure t
  :init (d-smex-init))

(provide 'd-minibuffer)
