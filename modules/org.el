;;; Code:

(use-package org
  :config
  ;; don't ask for confirmation when evaluating code snippets from org file
  (setq org-confirm-babel-evaluate nil)
  :init
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((dot . t))))




;; I use these keys for resizing the window (see defaults.el), the org action bound to these keys isn't enabled anyway
(add-hook 'org-mode-hook
          (lambda()
            (local-unset-key (kbd "S-C-<left>"))
            (local-unset-key (kbd "S-C-<right>"))))
