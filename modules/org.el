;;; Code:

;; (use-package org
;;   :config
;;   ;; don't ask for confirmation when evaluating code snippets from org file
;;   (setq org-confirm-babel-evaluate nil)
;;   :init
;;   (org-babel-do-load-languages
;;    'org-babel-load-languages
;;    '((dot . t))))






;; I use these keys for resizing the window (see defaults.el), the org action bound to these keys isn't enabled anyway
(add-hook 'org-mode-hook
          (lambda()
            (local-unset-key (kbd "S-C-<left>"))
            (local-unset-key (kbd "S-C-<right>"))
            (local-unset-key (kbd "C-="))
            (local-unset-key (kbd "C-c C-w"))
            ))

(use-package plantuml-mode
  :ensure t)

(with-eval-after-load "org"
  (define-key org-mode-map (kbd "C-=") nil)

  (global-set-key (kbd "C-c l") 'org-store-link)

  (setq org-confirm-babel-evaluate nil)
  (setq org-plantuml-jar-path "~/.emacs.d/bin/plantuml.1.2021.7.jar")

  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (dot . t)
     (plantuml . t)
     (shell . t))))
