;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

(require 'darwin-mode)

;;; make Groovy mode electric by default.
;;(add-hook 'groovy-mode-hook
;;          '(lambda ()
;;             (require 'groovy-electric)
;;             (groovy-electric-mode)))

(add-hook 'groovy-mode-hook 'whitespace-mode)

(defun my-groovy-offset-fixes ()
  "Fixes quirks with indentation. This is still not 100% ok, but it works more
times than not.

NOTE: in order to see syntactic information:
1. move point to an interesting location
2. M-x c-show-syntactic-information RET

The rest can be loaded into groovy-mode buffer and tested by indenting the
whole buffer:
--------------------------------------------------------------------------------

// the following code should be properly indented
def map = [
    a:1,
    b:2
]

fn(
    a:1,
    b:2
)

fn [
    a:1,
    b:2
]

fn([
    a:1,
    b:2
])

fn 'a', 'b', [
    a:1,
    b:2
]

def fn = {
    [
        a:1,
        b:2
    ]
}

def \"spock spec\"() {
    setup:
    def map = [
        a:1,
        b:2
    ]

    expect:
    map.a == 1
    map.b == 2
}

dsl {
    a = 1
    b = 2
    map = [
        a:1,
        b:2
    ]
}

// this following code currently doesn't work, but such code is used less often
fn(a:1,
b:2)

fn 'a',
'b'

fn 'a', 'b',
a:1,
b:2
"
  (setq c-recognize-colon-labels nil)
  (c-set-offset 'arglist-cont-nonempty 0))

(eval-after-load "groovy-mode"
  '(progn
     (add-hook 'groovy-mode-hook 'my-groovy-offset-fixes)))

(setenv "PATH" (concat (getenv "PATH") ":~/.napalm/programs/groovy/bin"))
(setq exec-path (append exec-path '("~/.napalm/programs/groovy/bin")))

(add-hook 'groovy-mode-hook 'whitespace-mode)

;; helper for formating `where` table in spock tests
(defun my-align-multi (start end regexp)
 "Align selection by repeating REGEXP."
 (interactive "r\nsAlign regexp: ")
 (align-regexp start end
               (concat "\\(\\s-\\)" regexp "\\(\\s-\\)")
               1 1 t))
(defun my-align-spock-table (start end)
 "Align spockframework data table."
 (interactive "r")
 (my-align-multi start end "|"))

(require 'groovy-imports)
;; whatever you want to bind it to
(with-eval-after-load 'groovy-mode (define-key groovy-mode-map (kbd "C-M-i") 'groovy-imports-add-import-dwim))

;; See customization below for where to put groovy imports
(setq groovy-imports-find-block-function 'groovy-imports-find-place-sorted-block)
