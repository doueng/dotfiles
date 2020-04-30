;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Open files in mode based on file ending
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.o\\'" . hexl-mode))

(setq-default projectile-globally-ignored-file-suffixes
							'(".o"
								".cmi"
								".elc"
								".cmx"
								".out"
								".DS_Store"))

(setq-default projectile-globally-ignored-directories
							'("vscode"
								"vendor"
								"go-build"
								"node_modules"
								".git"
								"*.dSYM"))

(setq-default +format-on-save-enabled-modes
							'(not emacs-lisp-mode  ; elisp's mechanisms are good enough
										sql-mode
										cc-mode))

(setq-default rainbow-delimiters-mode t)
(setq-default org-id-track-globally t)

(setq-default org-directory "~/Documents")

;; Cursor (cursor-type)
;; t               use the cursor specified for the frame
;; nil             don't display a cursor
;; box             display a filled box cursor
;; hollow          display a hollow box cursor
;; bar             display a vertical bar cursor with default width
;; (bar . WIDTH)   display a vertical bar cursor with width WIDTH
;; hbar            display a horizontal bar cursor with default height
;; (hbar . HEIGHT) display a horizontal bar cursor with height HEIGHT
;; ANYTHING ELSE   display a hollow box cursor
(setq-default evil-insert-state-cursor '(bar . 1))
(setq-default evil-normal-state-cursor '(box))

;; Magit
(setq-default magit-git-executable "/usr/local/bin/git")
(setq-default vc-handled-backends nil)
;; (setq magit-refresh-verbose nil)

;; Cider
(setq-default cider-doc-auto-select-buffer nil)
;; Don't show ". or ".."
(setq-default ivy-extra-directories nil)
(setq-default lsp-enable-semantic-highlighting nil)
(setq-default lsp-enable-symbol-highlighting nil)
(setq-default +evil-want-o/O-to-continue-comments nil)
(setq-default mode-line-format nil)
;; (setq-default doom-font (font-spec :family "SFMono" :size 24))
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

(use-package ejira
	:init
	(setq jiralib2-url              "https://jeng.uberinternal.com"
				jiralib2-auth             'token
				jiralib2-token						""

				ejira-org-directory       "~/jira"
				ejira-projects            '("MOTOK")

				ejira-priorities-alist    '(("Highest" . ?A)
																		("High"    . ?B)
																		("Medium"  . ?C)
																		("Low"     . ?D)
																		("Lowest"  . ?E))
				ejira-todo-states-alist   '(("To Do"       . 1)
																		("In Progress" . 2)
																		("Done"        . 3)))
	:config
	;; Tries to auto-set custom fields by looking into /editmeta
	;; of an issue and an epic.
	(add-hook 'jiralib2-post-login-hook #'ejira-guess-epic-sprint-fields)

	;; They can also be set manually if autoconfigure is not used.
	;; (setq ejira-sprint-field       'customfield_10001
	;;       ejira-epic-field         'customfield_10002
	;;       ejira-epic-summary-field 'customfield_10004)

	(require 'ejira-agenda)

	;; Make the issues visisble in your agenda by adding `ejira-org-directory'
	;; into your `org-agenda-files'.
	(add-to-list 'org-agenda-files ejira-org-directory)

	;; Add an agenda view to browse the issues that
	(org-add-agenda-custom-command
	 '("j" "My JIRA issues"
		 ((ejira-jql "resolution = unresolved and assignee = currentUser()"
								 ((org-agenda-overriding-header "Assigned to me")))))))
;;;; Golang support
(defun my-go-mode-hook ()
	(whitespace-mode -1) ; don't highlight hard tabs
	(add-hook 'before-save-hook 'gofmt-before-save)
	(setq
	 gofmt-command "goimports"
	 tab-width 2         ; display tabs as two-spaces
	 indent-tabs-mode 1  ; use hard tabs to indent
	 fill-column 100)    ; set a reasonable fill width
	)

(add-hook 'go-mode-hook 'my-go-mode-hook)

(load! "+tabs")
(load! "+bindings")
