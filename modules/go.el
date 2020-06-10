;; (use-package company-go
;;   :defer t
;;   :init
;;   (with-eval-after-load 'company
;;     (add-to-list 'company-backends 'company-go)))

;; (use-package go-mode
;;   :requires (go-autocomplete go-gopath)
;;   :config
;;   (add-hook 'go-mode-hook (lambda ()
;;                             (flycheck-mode)
;;                             (set (make-local-variable 'company-backends)
;;                                  '(company-go))))

;;   (add-hook 'before-save-hook 'gofmt-before-save)
;;   :bind
;;   (:map go-mode-map
;;         ("C-c C-e" . go-gopath-set-gopath)))

;; (use-package go-autocomplete)

;; (use-package go-gopath)

;; ;;(use-package go-snippets)

;; (use-package go-eldoc
;;   :defer t
;;   :init
;;   (add-hook 'go-mode-hook 'go-eldoc-setup))
