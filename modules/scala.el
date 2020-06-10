
(use-package lsp-mode
  :ensure t
  ;; Optional - enable lsp-mode automatically in scala files
  :hook  (scala-mode . lsp)
         (lsp-mode . lsp-lens-mode)
         :config (setq lsp-prefer-flymake nil))


;; https://github.com/emacs-lsp/lsp-metals

;;(use-package lsp-metals :ensure t)

;; I couldn't get lsp-metals from melpa for some reason
(straight-use-package
 '(lsp-metals :type git
              :host github
              :repo "emacs-lsp/lsp-metals"))





;; (use-package lsp-scala
;; ;;  :load-path "~/path/to/lsp-scala"
;;   :after scala-mode
;;   :ensure t
;;   ;;  :demand t
;;   :hook (scala-mode . lsp)
;;   :init (setq lsp-scala-server-command "/usr/local/bin/metals-emacs"))


;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$")

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
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

