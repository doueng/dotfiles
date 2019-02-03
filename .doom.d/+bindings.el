;;; ~/doom.d/+bindings.el -*- lexical-binding: t; -*-

(map!
 (:map override
	:gnvime "s-A-i" #'anki-editor-insert-note
	:gnvime "s-§" #'other-frame
	:gnvime "s-j" #'my/eval-lisp
	:gnvime "s-s" #'my/save-buffer
	[remap evil-snipe-s] #'evil-avy-goto-word-1-below
	[remap evil-snipe-S] #'evil-avy-goto-word-1-above
	:gnvime "s-j" #'evil-avy-goto-line-below
	:gnvime "s-k" #'evil-avy-goto-line-above
	:i "<backtab>" #'company-search-candidates
	:gnvime "s-;" #'my/add-semi-colon
	:gnvime "s-c" #'kill-this-buffer
	:gnvime "s-/" #'evil-commentary-line
	:gnvime "s-i" #'evil-switch-to-windows-last-buffer
	:gnvime "s-v" #'clipboard-yank
    :gnvime "s-x" #'counsel-M-x
    :gnvime "s-[" #'evil-prev-buffer
    :gnvime "s-]" #'evil-next-buffer
    :gnvime "s-1" (lambda! (my/switch-tab 1))
    :gnvime "s-2" (lambda! (my/switch-tab 2))
    :gnvime "s-3" (lambda! (my/switch-tab 3))
    :gnvime "s-4" (lambda! (my/switch-tab 4))
    :gnvime "s-5" (lambda! (my/switch-tab 5))
    :gnvime "s-6" (lambda! (my/switch-tab 6))
    :gnvime "s-7" (lambda! (my/switch-tab 7))
    :gnvime "s-8" (lambda! (my/switch-tab 8))
    :gnvime "s-9" (lambda! (my/switch-tab 9))
    ;; :gnvime "<ctrl>-k" nil
    :i "s-<backspace>" #'evil-delete-backward-word
	))
