;; Make command key meta
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)


;; ===============
;; Global Mappings
;; ===============

(global-set-key (kbd "C-x C-n") 'make-frame-command)
(define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)

;; Overwrite find-file-read-only with ido-recentf-open
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;; Just in case we want regular ido-find-file in a project
(global-set-key (kbd "C-c C-x C-f") 'ido-find-file)

;; Makes C-x C-b consistent with C-x C-f/C-r mappings.
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

;; More "useful" line-commenting shortcut
;; Originally bound to (comment-dwim)
(global-set-key (kbd "M-;") 'dido-comment-dwim-line)


;; =============
;; Evil Mappings
;; =============

;; NOTE: normal and visual states inherit from motion state.

;; Quicker scrolling with C-e & C-y
(define-key evil-motion-state-map (kbd "C-e") 'dido-evil-scroll-line-down)
(define-key evil-motion-state-map (kbd "C-y") 'dido-evil-scroll-line-up)

;; Quicker access to smexy M-x.
(define-key evil-motion-state-map (kbd ";") 'smex)

(define-key evil-normal-state-map (kbd "<return>") 'dido-insert-newline-below)
(define-key evil-normal-state-map (kbd "<S-return>") 'dido-insert-newline-above)


(provide 'dido-key-bindings)
