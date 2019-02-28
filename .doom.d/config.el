;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; projectile
(setq projectile-globally-ignored-file-suffixes
      '(".o"
        ".cmi"
        ".cmx"
        ".out"
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

;; Don't show "." or ".."
(setq ivy-extra-directories nil)

(setq-default mode-line-format nil)
(setq doom-font (font-spec :family "SFMono" :size 24))
(setq display-line-numbers-type nil)
(setq confirm-kill-emacs nil)

;; Smooth scrolling
(setq scroll-step            1
	  scroll-conservatively  10000
      mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse 't)

;; Never resize echo area
(setq eldoc-echo-area-use-multiline-p nil)

;; persistant undo
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '(("." . "~/.doom.d/undo")))

;; Flycheck
(setq flycheck-check-syntax-automatically nil)
(remove-hook 'doom-escape-hook #'+syntax-checkers|flycheck-buffer)
(remove-hook 'evil-insert-state-exit-hook #'+syntax-checkers|flycheck-buffer)

;; Open files in mode based on file ending
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.o\\'" . hexl-mode))

(defun my/add-semi-colon ()
  "Go to end of line, add semi-colon, escape to normal mode"
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
    (replace-regexp "^\n\\{3,\\}" "\n" nil (point-min) (point-max))))

(defun my/save-buffer ()
  "clean whitespace, save all buffers and then flycheck"
  (interactive)
  (my/clean-buffer)
  (save-some-buffers 'no-prompt)
  (when flycheck-mode
    (flycheck-buffer)))

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

;; Load keybindings file
(load! "+tabs")
(load! "+bindings")
