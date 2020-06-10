;; OS X stuff
(when (eq system-type 'darwin)

  (use-package exec-path-from-shell
    :ensure t
    :config
    (setq exec-path-from-shell-check-startup-files nil)
    ;;(exec-path-from-shell-copy-env "PATH")
    (exec-path-from-shell-initialize)
    )


;;  (add-to-list 'exec-path "/usr/local/bin" t)

  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil)

  (setq browse-url-generic-program
        "/Applications/Firefox.app/Contents/MacOS/firefox"))
;; end OS X
