;;; init.el --- My emacs config, mostly copied from @mpenet

(setq load-prefer-newer t
      gc-cons-threshold 50000000
      auto-window-vscroll nil
      large-file-warning-threshold 100000000
      browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox"
      truncate-partial-width-windows nil
      backup-inhibited t
      make-backup-files nil
      auto-save-default nil
      auto-save-list-file-prefix nil
      save-place nil
      vc-follow-symlinks nil
      inhibit-startup-message t
      frame-inhibit-implied-resize t
      initial-scratch-message nil
      initial-major-mode 'fundamental-mode ;; skip scratch
      visible-bell nil
      hippie-expand-try-functions-list
      '(try-expand-all-abbrevs try-expand-dabbrev
                               try-expand-dabbrev-all-buffers
                               try-expand-dabbrev-from-kill
                               try-complete-file-name-partially
                               try-complete-file-name
                               try-expand-all-abbrevs
                               try-expand-list
                               try-expand-line
                               try-complete-lisp-symbol-partially
                               try-complete-lisp-symbol))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GLOBAL BINDINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(global-set-key (kbd "C-h") 'backward-delete-char)
;;(global-set-key (kbd "C-M-h") 'backward-kill-word)
;;(global-set-key (kbd "RET") 'newline-and-indent)
;;(global-set-key (kbd "<C-return>") 'newline)
;;(global-set-key "\C-x\C-o" 'other-window)
;;(global-set-key "\C-x\C-k" 'kill-buffer)
;;(global-set-key (kbd "C-x '") 'delete-other-windows)
;;(global-set-key (kbd "C-x ,") 'split-window-below)
;;(global-set-key (kbd "C-x .") 'split-window-right)
;;(global-set-key (kbd "C-x l") 'delete-window)
;;(global-set-key (kbd "C-x r") 'query-replace)
;;(global-set-key (kbd "C-x r") 'query-replace)
;;(global-set-key "\C-x\C-r" 'query-replace)
;;(global-set-key (kbd "C-.") 'find-tag)
;;(global-set-key (kbd "C-,") 'pop-tag-mark)
;;(global-set-key (kbd "C-;") 'comment-or-uncomment-region)
;;(global-set-key (kbd "M-i") 'hippie-expand)

(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

(global-set-key (kbd "M-`") 'other-frame)

(global-set-key (kbd "C-c C-/") '(lambda () (interactive) (insert "#_")))

(global-auto-revert-mode t)
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
(global-set-key (kbd "C-c C-w") 'fixup-whitespace)

(recentf-mode 0)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LOOK & FEEL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (set-frame-font "-xos4-terminus-medium-r-normal-*-14-*-*-*-*-*-*-1")




;; (add-to-list 'default-frame-alist '(font . "JetBrains Mono 13"))
;; (add-to-list 'default-frame-alist '(font . "Input Mono-13"))
;; (add-to-list 'default-frame-alist '(font . "Input Mono Narrow-13"))

;; (let ((alist '((45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>-]\\)"))))
(let ((alist '((45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>-]\\)"))))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))

;; utf8 only
(setq current-language-environment "UTF-8")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; TAB => 4*'\b'
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset tab-width)
(setq-default sgml-basic-offset tab-width)

;; ui
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq-default cursor-in-non-selected-windows nil)

(fset 'yes-or-no-p 'y-or-n-p)

;; add the current line number to the mode bar
;;(line-number-mode nil)

;; add the current column number to the mode bar
(column-number-mode t)

;; case insensitive searches
(set-default 'case-fold-search t)

;; typed text replaces the selection if the selection is active
(delete-selection-mode t)

;; make emacs use the clipboard if running in X
;; (when window-system
;;   (setq select-enable-clipboard t
;;         interprogram-paste-function 'x-cut-buffer-or-selection-value))

;;; Packages
;;; via straight el

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


(custom-set-variables
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes (quote ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default))))

(use-package color-theme-sanityinc-tomorrow
  :config (progn
            (color-theme-sanityinc-tomorrow-night)))

(use-package better-defaults)

(setq default-directory "~/")

(use-package flx-ido
  :init (flx-ido-mode 1)
  :config (setq ido-use-faces nil))

;; (use-package snazzy-theme
;;   :ensure t
;;   :init (load-theme 'snazzy t))

;; (use-package solarized-theme
;;   :ensure t
;;   :init (load-theme 'solarized-dark t)
;; ;;  :config (setq solarized-high-contrast-mode-line t)
;;   )

;; (use-package zenburn-theme
;;   :ensure t)


;;(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono 15"))


;; (add-to-list 'default-frame-alist '(font . "JetBrains Mono 13"))
;; (add-to-list 'default-frame-alist '(font . "Input Mono-13"))
;; (add-to-list 'default-frame-alist '(font . "Input Mono Narrow-13"))

(set-face-attribute 'default nil :height 145)

;;(set-frame-font "JetBrains Mono" nil t)
(set-frame-font "Fira Code Retina" nil t)

(setq ring-bell-function 'ignore)
;; (use-package paren
;;   :config
;;   (show-paren-mode +1))

;; (use-package elec-pair
;;   :config
;;   (electric-pair-mode +1))

;; uniquify buffer names: append path if buffer names are identical
(use-package uniquify
  :init (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

;; (use-package display-line-numbers
;;   :if (version<= "26" emacs-version)
;;   :hook ((prog-mode conf-mode) . display-line-numbers-mode)
;;   :custom (display-line-numbers-width 3))

(use-package which-function-mode
  :defer t
  :hook ((prog-mode . which-function-mode)))

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :init (global-undo-tree-mode))

;; (use-package winner
;;   :init
;;   (setq winner-dont-bind-my-keys t)
;;   (winner-mode)
;;   :bind (("C-x C-u" . winner-undo)
;;          ("C-x u" . winner-undo)
;;          ("C-x C-j" . winner-redo)
;;          ("C-x j" . winner-redo)))

(use-package isearch
  :config
  (setq isearch-lazy-count t
        lazy-count-prefix-format "(%s/%s) "
        lazy-count-suffix-format nil
        isearch-allow-scroll 'unlimited))

(use-package avy
  :ensure t
  :bind
  (("M-g M-g" . avy-goto-line)
   ("C-c SPC" . avy-goto-char)
   ("C-." . avy-goto-char-2)))

;; (use-package ivy
;;   :bind (("C-c C-r" . ivy-resume)
;;          ("C-c b" . ivy-switch-buffer)
;;          ("C-j" . ivy-immediate-done))
;;   :init
;;   (ivy-mode 1)
;;   :config
;;   (setq-default ;; ivy-use-virtual-buffers t
;;    enable-recursive-minibuffers t
;;    ivy-use-selectable-prompt t
;;    ivy-virtual-abbreviate 'fullpath
;;    ivy-count-format "(%d/%d) "
;;    ivy-magic-tilde nil
;;    ivy-dynamic-exhibit-delay-ms 150
;;    ivy-re-builders-alist '((swiper . regexp-quote)
;;                            (counsel-M-x . ivy--regex-fuzzy)
;;                            (counsel-git . ivy--regex-fuzzy)
;;                            (t . ivy--regex-plus))))

;; (use-package swiper
;;   :bind (("\C-t" . swiper-isearch)))

;; (use-package counsel
;;   :bind (("M-x" . counsel-M-x)
;;          ("C-x C-m" . counsel-M-x)
;;          ("C-x m" . counsel-M-x)
;;          ("C-x C-g" . counsel-rg)
;;          ("C-x f" . counsel-git)
;;          ("C-x C-f" . counsel-find-file))
;;   :config
;;   (setq ivy-extra-directories nil))


(use-package smex
  :ensure t
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ("C-c C-c M-x" . execute-extended-command)))

;; (use-package smex
;;   :ensure t
;;   :bind (("M-x" . smex)
;;          ("M-X" . smex-major-mode-commands)
;;          ("C-c C-c M-x" . execute-extended-command)))

(use-package diminish
  :demand t)

(use-package whitespace
  :diminish
  :init
  (dolist (hook '(prog-mode-hook text-mode-hook))
    (add-hook hook #'whitespace-mode))
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  :config
  (setq whitespace-style '(face trailing lines-tail)
        whitespace-global-modes '(not erc-mode)
        whitespace-line-column 80))

(use-package hl-todo
  :config
  (setq hl-todo-highlight-punctuation ":")
  (global-hl-todo-mode))

(use-package dired
  :config
  ;; dired - reuse current buffer by pressing 'a'
  (put 'dired-find-alternate-file 'disabled nil)

  ;; always delete and copy recursively
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)

  ;; if there is a dired buffer displayed in the next window, use its
  ;; current subdir, instead of the current subdir of this dired buffer
  (setq dired-dwim-target t)

  ;; enable some really cool extensions like C-x C-j(dired-jump)
  (require 'dired-x))

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

;; (use-package yasnippet
;;   :ensure t)

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
  :bind ("C-=" . er/expand-region))

;; (use-package expand-region
;;   :bind (("C-o" . er/expand-region)
;;          ("C-M-o" . er/contract-region)))

(use-package paredit
  :ensure t
  :init
  (add-hook 'lisp-mode-hook 'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
  (add-hook 'clojure-mode-hook 'paredit-mode)
  (add-hook 'cider-repl-mode-hook 'enable-paredit-mode))


;; (use-package paredit
;;   :init
;;   (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
;;   (add-hook 'lisp-interaction-mode-hook #'paredit-mode)
;;   (add-hook 'clojure-mode-hook #'paredit-mode)
;;   (add-hook 'cider-mode-hook #'paredit-mode)
;;   (add-hook 'cider-repl-mode-hook #'paredit-mode)
;;   (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
;;   :config
;;   (defun my-paredit-delete ()
;;     "If a region is active check if it is balanced and delete it otherwise
;;         fallback to regular paredit behavior"
;;     (interactive)
;;     (if mark-active
;;         (paredit-delete-region (region-beginning) (region-end))
;;       (paredit-backward-delete)))
;;   (define-key paredit-mode-map (kbd "C-j") nil)
;;   :bind (:map paredit-mode-map
;;               ("C-M-h" . paredit-backward-kill-word)
;;               ("C-h" . my-paredit-delete)
;;               ("<delete>" . my-paredit-delete)
;;               ("DEL" . my-paredit-delete)))

;; (use-package flycheck-clj-kondo)

;; (use-package clojure-mode
;;   :config
;;   (require 'flycheck-clj-kondo)
;;   (add-hook 'clojure-mode-hook #'paredit-mode))

(use-package clojure-mode
  :ensure t
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.cljc\\'" . clojure-mode)
         ("\\.edn\\'" . clojure-mode)
         ("\\.dtm\\'" . clojure-mode))
  :init
  (add-hook 'clojure-mode-hook #'eldoc-mode)
  :config
  (define-clojure-indent
    (render 1)
    (render-state 1)
    (init-state 1)
    (will-mount 1)
    (given 1)
    (fact 1)
    (facts 1)
    (let-flow 1)
    (with-gen 0)
    (such-that 1)
    (handle-errors 1)
    (with-gen 0)
    (fmap 0)
    (d/chain 0))
;;  (setq cider-default-cljs-repl 'figwheel)
;;  (setq cider-jack-in-lein-plugins '(("cider/cider-nrepl" "0.22.0-beta9")) )
  )

(use-package browse-kill-ring
  :ensure t
  :bind ("M-y" . browse-kill-ring))

(use-package idle-highlight-mode
  :ensure t
  :config
  (progn
    (add-hook 'clojure-mode-hook 'idle-highlight-mode)
    (add-hook 'emacs-lisp-mode 'idle-highlight-mode)))

(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C->" . mc/mark-all-like-this)))

(use-package cider
  :config
  (setq nrepl-log-messages t
        cider-prompt-for-symbol nil
        cider-repl-history-file "~/.emacs.d/cider-history"
        cider-repl-display-help-banner nil)
  (add-hook 'cider-repl-mode-hook #'paredit-mode)
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  (bind-keys :map cider-repl-mode-map
             ("C-c M-o" . cider-repl-clear-buffer)))

(use-package company-go
  :defer t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-go)))

(use-package go-mode
  :requires (go-autocomplete go-gopath)
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (flycheck-mode)
                            (set (make-local-variable 'company-backends)
                                 '(company-go))))

  (add-hook 'before-save-hook 'gofmt-before-save)
  :bind
  (:map go-mode-map
        ("C-c C-e" . go-gopath-set-gopath)))

(use-package go-autocomplete)

(use-package go-gopath)

;;(use-package go-snippets)

(use-package go-eldoc
  :defer t
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package flycheck-rust)

(use-package rust-mode
  :defer t
  :config
  (setq rust-format-on-save t)
  :init
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'rust-mode-hook #'flycheck-rust-setup)
  (add-hook 'racer-mode-hook #'eldoc-mode))


(use-package racer
  :defer t)


(use-package scala-mode
  :ensure t
  :mode "\\.s\\(cala\\|bt\\)$")

(use-package sbt-mode
  :ensure t
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false")))

(use-package lsp-mode
  ;; Optional - enable lsp-mode automatically in scala files
  :hook (scala-mode . lsp)
  :ensure t
  :config (setq lsp-prefer-flymake nil))

(use-package lsp-ui)

(use-package js-mode
  :defer t
  :mode ("\\.json$" . js-mode)
  :config
  (setq js-indent-level tab-width)
  (add-hook 'js-mode-hook 'yas-minor-mode))

;;(use-package fennel-mode)

;; (use-package nginx-mode)

;; (use-package doom-modeline
;;   :config
;;   (setq doom-modeline-irc-buffers t
;;         doom-modeline-irc t
;;         doom-modeline-buffer-encoding nil)
;;   :hook (after-init . doom-modeline-mode))

(use-package rainbow-mode
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode))

(use-package css-mode
  :config
  (progn (add-hook 'css-mode-hook 'rainbow-mode)
         (setq css-indent-offset tab-width)))

;; (use-package zencoding-mode
;;   :config
;;   (setq zencoding-preview-default nil)
;;   (add-hook 'sgml-mode-hook 'zencoding-mode))

;; (use-package org
;;   :defer t
;;   :config
;;   (setq org-log-done 'time)
;;   (add-hook 'org-mode-hook
;;             (lambda ()
;;               (make-variable-buffer-local 'yas-trigger-key)
;;               (setq yas-trigger-key [tab])
;;               (add-to-list 'org-tab-first-hook
;;                            (lambda ()
;;                              (let ((yas-fallback-behavior 'return-nil))
;;                                (yas-expand))))
;;               (define-key yas-keymap [tab] 'yas-next-field))))

;; (use-package htmlize
;;   :config (setq org-export-htmlize-output-type 'css))

(use-package markdown-mode
  :mode (("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . gfm-mode))
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package yaml-mode
  :defer t)

;; (use-package adoc-mode
;;   :mode "\\.adoc\\'")

(use-package rst
  :bind (:map rst-mode-map
              ("C-M-h" . backward-kill-word)))

;; (use-package restclient
;;   :mode ("\\.http$". restclient-mode))

;; (use-package gist)

(use-package flycheck-pos-tip)

(use-package flycheck
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

(use-package docker)
(use-package dockerfile-mode)

;; (use-package super-save
;;   :ensure t
;;   :init
;;   (super-save-mode +1)
;;   ;; save when switching buffers
;;   (setq super-save-auto-save-when-idle t)
;;   ;; turn off built in auto save

;;   (setq auto-save-default nil))

(use-package pt
  :ensure t
  :defer t)

;; (use-package bm
;;   :ensure t
;;   :defer t
;;   :config
;;   (bind-key [f7] 'bm-toggle)
;;   (bind-key [f8] 'bm-previous)
;;   (bind-key [f9] 'bm-next))

(use-package projectile
  :config
  (progn)
  (projectile-global-mode)
  (setq projectile-mode-line '(:eval (format " Proj[%s]" (projectile-project-name))))
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))


(setq projectile-enable-caching t)
(setq projectile-indexing-method 'native)

(use-package ag)

;; OS X stuff
(when (eq system-type 'darwin)

  (use-package exec-path-from-shell
    :config
    (exec-path-from-shell-initialize))


  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil)

  (setq browse-url-generic-program
        "/Applications/Firefox.app/Contents/MacOS/firefox"))
;; end OS X

;; config changes made through the customize UI will be stored here
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load custom-file))

(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)

;; end
