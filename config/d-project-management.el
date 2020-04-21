(defun d-make-new-workgroup-frame ()
  "Create new frame, set workgroup to the parent frame's active workgroup, then
open `d-projectile-or-ido-find-file'."
  (interactive)
  (let (new-frame (make-frame)
                  (current-workgroup (wg-current-workgroup))
                  (current-buffer (current-buffer)))
    (switch-to-buffer-other-frame new-frame)
    (wg-set-current-workgroup current-workgroup)
    (switch-to-buffer current-buffer)
    (d-projectile-or-ido-find-file)))

(defun d-make-new-project-frame ()
  (interactive)
  (let (new-frame (make-frame)
                  (current-buffer (current-buffer)))
    (switch-to-buffer-other-frame new-frame)
    (switch-to-buffer current-buffer)
    ;; fix powerline active window
    (sleep-for 0.000001)))

(global-set-key (kbd "C-S-n") 'd-make-new-project-frame)

(defun d-projectile-init ()
  (projectile-global-mode)
  (add-to-list 'projectile-globally-ignored-directories "elpa")
  (add-to-list 'projectile-globally-ignored-directories "auto-save-list")
  (add-to-list 'projectile-globally-ignored-directories "venv")
  (add-to-list 'projectile-globally-ignored-directories "node_modules")
  (setq projectile-switch-project-action 'projectile-dired)
  (setq projectile-known-projects-file
        (concat user-emacs-directory "projectile-bookmarks.eld"))

  (evil-leader/set-key "ps" 'projectile-switch-project)
  (evil-leader/set-key "pf" 'projectile-find-file)
  (evil-leader/set-key "pb" 'projectile-switch-to-buffer)
  (evil-leader/set-key "pg" 'projectile-ag)
  (evil-leader/set-key "pd" 'projectile-dired)

  (evil-leader/set-key "ff" 'd-projectile-or-ido-find-file)
  (evil-leader/set-key "bb" 'd-projectile-or-ido-switch-buffer))

;; (defun d-workgroups2-init ()
;;   (setq wg-use-default-session-file nil)
;;   (setq wg-session-file (concat user-emacs-directory "workgroups"))
;;   (setq wg-load-last-workgroup nil)
;;   (setq wg-open-this-wg "blank")
;;   (setq wg-mess-with-buffer-list t)
;;   (setq wg-emacs-exit-save-behavior nil)
;;   (workgroups-mode 1)

;;   (evil-leader/set-key "ws" 'wg-switch-to-workgroup)
;;   (evil-leader/set-key "wc" 'wg-create-workgroup)
;;   (evil-leader/set-key "wb" 'wg-switch-to-buffer)
;;   (evil-leader/set-key "wR" 'wg-rename-workgroup)
;;   (evil-leader/set-key "w C-s" 'wg-save-session)
;;   (evil-leader/set-key "wo" 'wg-open-session))

(use-package projectile
  :ensure t
  :init (d-projectile-init))
;; (use-package workgroups2
;;   :ensure t
;;   :init (d-workgroups2-init))

(provide 'd-project-management)
