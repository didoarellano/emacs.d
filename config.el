;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(defvar --initial-frame-hook nil)
(if (daemonp)
    (add-hook 'after-make-frame-functions
              (defun --initial-frame-hook--run-hook (frame)
                (with-selected-frame frame
                  (run-hooks '--initial-frame-hook))
                (remove-hook 'after-make-frame-functions #'--initial-frame-hook--run-hook)))
  (add-hook 'emacs-startup-hook
            (defun --initial-frame-hook--run-hook ()
              (run-hooks '--initial-frame-hook))))

(use-package buffer-label
  :load-path "~/src/emacs.d/packages/buffer-label"
  :init (add-hook '--initial-frame-hook 'buffer-label--initialize))

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

(use-package duplicate-frame
  :load-path "~/src/emacs.d/packages/duplicate-frame"
  :config
  (map! "C-S-n" `duplicate-frame))

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

(use-package open-terminal-here
  :load-path "~/src/emacs.d/packages/open-terminal-here"
  :config
  (setq open-terminal-here--command "kitty --directory")
  (map! "<f12>" `open-terminal-here))

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

(use-package shush-minibuffer
  :load-path "~/src/emacs.d/packages/shush-minibuffer")

(setq frame-title-format
      '(" " (:eval (if (buffer-file-name)
                       (abbreviate-file-name (buffer-file-name))
                     "%b")))
     icon-title-format frame-title-format)

(use-package shrink-ui
  :load-path "~/src/emacs.d/packages/shrink-ui"
  :init (add-hook '--initial-frame-hook 'shrink-ui--shrink-all))

(defun --initial-frame-setup ()
  (interactive)
  (unless (boundp '--initial-frame-initialized)
    (progn
      (doom-modeline-mode 0)
      (--window-divider-colors)
      (setq --initial-frame-initialized t))))

(use-package! visual-fill-column
  :config
  (setq-default visual-fill-column-width 120))

(use-package toggle-visual-wrap
  :load-path "~/src/emacs.d/packages/toggle-visual-wrap"
  :config
  (map! :leader
        (:prefix "b"
          :desc "Toggle visual text wrap" "w" #'toggle-visual-wrap)))

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

(use-package smart-window-divider
  :load-path "~/src/emacs.d/packages/smart-window-divider")

(setq window-divider-default-bottom-width 4)
(setq window-divider-default-right-width 4)
(defun --window-divider-colors()
  (set-face-foreground 'window-divider "#e0e0e0")
  (set-face-foreground 'window-divider-first-pixel "#ffffff")
  (set-face-foreground 'window-divider-last-pixel "#ffffff"))

(add-hook 'magit-mode-hook 'hide-mode-line-mode)

(undefine-key! doom-leader-map "u")
(map! (:leader
        (:desc "Toggle UI elements" :prefix "u"
          :desc "Toggle Modeline" :nv "m" '--toggle-modeline
          :desc "Toggle Buffer Label" :nv "b" 'buffer-label--toggle
          :desc "Fix Buffer Label Fringe" :nv "B" 'buffer-label--ensure-proper-fringes
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

(defun --after-dired-rename (&rest _)
  ;; Revert dired buffer after renaming/moving files to clear orphaned icons
  (revert-buffer)
  ;; Force projectile to purge old file and find new file
  (call-interactively 'projectile-invalidate-cache))
(advice-add 'dired-do-rename :after '--after-dired-rename)

(defun --after-dired-create-directory (&rest _)
  ;; Revert dired buffer after creating a new directory to force sort and icon
  ;; to appear
  (revert-buffer))
(advice-add 'dired-create-directory :after '--after-dired-create-directory)
(add-to-list 'auto-mode-alist '("\\.[Dd]ockerfile\\'" . dockerfile-mode))

(add-to-list 'auto-mode-alist '("\\.liquid\\'" . web-mode))

(map! :leader
      ;; Use "<leader> ps" for `+ivy/project-search'; move
      ;; `projectile-save-project-buffers' to "<leader> pS"
      :desc "Save all project buffers" "pS" #'projectile-save-project-buffers
      :desc "Search project with ripgrep" "ps" #'+ivy/project-search)


(setq initial-frame-alist (append '((minibuffer . nil)) initial-frame-alist))
(setq default-frame-alist (append '((minibuffer . nil)) default-frame-alist))

(use-package mini-frame
  :hook (--initial-frame . mini-frame-mode)
  :init
  (setq mini-frame-resize-max-height 12)
  (setq mini-frame-show-parameters
        '((top . 0)
          (width . 0.6)
          (left . 0)
          (internal-border-width . 4)
          (drag-internal-border . nil)
          (background-color . "#fefefe")))
  :config
  (set-face-background 'internal-border "#eeeeee" mini-frame-frame))
