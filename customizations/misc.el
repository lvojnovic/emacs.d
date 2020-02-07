;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; No need for ~ files when editing
(setq create-lockfiles nil)

;; Go straight to scratch buffer on startup
(setq inhibit-startup-message t)

;; unset exit keys
(global-unset-key (kbd "C-x C-c"))

;; unset minimize key
(global-unset-key (kbd "C-z"))

;; key for pomidor timer
(global-set-key (kbd "<f12>") #'pomidor)

;; no ticking sounds for pomodidor timer
(setq pomidor-sound-tick nil
      pomidor-sound-tack nil)

;; adds timestamp when you mark TODO -> DONE in org mode
(setq org-log-done 'time)

(add-hook 'org-mode-hook (lambda () (linum-mode 0)))
