(defun d-common-css-settings (mode mode-map)
  (setq-local company-backends '((company-css company-dabbrev-code) company-files)))

(defun d-css-mode-hook ()
  (setq mode-name "css")
  (setq css-indent-offset 2)
  (setq css-fontify-colors nil)
  (d-common-css-settings 'css-mode css-mode-map))
(add-hook 'css-mode-hook 'd-css-mode-hook)

(defun d-scss-mode-hook ()
  (setq mode-name "scss")
  (setq comment-start "// "
        comment-end "")
  (add-to-list 'rainbow-html-colors-major-mode-list 'scss-mode)
  (d-common-css-settings 'scss-mode scss-mode-map))

(defun d-scss-mode-init ()
  (setq scss-compile-at-save nil)
  (add-hook 'scss-mode-hook 'd-scss-mode-hook))

(use-package scss-mode
  :ensure t
  :init (d-scss-mode-init))

(provide 'd-scss-css)
