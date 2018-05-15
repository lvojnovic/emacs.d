(require 'java-imports)
;; java import bind to C-M-i
(with-eval-after-load 'java-mode (define-key java-mode-map (kbd "C-M-i") 'java-imports-add-import-dwim))


;; See customization below for where to put java imports
(setq java-imports-find-block-function 'java-imports-find-place-sorted-block)

(add-hook 'java-mode-hook 'java-imports-scan-file)
