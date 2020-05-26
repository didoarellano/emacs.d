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

(defun --insert-semicolon-at-eol ()
  "Append a semicolon at end-of-line and maintain position of point"
  (interactive)
  (save-excursion
    (end-of-line)
    (insert ";")))
(map! :map (js2-mode-map css-mode-map php-mode-map)
      :ni "C-;" '--insert-semicolon-at-eol)

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

(set-face-attribute 'mode-line nil :height 72 :box nil :weight 'semi-bold)
(set-face-attribute 'mode-line-inactive nil :height 72 :box nil :weight 'semi-bold)
(after! display-line-numbers
  (set-face-attribute 'line-number nil :height 72 :slant 'italic :weight 'ultra-light :background "#ffffff")
  (set-face-attribute 'line-number-current-line nil :height 72 :slant 'italic :weight 'bold :background "#ffffff"))

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
  (if doom-modeline-mode
      (doom-modeline-mode 0)
    (doom-modeline-mode 1)
    ;; Some segments, sometimes the whole modeline, don't render so we force a
    ;; redisplay of the current frame
    (redraw-frame)))
(map! "<f9>" '--toggle-modeline)

(defun --toggle-line-numbers ()
  (interactive)
  (if display-line-numbers-mode
      (display-line-numbers-mode 0)
    (display-line-numbers-mode 1)))

(unmap! doom-leader-map "u")
(map! (:leader
        (:desc "Toggle UI elements" :prefix "u"
          :desc "Toggle Modeline" :nv "m" '--toggle-modeline
          :desc "Toggle Line Numbers" :nv "l" '--toggle-line-numbers)))

(window-divider-mode -1)
(defun --toggle-window-divider ()
  "Hide window divider if there is only one window in the frame for a 'seamless'
minibuffer. Show the divider if something creates a new window."
  (if (< 1 (length (window-list)))
      (window-divider-mode 1)
    (window-divider-mode -1)))
(add-hook 'window-configuration-change-hook '--toggle-window-divider)

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

(use-package! which-key-posframe
  :after which-key
  :config
  (which-key-posframe-mode))
