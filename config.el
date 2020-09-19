;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


(use-package buffer-label
  :load-path "~/src/emacs.d/packages/buffer-label")

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

(use-package comment-dwim-line
  :load-path "~/src/emacs.d/packages/comment-dwim-line"
  :config
  (map! "M-;" `comment-dwim-line))

(use-package insert-char-at-eol
  :load-path "~/src/emacs.d/packages/insert-char-at-eol"
  :config
  (map! :map (js2-mode-map js-mode-map css-mode-map php-mode-map)
        :ni "C-;" (lambda () (interactive) (insert-char-at-eol ";"))
        :map (js2-mode-map js-mode-map python-mode-map php-mode-map)
        :ni "C-," (lambda () (interactive) (insert-char-at-eol ","))))

(defun --open-terminal-here ()
  (interactive)
  (call-process-shell-command
   (concat "kitty --directory " (shell-quote-argument
                                 default-directory)) nil 0))
(map! "<f12>" `--open-terminal-here)

(use-package cycle-case
  :load-path "~/src/emacs.d/packages/cycle-case"
  :config
  (map! :v "~" `cycle-case))

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
      (--window-divider-colors)
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
  (let ((frames (frame-list))
        (toggle -1))
    (catch 'break
      (while frames
        (let ((frame (car frames)))
          (message "%s" (length (window-list frame)))
          (if (< 1 (length (window-list frame)))
              (throw 'break (setq toggle 1)))
          (setq frames (cdr frames)))))
    (window-divider-mode toggle)))
(add-hook 'window-configuration-change-hook '--toggle-window-divider)
(window-divider-mode -1)
(setq window-divider-default-bottom-width 4)
(setq window-divider-default-right-width 4)
(defun --window-divider-colors()
  (set-face-foreground 'window-divider "#e0e0e0")
  (set-face-foreground 'window-divider-first-pixel "#ffffff")
  (set-face-foreground 'window-divider-last-pixel "#ffffff"))

(add-hook 'magit-mode-hook 'hide-mode-line-mode)

(unmap! doom-leader-map "u")
(map! (:leader
        (:desc "Toggle UI elements" :prefix "u"
          :desc "Toggle Modeline" :nv "m" '--toggle-modeline
          :desc "Toggle Buffer Label" :nv "b" 'buffer-label--toggle
          :desc "Toggle Line Numbers" :nv "l" '--toggle-line-numbers)))

(use-package
  :load-path "~/src/emacs.d/packages/immortal-scratch")

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

(defun --revert-buffer-after-dired-rename (&rest _)
  "Revert dired buffer after renaming/moving files to clear orphaned icons"
  (revert-buffer))
(advice-add 'dired-do-rename :after '--revert-buffer-after-dired-rename)
(add-to-list 'auto-mode-alist '("\\.[Dd]ockerfile\\'" . dockerfile-mode))

(add-to-list 'auto-mode-alist '("\\.liquid\\'" . web-mode))
