;;; ~/doom.d/+bindings.el -*- lexical-binding: t; -*-

(map! (:map override
		:gnvime "s-A-i" #'anki-editor-insert-note
		:gnvime "s-§" #'other-frame
		:gnvime "s-j" #'my/eval-lisp
		:gnvime "s-[" #'other-window
		:gnvime "s-s" #'my/save-buffer
		[remap evil-snipe-s] #'evil-avy-goto-word-1-below
		[remap evil-snipe-S] #'evil-avy-goto-word-1-above
		:gnvime "M-j" #'evil-avy-goto-line-below
		:gnvime "M-k" #'evil-avy-goto-line-above
		:i "<backtab>" #'company-search-candidates
		:gnvime "s-;" #'my/add-semi-colon
		:gnvime "s-k" #'kill-this-buffer
		:gnvime "s-/" #'evil-commentary-line
		:gnvime "s-i" #'evil-switch-to-windows-last-buffer
		:gnvime "s-v" #'clipboard-yank
	))
