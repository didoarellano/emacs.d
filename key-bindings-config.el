(require 'dido-defuns)

;; Make command key meta
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)


;; ===============
;; Global Mappings
;; ===============

(global-set-key (kbd "C-x C-n") 'make-frame-command)
(define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)

;; Use C-x C-f for eproject-find-file if we're in a project & ido-find-file
;; when we're not
(global-set-key (kbd "C-x C-f") 'dido-do-find-file-eproject-or-ido)

;; Overwrite find-file-read-only with ido-recentf-open
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;; Just in case we want regular ido-find-file in a project
(global-set-key (kbd "C-c C-x C-f") 'ido-find-file)

;; Buffer navigation switcheroo.
;; Makes C-x C-b consistent with C-x C-f/C-r mappings.
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x b") 'list-buffers)

;; More "useful" line-commenting shortcut
;; Originally bound to (comment-dwim)
(global-set-key (kbd "M-;") 'dido-comment-dwim-line)


;; =============
;; Evil Mappings
;; =============

;; NOTE: normal and visual states inherit from motion state.

;; Evil mapppings for ace-jump-mode
(define-key evil-motion-state-map (kbd "SPC") 'dido-do-ace-jump-char-or-line)
(define-key evil-motion-state-map (kbd "C-SPC") 'ace-jump-word-mode)

;; Quicker scrolling with C-e & C-y
(define-key evil-motion-state-map (kbd "C-e") 'dido-evil-scroll-line-down)
(define-key evil-motion-state-map (kbd "C-y") 'dido-evil-scroll-line-up)

;; Quicker access to smexy M-x.
(define-key evil-motion-state-map (kbd ";") 'smex)

(define-key evil-normal-state-map (kbd "<return>") 'dido-insert-newline-below)
(define-key evil-normal-state-map (kbd "<S-return>") 'dido-insert-newline-above)

(define-key evil-insert-state-map (kbd "C-;") 'dido-insert-semicolon-at-eol)


;; ======================
;; Mode Specific Mappings
;; ======================

;; HTML mode
(evil-define-key 'insert html-mode-map
  (kbd "<return>") 'dido-html-expand-newline-if-between-tags)


(provide 'key-bindings-config)
