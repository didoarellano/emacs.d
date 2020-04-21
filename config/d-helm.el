(defun d-helm-init ()
  ;; (global-set-key (kbd "M-x") 'helm-M-x)
  ;; (setq helm-M-x-fuzzy-match t)
  (setq helm-autoresize-max-height 23)
  (setq helm-autoresize-min-height 23)
  (setq helm-display-header-line nil)
  (setq helm-split-window-in-side-p t))


(defun d-helm-config ()
  (helm-autoresize-mode nil)
  (define-key helm-map (kbd "C-w") 'backward-kill-word)
  (define-key helm-map (kbd "C-[") 'helm-keyboard-quit)
  (set-face-attribute 'helm-source-header nil
                      :background "none"
                      :foreground "#eeeeee")
  (set-face-attribute 'helm-selection nil
                      :background "#444444"
                      :foreground "#eeeeee")
  (setq helm-mode-line-string nil)
  ;; (linum-mode 0)
  )

(defun d-get-dash-docsets (dir)
  (split-string
   (shell-command-to-string
    (concat "find "
            dir
            " -maxdepth 1"
            " -type d"
            " -name \"*.docset\""
            " -exec basename -s .docset {}"
            " \\;"))
   "[\n]"))

(defun d-reload-docsets ()
  (interactive)
  (setq helm-dash-common-docsets (d-get-dash-docsets dash-docsets-path))
  (helm-dash-reset-connections))

(defun open-in-uzbl (url)
  (interactive)
  (call-process-shell-command (concat "uzbl " (shell-quote-argument url) " &") nil 0))

(defun d-helm-dash-config()
  (setq dash-docsets-path "~/Documents/dash-docsets")
  (setq helm-dash-docsets-path dash-docsets-path)
  (setq helm-dash-browser-func 'open-in-uzbl)
  (setq helm-dash-min-length 2)
  (setq helm-dash-common-docsets (d-get-dash-docsets dash-docsets-path))
  (evil-leader/set-key "ad" 'helm-dash-at-point)
  (evil-leader/set-key "aD" 'helm-dash))

(use-package helm
  :ensure t
  :init (d-helm-init)
  :config (d-helm-config))
;; (use-package helm-projectile
;;   :ensure t)
(use-package helm-dash
  :ensure t
  :config (d-helm-dash-config))

(provide 'd-helm)
