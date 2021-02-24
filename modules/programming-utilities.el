(use-package magit
  :diminish
  ;; :pin "melpa-stable"
  :config
  (setq magit-save-repository-buffers 'dontask)
  :bind (("C-x g" . magit-status)
         ("C-c C-g C-l" . magit-log-all)))


(use-package restclient
  :mode ("\\.http$". restclient-mode))

;; (use-package gist)


