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
(setq doom-font (font-spec :family "monospace" :size 14))

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
                                 default-directory))))
(map! "<f12>" `--open-terminal-here)
