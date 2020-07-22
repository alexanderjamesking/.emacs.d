(use-package magit
  :diminish
  ;; :pin "melpa-stable"
  :config
  (setq magit-save-repository-buffers 'dontask)
  :bind (("C-x g" . magit-status)
         ("C-c C-g" . magit-status)))


(use-package restclient
  :mode ("\\.http$". restclient-mode))


;; (use-package gist)


;; (use-package docker)

;; https://www.emacswiki.org/emacs/MultiTerm

(use-package multi-term
  :ensure t
  :bind (("C-c C-j" . term-line-mode)
         ("C-c C-k" . term-col-mode))
  :config
  (setq multi-term-program "/bin/zsh"))

  
