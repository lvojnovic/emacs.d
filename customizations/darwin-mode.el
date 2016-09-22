(define-derived-mode darwin-mode groovy-mode
  "Darwin"
  "Major mode for editing darwin files.")

(add-to-list 'auto-mode-alist '("\\.drw\\'" . darwin-mode))

(provide 'darwin-mode)
