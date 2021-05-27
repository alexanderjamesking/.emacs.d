;; OS X stuff
(when (eq system-type 'darwin)

  ;; (use-package exec-path-from-shell
  ;;   :ensure t
  ;;   :config
  ;;   (setq exec-path-from-shell-check-startup-files nil)
  ;;   (exec-path-from-shell-copy-env "PATH")
  ;;   (exec-path-from-shell-initialize))

;;  (add-to-list 'exec-path "/usr/local/bin" t)

  ;; commented out since switching keyboards - use alt, instead of cmd
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil)

  (setq browse-url-generic-program
        "/Applications/Firefox.app/Contents/MacOS/firefox"))


  ;; unset ns-popup-font-panel as I hit this occasionally by accident
  ;; due to multiple layers on the keyboard
  (global-unset-key (kbd "s-t"))




;; end OS X



(when (eq system-type 'gnu/linux)

  ;; todo linux settings

  )
