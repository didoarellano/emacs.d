;; Make command key meta
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)


;; Evil mapppings for ace-jump-mode
(define-key evil-normal-state-map (kbd "SPC") 'do-ace-jump-char-or-line)
(define-key evil-normal-state-map (kbd "C-SPC") 'ace-jump-word-mode)

(defun do-ace-jump-char-or-line (arg)
  "SPC SPC executes ace-jump-line-mode, SPC <x> executes
ace-jump-char-mode with <x> as query char."
  (interactive "p")
  (let ((next-key (read-event)))
    (if (= next-key ?\s) (ace-jump-line-mode)
      (ace-jump-char-mode next-key))))


;; Quicker scrolling with C-e & C-y
(defun quicker-evil-scroll-line-down ()
  (interactive)
  (evil-scroll-line-down 5))
(defun quicker-evil-scroll-line-up ()
  (interactive)
  (evil-scroll-line-up 5))

(define-key evil-normal-state-map (kbd "C-e") 'quicker-evil-scroll-line-down)
(define-key evil-visual-state-map (kbd "C-e") 'quicker-evil-scroll-line-down)
(define-key evil-normal-state-map (kbd "C-y") 'quicker-evil-scroll-line-up)
(define-key evil-visual-state-map (kbd "C-y") 'quicker-evil-scroll-line-up)


;; Quicker access to M-x.
(define-key evil-normal-state-map (kbd ";") 'smex)
(define-key evil-visual-state-map (kbd ";") 'smex)


;; Overwrite find-file-read-only with ido-recentf-open
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)


;; Use C-x C-f for eproject-find-file if we're in a project & ido-find-file
;; when we're not
(global-set-key (kbd "C-x C-f")
                '(lambda ()
                   (interactive)
                   (if eproject-root (eproject-find-file)
                     (ido-find-file))))

;; Just in case we want regular ido-find-file in a project
(global-set-key (kbd "C-c C-x C-f") 'ido-find-file)


(provide 'key-bindings-config)
