;;; ~/doom.d/+bindings.el -*- lexical-binding: t; -*-

(map!
 (:map override
	:gnvime "M-A-i" #'anki-editor-insert-note
	:gnvime "M-§" #'other-frame
	:gnvime "M-j" #'my/eval-lisp
	:gnvime "M-[" #'other-window
	:gnvime "M-s" #'my/save-buffer
	[remap evil-snipe-s] #'evil-avy-goto-word-1-below
	[remap evil-snipe-S] #'evil-avy-goto-word-1-above
	:gnvime "M-j" #'evil-avy-goto-line-below
	:gnvime "M-k" #'evil-avy-goto-line-above
	:i "<backtab>" #'company-search-candidates
	:gnvime "M-;" #'my/add-semi-colon
	:gnvime "M-k" #'kill-this-buffer
	:gnvime "M-/" #'evil-commentary-line
	:gnvime "M-i" #'evil-switch-to-windows-last-buffer
	:gnvime "M-v" #'clipboard-yank
	:gnvime "M-w" #'delete-frame
	))
