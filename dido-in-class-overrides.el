(defun dido-apply-in-class-config (profile)
  (setq linum-format "%2d ")
  (when (string= "light" profile)
    (load-theme `whiteboard t)
    (custom-set-faces
     '(highlight ((t (:background "#dcdcdc"))))))
  (wg-switch-to-workgroup "in-class--jquery-101-projector")
  ;; Make sure it always open in the hello.js font-size and theme check file.
  (find-file "~/tmp/jquery-101-latest/hello.js"))


(provide 'dido-in-class-overrides)
