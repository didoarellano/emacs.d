;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Dido Arellano"
      user-mail-address "didoarellano@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 13))
(setq doom-variable-pitch-font (font-spec :family "sans-serif" :size 13))
(setq-default line-spacing 0.15)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'modus-operandi)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(map! "C-s" #'save-buffer)
(map! :map evil-window-map "o" 'delete-other-windows)    ; was doom/window-enlargen

(defun --duplicate-frame ()
  (interactive)
  (let (new-frame (make-frame)
                  (current-buffer (current-buffer)))
    (switch-to-buffer-other-frame new-frame)
    (switch-to-buffer current-buffer)))
(map! "C-S-n" `--duplicate-frame)

(defun --comment-dwim-line (&optional arg)
  "If no region is selected, current line is not blank, and we are not at the
end of the line, then comment or uncomment the current line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(map! "M-;" `--comment-dwim-line) ; was `comment-dwim'

(defun --insert-char-at-eol (char)
  "Append char at end-of-line and maintain position of point"
  (interactive)
  (save-excursion
    (end-of-line)
    (insert char)))
(map! :map (js2-mode-map js-mode-map css-mode-map php-mode-map)
      :ni "C-;" (lambda () (interactive) (--insert-char-at-eol ";"))
      :map (js2-mode-map js-mode-map python-mode-map php-mode-map)
      :ni "C-," (lambda () (interactive) (--insert-char-at-eol ",")))

(defun --open-terminal-here ()
  (interactive)
  (call-process-shell-command
   (concat "kitty --directory " (shell-quote-argument
                                 default-directory)) nil 0))
(map! "<f12>" `--open-terminal-here)

;; Case cycling
;; http://lists.gnu.org/archive/html/help-gnu-emacs/2008-10/msg00677.html
(defun --cycle-letter-case ()
  "Toggle the letter case of current word or text selection. Toggles from 3
    cases: UPPER CASE, lower case, Title Case, in that cyclic order."
  (interactive)
  (let (pos1 pos2 (deactivate-mark nil) (case-fold-search nil))
    (if (and transient-mark-mode mark-active)
        (setq pos1 (region-beginning)
              pos2 (region-end))
      (setq pos1 (car (bounds-of-thing-at-point 'word))
            pos2 (cdr (bounds-of-thing-at-point 'word))))

    (when (not (eq last-command this-command))
      (save-excursion
        (goto-char pos1)
        (cond
         ((looking-at "[[:lower:]][[:lower:]]") (put this-command 'state "all lower"))
         ((looking-at "[[:upper:]][[:upper:]]") (put this-command 'state "all caps"))
         ((looking-at "[[:upper:]][[:lower:]]") (put this-command 'state "init caps"))
         (t (put this-command 'state "all lower")))))

    (cond
     ((string= "all lower" (get this-command 'state))
      (upcase-initials-region pos1 pos2) (put this-command 'state "init caps"))
     ((string= "init caps" (get this-command 'state))
      (upcase-region pos1 pos2) (put this-command 'state "all caps"))
     ((string= "all caps" (get this-command 'state))
      (downcase-region pos1 pos2) (put this-command 'state "all lower")))))
(map! :v "~" `--cycle-letter-case)

(map! "C-?" 'help-command
      :i "C-h" 'backward-delete-char    ; was help-command
      :i "C-d" 'delete-forward-char     ; was evil-shift-left-line
      :i "C-k" 'kill-line               ; was evil-insert-digraph
      :i "C-y" 'yank                    ; was evil-copy-from-above
      )

(after! evil
  (setq evil-echo-state nil))

(map! "C-x C-h" 'mark-whole-buffer)     ; was help buffer for C-x

;; Suppress "Beginning of buffer" and "End of buffer" messages
;; https://superuser.com/a/1025827/182507
(defadvice previous-line (around silencer activate)
  (condition-case nil
    ad-do-it
    ((beginning-of-buffer))))
(defadvice next-line (around silencer activate)
  (condition-case nil
    ad-do-it
    ((end-of-buffer))))
;; The above works but this answer might be more future-proof and can work for
;; other messages we want to suppress.
;; https://superuser.com/a/1077571/182507

(setq frame-title-format
      '(" " (:eval (if (buffer-file-name)
                       (abbreviate-file-name (buffer-file-name))
                     "%b")))
     icon-title-format frame-title-format)

(after! display-line-numbers (--shrink-line-numbers))

(defun --shrink-line-numbers ()
  (interactive)
  (set-face-attribute 'line-number nil :height 72 :slant 'italic :weight 'ultra-light :background "#ffffff")
  (set-face-attribute 'line-number-current-line nil :height 72 :slant 'italic :weight 'bold :background "#ffffff"))

(defun --shrink-modeline ()
  (interactive)
  (set-face-attribute 'mode-line nil :height 72 :box nil :weight 'semi-bold)
  (set-face-attribute 'mode-line-inactive nil :height 72 :box nil :weight 'semi-bold))

(defun --initial-frame-setup ()
  (interactive)
  (unless (boundp '--initial-frame-initialized)
    (progn
      (--shrink-line-numbers)
      (--shrink-modeline)
      (doom-modeline-mode 0)
      (buffer-label--ensure-proper-fringes)
      (setq --initial-frame-initialized t))))

(use-package! visual-fill-column
  :config
  (setq-default visual-fill-column-width 120))

(defun --toggle-visual-wrap ()
  (interactive)
  (if (null visual-line-mode)
      (progn
        (visual-line-mode)
        (visual-fill-column-mode))
    (visual-line-mode 0)
    (visual-fill-column-mode 0)))

(map! :leader
      (:prefix "b"
        :desc "Toggle visual text wrap" "w" #'--toggle-visual-wrap))


(defun buffer-label--frame-id (frame)
  (cdr (assq 'outer-window-id (frame-parameters frame))))

(cl-defun buffer-label--name-string (&optional (buffer (current-buffer)))
  (concat " " (buffer-name buffer)))

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
      (set-frame-parameter posframe 'right-fringe 0))))

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
              (run-at-time 0.3 nil 'buffer-label--reposition)))))))

(cl-defun buffer-label--reposition (&optional (frame (selected-frame)))
  (let ((posframe (frame-parameter frame 'buffer-label--posframe)))
    (posframe--set-frame-position
     posframe
     (cons -1 -1)
     (frame-width frame)
     (frame-height frame))))

(defun buffer-label--modified-indicator (&rest _)
  (when (and (buffer-file-name) (file-exists-p (buffer-file-name)))
    (let* ((posframe (frame-parameter (selected-frame) 'buffer-label--posframe))
           (color (if (buffer-modified-p) (face-attribute 'modus-theme-fringe-red :background) "#444444")))
      (set-face-attribute 'fringe posframe :background color)
      (redraw-frame posframe))))

(add-hook 'after-make-frame-functions 'buffer-label--save-previous-buffer)
(add-hook 'after-make-frame-functions 'buffer-label--create-posframe)
(add-hook 'window-configuration-change-hook  'buffer-label--update-name)
(add-hook 'window-size-change-functions 'buffer-label--reposition)
(add-hook 'after-change-functions 'buffer-label--modified-indicator)
(add-hook 'after-save-hook 'buffer-label--modified-indicator)
(advice-add #'undo :after #'buffer-label--modified-indicator)
(advice-add #'undo-tree-undo-1 :after #'buffer-label--modified-indicator)
(advice-add #'undo-tree-redo-1 :after #'buffer-label--modified-indicator)

(defun --toggle-modeline ()
  (interactive)
  (doom-modeline-mode (if doom-modeline-mode 0 1))
  ;; Some segments, sometimes the whole modeline, don't render so we force a
  ;; redisplay of the current frame
  (when doom-modeline-mode (redraw-frame)))
(map! "<f9>" '--toggle-modeline)

(defun --toggle-line-numbers ()
  (interactive)
  (display-line-numbers-mode (if display-line-numbers-mode 0 1)))

(defun --toggle-window-divider ()
  "Hide window divider if there is only one window in the frame for a 'seamless'
minibuffer. Show the divider if something creates a new window."
  (window-divider-mode (if (< 1 (length (window-list))) 1 -1)))
(add-hook 'window-configuration-change-hook '--toggle-window-divider)
(window-divider-mode -1)

(add-hook 'magit-mode-hook 'hide-mode-line-mode)

(unmap! doom-leader-map "u")
(map! (:leader
        (:desc "Toggle UI elements" :prefix "u"
          :desc "Toggle Modeline" :nv "m" '--toggle-modeline
          :desc "Toggle Line Numbers" :nv "l" '--toggle-line-numbers)))

;; Immortal *scratch* buffer
;; Credit to whoever wrote this. I've forgotten where I found this.
;; "ctto" *barf*
(defun --kill-scratch-buffer ()
  ;; The next line is just in case someone calls this manually
  (set-buffer (get-buffer-create "*scratch*"))
  ;; Kill the current (*scratch*) buffer
  (remove-hook 'kill-buffer-query-functions '--kill-scratch-buffer)
  (kill-buffer (current-buffer))
  ;; make a brand new *scratch* buffer
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions '--kill-scratch-buffer)
  ;; Since we killed it, don't let caller do that
  nil)

(save-excursion
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions '--kill-scratch-buffer))

(add-hook! js2-mode
  (setq js2-basic-offset 2))
(add-hook! js-mode
  (setq js-indent-level 2))
(add-hook! css-mode
  (setq css-indent-offset 2))
(add-hook! web-mode
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2))


(use-package! ivy-posframe
  :config
  (setq ivy-posframe-border-width 2)
  (set-face-attribute 'ivy-posframe nil :background "#ffffff")
  (setq ivy-posframe-parameters
        '((left-fringe . 4)
          (right-fringe . 4))))

(use-package! which-key-posframe
  :after which-key
  :config
  (setq which-key-posframe-border-width 2)
  (set-face-attribute 'which-key-posframe-border nil :background (face-attribute 'ivy-posframe-border :background))
  (setq which-key-posframe-parameters
        '((left-fringe . 4)
          (right-fringe . 4)))
  (which-key-posframe-mode))
(use-package! modus-operandi-theme
  :init
  (setq modus-operandi-theme-slanted-constructs t)
  (setq modus-operandi-theme-bold-constructs t)

  ;; Set fringe foregrounds to the same color as their background so we get
  ;; solid color indicators without messing with fringe bitmaps.
  (after! (:any git-gutter-fringe flycheck)
    (set-face-foreground 'modus-theme-fringe-red (face-attribute 'modus-theme-fringe-red :background))
    (set-face-foreground 'modus-theme-fringe-green (face-attribute 'modus-theme-fringe-green :background))
    (set-face-foreground 'modus-theme-fringe-yellow (face-attribute 'modus-theme-fringe-yellow :background))
    (set-face-foreground 'modus-theme-fringe-blue (face-attribute 'modus-theme-fringe-blue :background))
    (set-face-foreground 'modus-theme-fringe-magenta (face-attribute 'modus-theme-fringe-magenta :background))
    (set-face-foreground 'modus-theme-fringe-cyan (face-attribute 'modus-theme-fringe-cyan :background))))

(after! pug-mode
  (setq pug-tab-width 2))

(use-package! lsp-mode
  :config
  ;; One, or a combination, of these things stops the crazy `lv'
  ;; minibuffer/window pollution
  (setq lsp-eldoc-enable-hover nil)
  (setq lsp-eldoc-hook nil)
  (setq lsp-signature-mode nil)
  (setq lsp-signature-auto-activate nil))

(add-hook 'dired-mode-hook #'dired-hide-details-mode)

(after! flycheck
  (set-face-underline
   'flycheck-error
   `(:style line :color ,(face-attribute 'modus-theme-fringe-red :background)))
  (set-face-underline
   'flycheck-warning
   `(:style line :color ,(face-attribute 'modus-theme-fringe-yellow :background)))
  (set-face-underline
   'flycheck-info
   `(:style line :color ,(face-attribute 'modus-theme-fringe-cyan :background))))

(remove-hook 'rjsx-mode-hook 'emmet-mode)

(add-to-list 'auto-mode-alist '("\\.[Dd]ockerfile\\'" . dockerfile-mode))
