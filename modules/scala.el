
(use-package which-key
  :diminish which-key-mode
  :ensure t
  :init (which-key-mode))

(use-package lsp-mode
  :ensure t
  ;; Optional - enable lsp-mode automatically in scala files
  :hook ((scala-mode . lsp)
;;         (lsp-mode . lsp-lens-mode)
         (lsp-mode . lsp-enable-which-key-integration))
  :config (setq lsp-prefer-flymake nil
                lsp-ui-doc-delay 0.8)
  :init (progn (define-key lsp-mode-map (kbd "C-c C-p") lsp-command-map)
;;               (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
               )
  ;; but this does: (I eval'd it inline, need to add it here properly)
;; (define-key lsp-mode-map (kbd "C-c C-p") lsp-command-map)
  )


;; https://github.com/emacs-lsp/lsp-metals

(use-package lsp-metals :ensure t)

;; I couldn't get lsp-metals from melpa for some reason
;; (straight-use-package
;;  '(lsp-metals :type git
;;               :host github
;;               :repo "emacs-lsp/lsp-metals"))





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
;; (use-package posframe
;;   ;; Posframe is a pop-up tool that must be manually installed for dap-mode
;;   )
;; (use-package dap-mode
;;   :hook
;;   (lsp-mode . dap-mode)
;;   (lsp-mode . dap-ui-mode))



;; (use-package ajk-scala
;;   :after (sbt-mode)
;;   :straight (ajk-scala :type git :host github :repo "alexanderjamesking/ajk-scala")
;;   :init
;;   (add-hook 'scala-mode-hook 'ajk-scala-mode)
;;   (message "ajk-scala init")

;;   :config
;;   (message "ajk-scala config"))
