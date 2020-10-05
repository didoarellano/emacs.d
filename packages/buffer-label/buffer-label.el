;;; ~/src/emacs.d/config/buffer-label.el -*- lexical-binding: t; -*-
;;
;; Author: Dido Arellano <didoarellano@gmail.com>
;; Version: 1.0
;; Package-Requires: ((posframe "0.8.0"))

(require 'posframe)

(defvar buffer-label--visible-p nil)

(defun buffer-label--frame-id (frame)
  (cdr (assq 'outer-window-id (frame-parameters frame))))

(cl-defun buffer-label--name-string (&optional (buffer (current-buffer)))
  ;; Use an EN QUAD (U+2000) because a regular space breaks something and the
  ;; buffer name doesn't appear.
  (concat " " (buffer-name buffer)))

(cl-defun buffer-label--save-previous-buffer
    (&optional (frame (selected-frame)) &optional (buffer (current-buffer)))
  (set-frame-parameter frame 'previous-buffer buffer))

(cl-defun buffer-label--create-posframe (&optional (frame (selected-frame)))
  (interactive)
  (let* ((id (buffer-label--frame-id frame))
         (posframe-name (concat " *buffer-label--" id)))
    ;; Force select-frame to avoid timing issues where 'selected-frame when
    ;; posframe-show executes is the previous frame. Do we need to
    ;; 'save-excursion or something? Or is it safe to assume we always want new
    ;; frames to have input focus?
    (select-frame frame)
    (let ((posframe (posframe-show
                     posframe-name
                     :parent-frame frame
                     :string (buffer-label--name-string)
                     :left-fringe 4
                     :right-fringe 0
                     :background-color "#ffffff"
                     :foreground-color "#444444"
                     :font (font-spec :size 11 :weight 'semi-bold)
                     :position (cons -1 -1))))
      (set-frame-parameter nil 'buffer-label--posframe-buffer posframe-name)
      (set-frame-parameter nil 'buffer-label--posframe posframe)
      (set-face-attribute 'fringe posframe :background "#444444")
      (set-frame-parameter posframe 'right-fringe 0)
      (setq buffer-label--visible-p t))))

(defun buffer-label--ensure-proper-fringes ()
  (interactive)
  (let ((posframe (frame-parameter (selected-frame) 'buffer-label--posframe)))
    (set-frame-parameter posframe 'left-fringe 4)
    (set-frame-parameter posframe 'right-fringe 0)
    (set-face-attribute 'fringe posframe :background "#444444")
    (redraw-frame posframe)))

(defun buffer-label--update-name ()
  ;; TODO: Update to Emacs 27.1 and use `window-buffer-change-functions',
  ;; `window-old-buffer', etc.
  ;; https://emba.gnu.org/emacs/emacs/blob/c11c9903565c3fcab98ce715c5520ae1e349861f/etc/NEWS#L1731
  (let* ((posframe-buffer (frame-parameter nil 'buffer-label--posframe-buffer))
         (--previous-buffer (frame-parameter nil 'previous-buffer))
         (--current-buffer (current-buffer))
         (buffer-name-string (buffer-label--name-string --current-buffer)))
    (if (and (not (window-minibuffer-p))
             (not (cdr (assq 'parent-frame (frame-parameters (selected-frame)))))
             (not (eq --current-buffer --previous-buffer)))
        (progn
          (buffer-label--save-previous-buffer nil --current-buffer)
          (save-excursion
            (with-current-buffer posframe-buffer
              (posframe--insert-string buffer-name-string nil)
              (posframe-refresh posframe-buffer)
              (buffer-label--ensure-proper-fringes)
              (run-at-time 0.3 nil 'buffer-label--reposition)))))))

(cl-defun buffer-label--reposition (&optional (frame (selected-frame)))
  (let ((posframe (frame-parameter frame 'buffer-label--posframe)))
    (when (frame-live-p posframe)
      (posframe--set-frame-position
       posframe
       (cons -1 -1)
       (frame-width frame)
       (frame-height frame)))))

(defun buffer-label--modified-indicator (&rest _)
  (when (and (buffer-file-name) (file-exists-p (buffer-file-name)))
    (let* ((posframe (frame-parameter (selected-frame) 'buffer-label--posframe))
           (color (if (buffer-modified-p) (face-attribute 'modus-theme-fringe-red :background) "#444444")))
      (set-face-attribute 'fringe posframe :background color)
      (redraw-frame posframe))))

(defun buffer-label--initialize ()
  (buffer-label--create-posframe)
  (add-hook 'after-make-frame-functions 'buffer-label--save-previous-buffer)
  (add-hook 'after-make-frame-functions 'buffer-label--create-posframe)
  (add-hook 'window-configuration-change-hook  'buffer-label--update-name)
  (add-hook 'window-size-change-functions 'buffer-label--reposition)
  (add-hook 'after-change-functions 'buffer-label--modified-indicator)
  (add-hook 'after-save-hook 'buffer-label--modified-indicator)
  (advice-add #'undo :after #'buffer-label--modified-indicator)
  (advice-add #'undo-tree-undo-1 :after #'buffer-label--modified-indicator)
  (advice-add #'undo-tree-redo-1 :after #'buffer-label--modified-indicator)
  (run-at-time 0.5 nil 'buffer-label--ensure-proper-fringes))

(defun buffer-label--toggle ()
  (interactive)
  (if (not buffer-label--visible-p)
      (buffer-label--create-posframe)
    (let ((posframe (frame-parameter (selected-frame) 'buffer-label--posframe-buffer)))
      (message "%s" posframe)
      (posframe-delete posframe)
      (setq buffer-label--visible-p nil))))

(provide 'buffer-label)
