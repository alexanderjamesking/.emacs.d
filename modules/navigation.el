
;; Fuzzy matching for Emacs ... a la Sublime Text.
(use-package flx-ido
  :init (flx-ido-mode 1)
  :config (setq ido-use-faces nil))

;; (use-package find-file-in-project
;;   :ensure t
;;   :bind ("C-c C-f" . find-file-in-project)
;;   :init
;;   (with-eval-after-load 'find-file-in-project
;;     (add-to-list 'ffip-prune-patterns "*/target")
;;     (add-to-list 'ffip-prune-patterns "*/.bloop")
;;     (add-to-list 'ffip-prune-patterns "*/.metals")))

(use-package avy
  :ensure t
  :bind
  (("M-g M-g" . avy-goto-line)
   ("C-c SPC" . avy-goto-char)
   ("C-." . avy-goto-char-2)))

(use-package smex
  :ensure t
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ("C-c C-c M-x" . execute-extended-command)))

;; search e.g. projectile-pt
(use-package pt
  :ensure t
  :defer t)


(use-package projectile
  :config
  (progn
    (projectile-global-mode)
    (setq projectile-mode-line '(:eval (format " Proj[%s]" (projectile-project-name))))
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
    (setq projectile-enable-caching t)
    ;;    (setq projectile-indexing-method 'native)
    (setq projectile-indexing-method 'alien)

    (add-to-list 'projectile-globally-ignored-directories ".bloop")
    (add-to-list 'projectile-globally-ignored-directories "target")
    (add-to-list 'projectile-globally-ignored-directories ".metals")))


;;https://github.com/Wilfred/ag.el
;; search projectile-ag
(use-package ag
  :ensure t)


(use-package fzf
  :ensure t
  :bind ("C-c C-f" . fzf-projectile))


;; bookmarks
(use-package bm
  :ensure t
  :bind (("C-c C-b C-m" . bm-toggle)
         ("C-c C-b C-p" . bm-previous)
         ("C-c C-b C-n" . bm-next)))

;;

