;;; ~/src/emacs.d/packages/smart-window-divider/smart-window-divider.el -*- lexical-binding: t; -*-

(defun smart-window-divider ()
  "Hide window divider if there is only one window in the frame for a 'seamless'
minibuffer. Show the divider if something creates a new window."
  (let ((frames (frame-list))
        (toggle -1))
    (catch 'break
      (while frames
        (let ((frame (car frames)))
          (if (< 1 (length (window-list frame)))
              (throw 'break (setq toggle 1)))
          (setq frames (cdr frames)))))
    (window-divider-mode toggle)))
(add-hook 'window-configuration-change-hook 'smart-window-divider)
(window-divider-mode -1)

(provide 'smart-window-divider)
