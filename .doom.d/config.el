;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Fancy titlebar for MacOS
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon  nil)
(setq frame-title-format nil)

;; projectile
(setq projectile-globally-ignored-file-suffixes '(".o"
												  ".DS_Store"))
(setq projectile-globally-ignored-directories
	  '(".idea"
		"vscode"
		"nvim"
		"node_modules"
		".ensime_cache"
		".eunit"
		".git"
		".hg"
		".fslckout"
		"_FOSSIL_"
		".bzr"
		"_darcs"
		".tox"
		"*.dSYM"
		".svn"
		".stack-work"))

;; Create a new workspace when switching projects.
(setq +workspaces-on-switch-project-behavior t)

;; no auto comment on new line
;; (advice-remove 'doom*newline-indent-and-continue-comments);
(advice-remove #'newline-and-indent 'doom*newline-indent-and-continue-comments)
;; (advice-remove 'newline-and-indent #'doom*newline-and-indent)
;; (advice-remove 'evil-insert-newline-below #'+evil*insert-newline-below-and-respect-comments)

;; custom themes
(add-to-list 'custom-theme-load-path "/Users/Admin/.doom.d/themes")

;; parinfer
(setq parinfer-extensions '(defaults pretty-parens evil))

;; No scratch message
(setq initial-scratch-message nil)

;; No line numbers
(setq display-line-numbers-type nil)

;; Smooth scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

;; Eldoc
;; Never resize mode-line
(setq eldoc-echo-area-use-multiline-p nil)

;; go to end of line, add semi-colon, escape to normal mode
(defun my/add-semi-colon ()
  (interactive
   (progn
	 (end-of-line)
	 (insert ";")
	 (evil-escape))))

;; save buffer and check for errors
(defun my/save-buffer ()
  (interactive)
  (whitespace-cleanup)
  (save-some-buffers 'no-prompt)
  (when flycheck-mode
	(flycheck-buffer)))

;; persistant undo
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '(("." . "~/.doom.d/undo")))

;; c-mode
(setq-default c-basic-offset 4
			  indent-tabs-mode t
			  tab-width 4)

;; Cider
(setq cider-auto-jump-to-error nil)

;; eval lisp
(defun local/eval-clojure ()
  (my/save-buffer)
  (cider-load-buffer)
  (cider-eval-defun-at-point))

(defun local/eval-elisp ()
  (my/save-buffer)
  (+eval:region 10 10))

(defun my/eval-lisp ()
  (interactive)
  (cond
   ((equal major-mode 'clojure-mode)
	(local/eval-clojure))
   ((equal major-mode 'emacs-lisp-mode)
	(local/eval-elisp))))

;; Flycheck
(setq flycheck-check-syntax-automatically '(nil))
(remove-hook 'doom-escape-hook #'+syntax-checkers|flycheck-buffer)
(remove-hook 'evil-insert-state-exit-hook #'+syntax-checkers|flycheck-buffer)

;; Electric quote
(setq electric-quote-comment nil)

;; Whitespace
;; C-c C-o to set offset (c-set-offset)
(setq tab-width 4)
(setq indent-tabs-mode t)
(setq c-basic-offset 4)
;; (setq c-offsets-alist '(arglist-cont-nonempty . +)) ;; force indent to use tabs!!!!
;; (setq arglist-cont-nonempty 8)

;; (defvaralias 'c-basic-offset 'tab-width)

;; Open files in mode based on file ending
(add-to-list 'auto-mode-alist '("\\.zsh\\" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.o\\'" . hexl-mode))

(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
		  (lambda ()
			(make-variable-buffer-local 'yas/trigger-key)
			(setq yas/trigger-key [tab])
			(add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
			(define-key yas/keymap [tab] 'yas/next-field)))

;; Start emacs in full-screen mode
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; Load keybindings file
(load! "+bindings")
