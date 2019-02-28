;;; ~/.doom.d/+tabs.el -*- lexical-binding: t; -*-

(require 'seq)


(defun my/buffer-list ()
  (seq-filter
   (lambda (buffer)
     (if (string-suffix-p "*" (buffer-name buffer))
         nil
       buffer))
   (seq-take
    (buffer-list (selected-frame))
    30)))

(defun my/update-tabs ()
  (setq my/index -1)
  (setq header-line-format
        (mapconcat
         (lambda (b)
           (format "(%d %s)"
                   (setq my/index (+ my/index 1))
                   (buffer-name b)))
         (my/buffer-list)
         " ")))

(add-hook! 'buffer-list-update-hook #'my/update-tabs)

(defun my/switch-tab (n)
  (interactive)
  (switch-to-buffer (buffer-name (nth n (my/buffer-list)))))
