
(use-package elec-pair
  :config
  (electric-pair-mode +1))


(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :init (global-undo-tree-mode))


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


;; highlight TODO comments
(use-package hl-todo
  :config
  (setq hl-todo-highlight-punctuation ":")
  (global-hl-todo-mode))


;; TODO - I don't actually make use of this yet
(use-package yasnippet
  :diminish
  :config
  (use-package yasnippet-snippets)
  (yas-global-mode t)
  (setq yas-prompt-functions '(yas-dropdown-prompt yas-x-prompt)
        yas-indent-line 'auto)
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


;; colourise colour names in buffers
(use-package rainbow-mode
  :diminish
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode))

;; a “rainbow parentheses”-like mode which highlights parens, brackets, and braces according to their depth.
(use-package rainbow-delimiters
  :diminish
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))


;; an extension for flycheck to show errors under point in pos-tip popups
(use-package flycheck-pos-tip)

;; on the fly syntax checking
(use-package flycheck
  :ensure t
  :bind (("C-c C-l" . flycheck-list-errors))
  :config
  (flycheck-pos-tip-mode)
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; spell checker
(use-package flyspell
  :config
  (setq ispell-program-name "aspell" ; use aspell instead of ispell
        ispell-extra-args '("--sug-mode=ultra"))
  (add-hook 'text-mode-hook #'flyspell-mode)
  (add-hook 'prog-mode-hook #'flyspell-prog-mode)
  :bind (:map flyspell-mode-map
              ("C-;" . comment-or-uncomment-region)))

;; from writing gnu emacs extensions book
(defun other-window-backward (&optional n)
  "Select Nth previous window."
  ;; "p" means if there is a prefix argument, interpret it as a number,
  ;; and if there is no prefix argument, interpret that as the number 1.
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))

(global-set-key (kbd "C-x C-n") 'other-window) ;; also "C-x o"
(global-set-key (kbd "C-x C-p") 'other-window-backward)


;; to move lines up / down 
(use-package drag-stuff
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'drag-stuff-mode)
  :bind (("M-<up>" . drag-stuff-up)
         ("M-<down>" . drag-stuff-down)))


;; disabled as it doesn't play nicely with metals which builds on save
;; (use-package super-save
;;   :ensure t
;;   :init
;;   (super-save-mode +1)
;;   ;; save when switching buffers
;;   (setq super-save-auto-save-when-idle t)
;;   ;; turn off built in auto save

;;   (setq auto-save-default nil))
