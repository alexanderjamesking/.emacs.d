
(setq c-basic-offset 2)

(use-package clang-format
  :ensure t)

(defun clang-format-save-hook-for-this-buffer ()
  "Create a buffer local save hook."
  (add-hook 'before-save-hook
    (lambda ()
      (progn
        (when (locate-dominating-file "." ".clang-format")
          (clang-format-buffer))
        ;; Continue to save.
        nil))
    nil
    ;; Buffer local hook.
    t))


(add-hook 'c-mode-hook (lambda () (clang-format-save-hook-for-this-buffer)))
