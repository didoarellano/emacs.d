(defun d-ag-config()
  (setq ag-reuse-window t)
  (setq ag-reuse-buffers t)
  (setq ag-highlight-search t))

(use-package ag
  :ensure t
  :config (d-ag-config))

(provide 'd-ag)
