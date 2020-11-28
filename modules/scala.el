;; this shouldn't be in scala.el - perhaps editing
(use-package which-key
  :diminish which-key-mode
n  :ensure t
  :config (setq which-key-show-early-on-C-h t
                which-key-idle-delay 10000
                which-key-idle-secondary-delay 0.05)
  :init (which-key-mode))

(defface ajk/lsp-ui-sideline-code-action
  '((default :foreground "#de935f") ;; use tomorrow-night orange instead of "yellow"
    (((background light)) :foreground "DarkOrange"))
  "Face used to highlight code action text."
  :group 'lsp-ui-sideline)

(defun ajk/lsp-ui-sideline-code-action-remap ()
  (face-remap-add-relative 'lsp-ui-sideline-code-action 'ajk/lsp-ui-sideline-code-action))

(use-package lsp-mode
  :ensure t
  ;; Optional - enable lsp-mode automatically in scala files
  :hook ((scala-mode . lsp)
         (lsp-mode . lsp-lens-mode)
         (lsp-mode . lsp-enable-which-key-integration)
         (go-mode . lsp-deferred)
         (java-mode . lsp))
  :config (setq lsp-prefer-flymake nil
                read-process-output-max (* 1024 1024) ;; 1mb
;;                lsp-ui-doc-delay 2
                ;;lsp-ui-doc-delay 0.8
                )
  :init (progn (define-key lsp-mode-map (kbd "C-c C-p") lsp-command-map)
               (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
               (ajk/lsp-ui-sideline-code-action-remap)

;;               (define-key lsp-mode-map (kbd "C-c C-p") lsp-command-map)
               )
  ;; but this does: (I eval'd it inline, need to add it here properly)
;; (define-key lsp-mode-map (kbd "C-c C-p") lsp-command-map)
  )





(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(lsp-register-custom-settings
 '(("gopls.completeUnimported" t t)
   ("gopls.staticcheck" t t)))



(use-package lsp-sonarlint
  :ensure t
  :config (setq lsp-sonarlint-java-enabled t))



(use-package lsp-java
  :ensure t
  :config (setq lsp-sonarlint-java-enabled t
                lsp-java-java-path "/Library/Java/JavaVirtualMachines/jdk-11.0.7.jdk/Contents/Home/bin/java")
  :init (require 'lsp-sonarlint-java)
  :bind (("C-c C-j t" . dap-java-run-test-method)
         ("C-c C-j d" . dap-java-debug-test-method)
         ("C-c C-j f" . dap-java-run-test-class)
         ("C-c C-j c" . dap-continue)
         ("C-c C-j b" . dap-breakpoint-toggle)))

;; https://github.com/emacs-lsp/lsp-metals
;; I couldn't get lsp-metals from melpa for some reason
;; (straight-use-package
;;  '(lsp-metals :type git
;;               :host github
;;               :repo "emacs-lsp/lsp-metals"))

(use-package lsp-metals
  :ensure t
  :config (setq lsp-metals-treeview-show-when-views-received nil))

;; (use-package lsp-scala
;; ;;  :load-path "~/path/to/lsp-scala"
;;   :after scala-mode
;;   :ensure t
;;   ;;  :demand t
;;   :hook (scala-mode . lsp)
;;   :init (setq lsp-scala-server-command "/usr/local/bin/metals-emacs"))


;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$"
  :init
  (add-hook 'before-save-hook
            (lambda ()
              ;; TODO - check .scalafmt.conf exists in the project root before running this
              (lsp-format-buffer))))

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :straight (sbt-mode :type git
                      :host github
                      :repo "alexanderjamesking/emacs-sbt-mode")
  :commands sbt-start sbt-command
  :config

  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition 'minibuffer-complete-word
                             'self-insert-command
                             minibuffer-local-completion-map)
  ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
  (setq sbt:program-options '("-Dsbt.supershell=false")))

(use-package lsp-ui)

(use-package company-lsp)

;; Use the Debug Adapter Protocol for running tests and debugging
  ;; Posframe is a pop-up tool that must be manually installed for dap-mode
(use-package posframe)
(use-package dap-mode
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode))


;; (use-package ajk-scala
;;   :after (sbt-mode)
;;   :straight (ajk-scala :type git :host github :repo "alexanderjamesking/ajk-scala")
;;   :init
;;   (add-hook 'scala-mode-hook 'ajk-scala-mode)
;;   (message "ajk-scala init")

;;   :config
;;   (message "ajk-scala config"))
