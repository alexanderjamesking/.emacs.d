;;; init.el --- My emacs config

;;; Packages via straight.el

(setq straight-use-package-by-default t
      straight-repository-branch "develop"
      straight-built-in-pseudo-packages '(which-function-mode
                                          isearch
                                          dired
                                          js-mode
                                          erc-log
                                          uniquify))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)


(defvar modules-dir (expand-file-name "modules" user-emacs-directory))

(defvar enabled-modules
  '("osx"
    "defaults"
    "look-and-feel"
    "scala"
    ))

(mapc (lambda (module)
        (message (concat "Load module: " module))
        (load (concat modules-dir "/" module ".el")))
      enabled-modules)


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


(use-package elec-pair
  :config
  (electric-pair-mode +1))

;; uniquify buffer names: append path if buffer names are identical
(use-package uniquify
  :init (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :init (global-undo-tree-mode))

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

(use-package diminish
  :demand t)

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(use-package whitespace
  :diminish
  :init
  (dolist (hook '(prog-mode-hook text-mode-hook))
    (add-hook hook #'whitespace-mode))
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  :config
  (setq whitespace-style '(face trailing lines-tail)
        whitespace-global-modes '(not erc-mode)
        whitespace-line-column 120))

(use-package hl-todo
  :config
  (setq hl-todo-highlight-punctuation ":")
  (global-hl-todo-mode))

(use-package magit
  ;; :pin "melpa-stable"
  :config
  (setq magit-save-repository-buffers 'dontask)
  :bind (("C-x g" . magit-status)
         ("C-c C-g" . magit-status)))

(use-package yasnippet
  :diminish
  :config
  (use-package yasnippet-snippets)
  (yas-global-mode t)
  (setq yas-prompt-functions '(yas-dropdown-prompt yas-x-prompt)
        yas-indent-line nil)
  :diminish yas-minor-mode)

(use-package company-quickhelp)

(use-package company
  :init
  (setq company-tooltip-align-annotations t
        company-minimum-prefix-length 2
        company-require-match nil
        company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
	                        company-preview-frontend
	                        company-echo-metadata-frontend))
  :config
  (company-quickhelp-mode 1)
  (global-company-mode)
  :bind
  (:map company-active-map
        ("M-n" . nil)
        ("M-p" . nil)
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ("C-d" . company-show-doc-buffer)
        ("<tab>" . company-complete-selection)))

(use-package company-lsp
  :ensure t)


(use-package expand-region
  :ensure t
  ;; C-- er/contract-region
  :bind ("C-=" . er/expand-region))


(use-package paredit
  :ensure t
  :init
  (add-hook 'lisp-mode-hook 'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
  (add-hook 'clojure-mode-hook 'paredit-mode)
  (add-hook 'cider-repl-mode-hook 'enable-paredit-mode))


(use-package browse-kill-ring
  :ensure t
  :bind ("M-y" . browse-kill-ring))

(use-package idle-highlight-mode
  :ensure t
  :config
  (progn
    ;; TODO -check this works!
    (add-hook 'prog-mode-hook 'idle-highlight-mode)))

(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C->" . mc/mark-all-like-this)))



(use-package js-mode
  :defer t
  :mode ("\\.json$" . js-mode)
  :config
  (setq js-indent-level tab-width)
  (add-hook 'js-mode-hook 'yas-minor-mode))

(use-package rainbow-mode
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode))

(use-package css-mode
  :config
  (progn (add-hook 'css-mode-hook 'rainbow-mode)
         (setq css-indent-offset tab-width)))

(use-package markdown-mode
  :mode (("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . gfm-mode))
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package yaml-mode
  :defer t)

;; (use-package adoc-mode
;;   :mode "\\.adoc\\'")

;; (use-package rst
;;   :bind (:map rst-mode-map
;;               ("C-M-h" . backward-kill-word)))

(use-package restclient
  :mode ("\\.http$". restclient-mode))

;; (use-package gist)


(use-package flycheck-pos-tip)

(use-package flycheck
  :ensure t
  :bind (("C-c C-l" . flycheck-list-errors))
  :config
  (flycheck-pos-tip-mode)
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flyspell
  :config
  (setq ispell-program-name "aspell" ; use aspell instead of ispell
        ispell-extra-args '("--sug-mode=ultra"))
  (add-hook 'text-mode-hook #'flyspell-mode)
  (add-hook 'prog-mode-hook #'flyspell-prog-mode)
  :bind (:map flyspell-mode-map
              ("C-;" . comment-or-uncomment-region)))

;;(use-package docker)
;;(use-package dockerfile-mode)

;; disabled as it doesn't play nicely with metals which builds on save
;; (use-package super-save
;;   :ensure t
;;   :init
;;   (super-save-mode +1)
;;   ;; save when switching buffers
;;   (setq super-save-auto-save-when-idle t)
;;   ;; turn off built in auto save

;;   (setq auto-save-default nil))

(defconst my-protobuf-style
  '((c-basic-offset . 2)
    (indent-tabs-mode . nil)))

(use-package protobuf-mode
  :ensure t
  :config
  (add-hook 'protobuf-mode-hook
            (lambda () (c-add-style "my-style" my-protobuf-style t))))

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
(use-package ag
  :ensure t)



;; end
