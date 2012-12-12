(setq user-mail-address "me@cpb.ca")

;; Set the shell emacs uses.
(setq explicit-shell-file-name "/bin/zsh")

;; Use colum and line numbering.
(line-number-mode 1)
(column-number-mode 1)

;; Specify a color theme
;; TODO: solarized

;;
;; Erlang mode and Distel settings
;;
;;
;; This is needed for Erlang mode setup

(setq load-path (cons
                  "/usr/local/Cellar/erlang/R15B01/lib/erlang/lib/tools-2.6.7/emacs" load-path))
(setq erlang-root-dir "/usr/local/Cellar/erlang/R15B01/")
(setq exec-path (cons "/usr/local/Cellar/erlang/R15B01/" exec-path))
(require 'erlang-start)

;; Tell Emacs not to wait the usual 60 seconds for an Erlang prompt
(defvar inferior-erlang-prompt-timeout t)

;; This is needed for Distel setup
(let ((distel-dir "/usr/local/share/distel/elisp"))
(unless (member distel-dir load-path)
;; Add distel-dir to the end of load-path
(setq load-path (append load-path (list distel-dir)))))

(require 'distel)
(distel-setup)

;; Some Erlang customizations
(add-hook 'erlang-mode-hook
(lambda ()
;; when starting an Erlang shell in Emacs, default in the node name
(setq inferior-erlang-machine-options '("-sname" "emacs"))
;; add Erlang functions to an imenu menu
(imenu-add-to-menubar "imenu")))

;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
'(("\C-\M-i" erl-complete)
("\M-?" erl-complete)
("\M-." erl-find-source-under-point)
("\M-," erl-find-source-unwind)
("\M-*" erl-find-source-unwind)
)
"Additional keys to bind when in Erlang shell.")

(add-hook 'erlang-shell-mode-hook
          (lambda ()
            ;; add some Distel bindings to the Erlang shell
            (dolist (spec distel-shell-keys)
            (define-key erlang-shell-mode-map (car spec) (cadr spec)))))
