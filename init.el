;;; init.el --- My emacs config

;;; Packages via straight.el
;; https://github.com/raxod502/straight.el
(setq straight-use-package-by-default t
      straight-repository-branch "develop"
      straight-built-in-pseudo-packages '(which-function-mode
                                          isearch
                                          dired
                                          js-mode
                                          erc-log
                                          uniquify))

;; straight bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-vc-git-default-protocol 'ssh)

;; end of straight config

(defvar modules-dir (expand-file-name "modules" user-emacs-directory))

(defvar enabled-modules
  '("defaults"
    "osx"
    "look-and-feel"
    "navigation"
    "editing"
    "text"
    "programming-utilities"
    "org"
    "elisp"
    ;; "clojure"
    ;; "go"
    ;; "rust"
    "scala"
    "ibex"
    ))

(mapc (lambda (module)
        (message (concat "Load module: " module))
        (load (concat modules-dir "/" module)))
      enabled-modules)

;; end
