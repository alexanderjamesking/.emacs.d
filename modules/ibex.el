;;; ibex.el --- Alex's Scala Mode

;; Copyright (c) 2020 Alexander James King

;; Homepage: https://github.com/alexanderjamesking/ibex
;; Keywords: languages
;; Package-Version:  0.1
;; Package-Requires: ((emacs "24.4"), (sbt-mode "0.2"))

;;; Commentary:
;;
;;; Code:


;; see https://scalameta.org/metals/docs/editors/emacs.html

(message "scala.el")

(require 'sbt-mode)


(defun ibex-build-test-only-command (dirs &optional acc prev)
  "Loop through DIRS to find the path, ACC and PREV are used during recursion."
  (if dirs
      (let* ((part (car dirs))
             (command-string (if (and acc prev)
                                 acc
                               (if (string= "src" part) ;; only for the first iteration
                                   ""
                                 (concat part "/")))))

        (if (string= "scala" part)
            (concat command-string prev ":testOnly")
          (ibex-build-test-only-command (cdr dirs) command-string part)))
    acc))

(defun sbt-test-wildcard (wildcard)
  "Run `testOnly *BUFFER-NAME -- -z WILDCARD`."
  (interactive "sWildcard: ")

  (let* ((file-name (s-replace (projectile-project-root) "" (buffer-file-name)))
         (dirs (s-split "/" file-name))
         (test-only (ibex-build-sbt-command dirs))
         (command (concat test-only " *" (car (split-string (buffer-name) ".scala")) " -- -z \"" wildcard "\";")))
    (message command)
    (sbt:command command)))

(defun run-single-test ()
  "Run single test (based on cursor position / highlighted region)."
  (interactive)
  (let ((wildcard (if (use-region-p)
                      ;; use whatever is in the region - it's up to the user to get this correct
                      (buffer-substring-no-properties (mark) (point))
                      ;; TODO: we should expand this to get the whole string up to but not including the quotes
                    (current-word))))
    (sbt-test-wildcard wildcard)))

(defun run-tests-in-file ()
  "Run all tests in the current file name."
  (interactive)
  (sbt-test-wildcard ""))

(defun sbt-test-buffer-file-region ()
  "Run `testOnly *BUFFER-NAME -- -z REGION`."
  (interactive)
  ;; need to find class name under cursor

  ;; TODO: read https://www.scalatest.org/user_guide/using_scalatest_with_sbt


  ;; TODO - check it's a test file
  ;; TODO - check the folder src/main/scala vs src/it/scala vs src/test/scala - and use the src/THIS/scala as the prefix to testOnly
  ;; TODO - situation where differs from buffer name

  ;; TODO - ability to run a subset of a test by passing a string
  ;;(sbt:command "test:testOnly *BookingQuerySpec -- -z ajk")

  (let* ((region-text (message (buffer-substring-no-properties (mark) (point)))))

    (sbt-test-wildcard region-text)))

;; TODO - sort imports in a region
;; the following is taken from https://github.com/ensime/ensime-emacs/blob/34eb11dac3ec9d1c554c2e55bf056ece6983add7/ensime-refactor.el#L46
;; it needs a bit of work but it'll do for a temporary solution
(defun ensime-refactor-organize-java-imports ()
  "Sort all import statements lexicographically and delete the duplicate imports."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (search-forward-regexp "^\\s-*package\\s-" nil t)
    (goto-char (point-at-eol))
    (let ((beg (point)) end)
      ;; Advance past all imports
      (while (looking-at "[\n\t ]*import\\s-\\(.+\\)\n")
        (search-forward-regexp "import" nil t)
        (goto-char (point-at-eol)))
      (setq end (point))
      (sort-lines nil beg end)
      (delete-duplicate-lines beg end nil t))))

(define-minor-mode ibex-mode
  "My custom Scala mode."
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c C-o") 'ensime-refactor-organize-java-imports)
            (define-key map (kbd "C-c C-t C-t") 'run-single-test)
            (define-key map (kbd "C-c C-t C-f") 'run-tests-in-file)
            map))

(add-hook 'scala-mode-hook 'ibex-mode)

(provide 'ibex)
;;; ajk-scala.el ends here
