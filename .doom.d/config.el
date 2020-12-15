;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Open files in mode based on file ending
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.o\\'" . hexl-mode))

(setq-default projectile-globally-ignored-file-suffixes
				'(".o"
				".cmi"
				".cmx"
				".out"
				".DS_Store"))

(setq-default projectile-globally-ignored-directories
				'("vscode"
				"node_modules"
				".git"
				"*.dSYM"))

(setq-default +format-on-save-enabled-modes
	'(not emacs-lisp-mode  ; elisp's mechanisms are good enough
		sql-mode
		cc-mode))

;; Don't show "." or ".."
(setq-default ivy-extra-directories nil)

(setq-default +evil-want-o/O-to-continue-comments nil)
(setq-default mode-line-format nil)
;(setq-default doom-font (font-spec :family "SFMono" :size 24))
(setq-default display-line-numbers-type nil)
(setq-default confirm-kill-emacs nil)
(setq-default c-basic-offset 4)
(setq-default c-tab-always-indent t)
(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(setq-default lsp-ui-flycheck-live-reporting nil)
(setq-default lsp-ui-sideline-enable nil)
(setq-default lsp-ui-peek-enable nil)
(setq-default lsp-ui-doc-enable nil)
(setq-default company-idle-delay nil)

;; Smooth scrolling
(setq-default scroll-step 1
				scroll-conservatively  10000
				mouse-wheel-scroll-amount '(1 ((shift) . 1))
				mouse-wheel-progressive-speed nil
				mouse-wheel-follow-mouse 't)

;; Never resize echo area
(setq-default eldoc-echo-area-use-multiline-p nil)

;; persistant undo
(setq-default undo-tree-auto-save-history t)
(setq-default undo-tree-history-directory-alist '(("." . "~/.doom.d/undo")))

;; Flycheck
(setq-default flycheck-check-syntax-automatically nil)
(setq-default +flycheck-on-escape nil)

;; Clojurescript
;; (setq-default inf-clojure-generic-cmd "planck -d")
;; (add-hook 'clojure-mode-hook #'inf-clojure-minor-mode)

(defun my/add-semi-colon ()
	"Add semi-colon at end of line, escape to normal mode"
	(interactive
	 (save-excursion
		 (end-of-line)
		 (insert ";")
		 (evil-escape))))

(defun my/clean-buffer ()
	"Cleans the buffer by re-indenting, removing tabs and trailing whitespace."
	(interactive)
	(delete-trailing-whitespace)
	(save-excursion
	(replace-regexp "^\n\\{2,\\}" "\n" nil (point-min) (point-max))))

(defun my/save-buffer ()
	"clean whitespace, save all buffers and then flycheck"
	(interactive)
	(my/clean-buffer)
	(save-some-buffers 'no-prompt)
	(when flycheck-mode
	(flycheck-buffer)))

(defun my/eval-clojure ()
	(interactive)
	(my/save-buffer)
	(cider-load-buffer)
	(cider-eval-defun-at-point))

(sp-local-pair '(c-mode java-mode go-mode) "{" nil :post-handlers '(:add ("||\n[i]" "RET")))

(load! "+tabs")
(load! "+bindings")
