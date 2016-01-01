;; Make command key meta
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)


;; ===============
;; Global Mappings
;; ===============

(global-set-key (kbd "C-c n") 'make-frame-command)
(define-key minibuffer-local-map
  (kbd "C-w") 'backward-kill-word) ; was kill-region
(global-set-key (kbd "C-s") 'save-buffer) ; was isearch-forward
(global-set-key (kbd "C-s") 'save-buffer) ; was isearch-forward

;; More "useful" line-commenting shortcut
(global-set-key (kbd "M-;") 'dido-comment-dwim-line) ; was comment-dwim
(global-set-key (kbd "C-x C-h") 'mark-whole-buffer)

(defun d/make-new-project-frame ()
  "Create new frame, set workgroup to the parent frame's active workgroup, then open projectile-find-file."
  (interactive)
  (let (new-frame (make-frame)
                  (current-workgroup (wg-current-workgroup))
                  (current-buffer (current-buffer)))
    (switch-to-buffer-other-frame new-frame)
    (wg-set-current-workgroup current-workgroup)
    (switch-to-buffer current-buffer)
    (projectile-find-file)))

(global-set-key (kbd "C-S-n") 'd/make-new-project-frame)
(global-set-key (kbd "M-n") 'd/make-new-project-frame)

;; =============
;; Evil Mappings
;; =============

;; NOTE: normal and visual states inherit from motion state.

;; Quicker scrolling with C-e & C-y
(define-key evil-motion-state-map (kbd "C-e") 'dido-evil-scroll-line-down)
(define-key evil-motion-state-map (kbd "C-y") 'dido-evil-scroll-line-up)

;; Quicker access to smexy M-x.
(define-key evil-motion-state-map (kbd ";") 'smex)
(define-key evil-motion-state-map (kbd ":") 'evil-ex)
(define-key evil-normal-state-map (kbd "!") 'shell-command)

(define-key evil-normal-state-map (kbd "<return>") 'dido-insert-newline-below)
(define-key evil-normal-state-map (kbd "<S-return>") 'dido-insert-newline-above)

(define-key evil-visual-state-map "~" 'toggle-letter-case)

(define-key evil-insert-state-map (kbd "C-y") 'yank) ; was evil-copy-from-above

;; Readline bindings in Insert state. Apart from C-h, everything is default in
;; non-Evil Emacs.
(define-key evil-insert-state-map (kbd "C-h") 'backward-delete-char) ; was help character
(define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line) ; was yank
(define-key evil-insert-state-map (kbd "C-d") 'delete-forward-char) ; was evil-shift-left-line
(define-key evil-insert-state-map (kbd "C-k") 'kill-line) ; was evil-insert-digraph


;; =======
;; Aliases
;; =======

(defalias 'rename 'rename-this-buffer-and-file)
(defalias 'wrap 'toggle-truncate-lines)


(provide 'dido-general-keys-and-aliases)
