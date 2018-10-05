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

;; switch to scratch buffer
(defun my/switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))

;; Popup switching


;; Flycheck
(setq flycheck-check-syntax-automatically '(save))
(remove-hook 'doom-escape-hook #'+syntax-checkers|flycheck-buffer)
(remove-hook 'evil-insert-state-exit-hook #'+syntax-checkers|flycheck-buffer)

;; Whitespace
(add-hook 'before-save-hook #'cleanup-whitespace)

;; Join line
(defun join-line-down ()
  (interactive)
  (join-line -1))

;; Start emacs in full-screen mode
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; Load keybindings file
(load! "+bindings")
