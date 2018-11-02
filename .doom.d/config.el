;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Fancy titlebar for MacOS
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon  nil)
(setq frame-title-format nil)

;; Black background
;; (custom-set-faces `(hl-line ((t (:background "black")))))
;; (custom-set-faces `(default ((t (:background "black")))))
;; (setq doom-font (font-spec :family "Fira Mono" :size 30))
;; (set-background-color "black")

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

;highlight-symbol; Larger font

;; go to end of line, add semi-colon, escape to normal mode
(defun my/add-semi-colon ()
  (interactive
   (progn
     (end-of-line)
     (insert ";")
     (evil-escape))))

;; switch to scratch buffer
(defun my/switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))

;; boundp check minor mode


;; save buffer and check for errors
(defun my/save-buffer ()
  (interactive)
  (save-some-buffers 'no-prompt))

;; c-mode
(setq-default c-basic-offset 4
              indent-tabs-mode t
              tab-width 4)

;; lookup
(set! :lookup 'c-mode
  :definition #'evil-goto-definition)

;; Cider
(setq cider-auto-jump-to-error nil)

;; eval lisp
(defun local/eval-clojure ()
  (my/save-buffer)
  (cider-load-buffer)
  (cider-eval-defun-at-point))

(defun local/eval-elisp ()
  (my/save-buffer)
  (+eval:region))

(defun my/eval-lisp ()
  (interactive)
  (cond
   ((equal major-mode 'clojure-mode)
	(local/eval-clojure))
   ((equal major-mode 'emacs-lisp-mode)
	(local/eval-elisp))))

;; Flycheck
(setq flycheck-check-syntax-automatically '(save))
(remove-hook 'doom-escape-hook #'+syntax-checkers|flycheck-buffer)
(remove-hook 'evil-insert-state-exit-hook #'+syntax-checkers|flycheck-buffer)

;; Whitespace
;; (add-hook 'before-save-hook #'cleanup-whitespace)

;; Open .o files in hexl-mode
(add-to-list 'auto-mode-alist '("\\.o\\'" . hexl-mode))

;; Join line
(defun join-line-down ()
  (interactive)
  (join-line -1))

;; Start emacs in full-screen mode
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; Load keybindings file
(load! "+bindings")
