(defun dido-jabber-connect()
  (interactive)
  (require 'jabber)

  (dido-jabber-accounts)
  (dido-jabber-keys)
  (dido-jabber-settings)

  (jabber-connect-all)
  (call-interactively 'jabber-display-roster))

(defun dido-jabber-accounts()
  (require 'dido-passwords "dido-passwords.gpg")
  (setq jabber-account-list
        `(("dido@semicolonstudios.com"
           (:network-server . "talk.google.com")
           (:connection-type . ssl)
           (:port . 443)
           (:password . ,dido-jabber-password)))))

(defun dido-jabber-keys()
  (evil-set-initial-state 'jabber-roster-mode 'motion)
  (evil-define-key 'motion jabber-roster-mode-map (kbd "RET")
    'jabber-roster-ret-action-at-point)
  (define-key jabber-chat-mode-map (kbd "<S-return>") 'newline))

(defun dido-jabber-settings()
  (setq
   jabber-chat-time-format "%a %l:%M %p"
   jabber-chat-local-prompt-format "%n • %t\n"
   jabber-history-enabled t
   jabber-backlog-number 20
   jabber-backlog-days 7)

  ;; Don't let alerts steal focus when we're typing in the minibuffer
  (define-jabber-alert echo "Show a message in the echo area"
    (lambda (msg)
      (unless (minibuffer-prompt)
        (message "%s" msg))))

  ;; Turns on C-c RET for following link under point
  (add-hook 'jabber-chat-mode-hook 'goto-address))

(provide 'dido-jabber)
