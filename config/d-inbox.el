(global-set-key (kbd "C-s") 'save-buffer) ; was isearch-forward
(global-set-key (kbd "C-x C-h") 'mark-whole-buffer) ; was help buffer for C-x

(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(defun d-apply-in-class-config (profile)
  (setq linum-format "%2d ")
  (when (string= "light" profile)
    (load-theme `whiteboard t)
    (defface d-background
      '((t (:background "#ffffff"))) "")
    (custom-set-faces
     '(default ((t (:background "#ffffff"))))
     '(fringe ((t (:background "#ffffff"))))
     '(highlight ((t (:background "#dddddd")))))
    (find-file "~/tmp/jquery-101-latest/JS-jQuery-Exercises-Finished/assets/jquery.js")
    (d-powerline-init)))

(defun d-open-term ()
  (interactive)
  (call-process-shell-command (concat "roxterm -d " (shell-quote-argument default-directory)) nil 0))
(global-set-key (kbd "<f12>") 'd-open-term)

(defun d-move-buffer-to-own-frame ()
  (interactive)
  (when (< 1 (length (window-list)))
    (let ((current-window (selected-window)))
      (d-make-new-project-frame)
      (delete-window current-window))))
(global-set-key (kbd "<f9>") 'd-move-buffer-to-own-frame)

(use-package emmet-mode
  :ensure t)

(defun d-avy-config ()
  (setq avy-background t)
  (evil-leader/set-key "<SPC>" 'avy-goto-char-2))

(global-set-key (kbd "<mouse-3>") 'menu-bar-open)

(use-package avy
  :ensure t
  :config (d-avy-config))

(defun d-diff-hl-config-light ()
  (global-diff-hl-mode)
  (set-face-attribute 'diff-hl-change nil
                      :background "#c6d3e7"
                      :foreground "#4f78b5")
  (set-face-attribute 'diff-hl-delete nil
                      :background "#f8969b"
                      :foreground "#c30d17")
  (set-face-attribute 'diff-hl-insert nil
                      :background "#c6e7c5"
                      :foreground "#4cb64a")
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

(defun d-diff-hl-config-dark ()
  (global-diff-hl-mode)
  (set-face-attribute 'diff-hl-change nil
                      :background "#1b3246"
                      :foreground "#4682b4")
  (set-face-attribute 'diff-hl-delete nil
                      :background "#7b190f"
                      :foreground "#e74c3c")
  (set-face-attribute 'diff-hl-insert nil
                      :background "#124f2c"
                      :foreground "#2ecc71")
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

(use-package diff-hl
  :ensure t
  :init (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  :config (d-diff-hl-config-light))

(defun d-focus-config ()
  (evil-leader/set-key "af" 'focus-mode))

(use-package focus
  :ensure t
  :config (d-focus-config))

(defun d-highlight-indentation-config ()
  (set-face-background 'highlight-indentation-face "#111111")
  (set-face-background 'highlight-indentation-current-column-face "#333333")
  (evil-leader/set-key "ai" 'highlight-indentation-current-column-mode)
  (evil-leader/set-key "aI" 'highlight-indentation-mode))

(use-package highlight-indentation
  :ensure t
  :config (d-highlight-indentation-config))

;; (defun d-yasnippet-config()
;;   (setq yas-triggers-in-field t)
;;   (yas-global-mode 1))

;; (use-package yasnippet
;;   :ensure t
;;   :config (d-yasnippet-config))

(use-package keychain-environment
  :ensure t)

(use-package restclient
  :ensure t)

(defun d-calfw-config ()
  (setq cfw:display-calendar-holidays nil)
  (setq cfw:render-line-breaker 'cfw:render-line-breaker-wordwrap)
  (setq calendar-day-name-array
        ["Sun" "Mon" "Tue" "Wed" "Thu" "Fri" "Sat"])
  (setq calendar-week-start-day 1)
  (setq cfw:fchar-junction ?╋
        cfw:fchar-vertical-line ?┃
        cfw:fchar-horizontal-line ?━
        cfw:fchar-left-junction ?┣
        cfw:fchar-right-junction ?┫
        cfw:fchar-top-junction ?┯
        cfw:fchar-top-left-corner ?┏
        cfw:fchar-top-right-corner ?┓)
  (add-hook 'cfw:calendar-mode-hook 'd-calfw-hook))

(defun d-calfw-hook ()
  (linum-mode 0)
  (setq line-spacing 0))

(d-calfw-config)

(use-package calfw
  :ensure t
  :config (d-calfw-config))
(use-package calfw-org)

;; Suppress "Beginning of buffer" and "End of buffer" messages
;; http://superuser.com/a/1077571
(defadvice previous-line (around silencer activate)
  (condition-case nil
    ad-do-it
    ((beginning-of-buffer))))

(defadvice next-line (around silencer activate)
  (condition-case nil
    ad-do-it
    ((end-of-buffer))))

(provide 'd-inbox)
