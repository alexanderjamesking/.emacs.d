
;; commenting out a clojure form - this should NOT be global
(global-set-key (kbd "C-c C-/") '(lambda () (interactive) (insert "#_")))

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
