(use-package company-go
  :ensure t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-go)))

(use-package go-mode
  :ensure t
  :requires (go-autocomplete go-gopath)
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (flycheck-mode)
                            (set (make-local-variable 'company-backends)
                                 '(company-go))))

  :init
    (add-hook 'before-save-hook 'gofmt-before-save)

  :bind
  (:map go-mode-map
        ("C-c C-e" . go-gopath-set-gopath)))

(use-package go-autocomplete)

(use-package go-gopath)

;;(use-package go-snippets)

(use-package go-eldoc
  :ensure t
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup))
