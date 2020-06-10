
;; Fuzzy matching for Emacs ... a la Sublime Text.
(use-package flx-ido
  :init (flx-ido-mode 1)
  :config (setq ido-use-faces nil))

(use-package find-file-in-project
  :ensure t
  :bind ("C-c C-f" . find-file-in-project)
  :init
  (with-eval-after-load 'find-file-in-project
    (add-to-list 'ffip-prune-patterns "*/target")
    (add-to-list 'ffip-prune-patterns "*/.bloop")
    (add-to-list 'ffip-prune-patterns "*/.metals")))

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

;; TODO: get rid
(use-package neotree
  :ensure t
  :config
  (setq neo-autorefresh nil)
  (setq neo-window-fixed-size nil)
  (setq neo-smart-open t)
  (setq projectile-switch-project-action 'netotree-projectile-action)
  (bind-key [f6] 'neotree-toggle))

;; bookmarks
(use-package bm
  :ensure t
  :config
  (bind-key [f7] 'bm-toggle)
  (bind-key [f8] 'bm-previous)
  (bind-key [f9] 'bm-next))


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
    (setq projectile-indexing-method 'native)))


;;https://github.com/Wilfred/ag.el
;; search projectile-ag
(use-package ag
  :ensure t)
