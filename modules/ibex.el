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


(defun ibex:build-test-command (s &optional wildcard)
  "Given string S containing the filename.."
  (save-match-data
    (and (string-match "\\([A-Za-z0-9-_\s]?+\\)/?src/\\([[:word:]]+\\)/scala/.*/\\([[:word:]]+\\).scala" s)
         (let ((service (match-string 1 s))
               (test-type (match-string 2 s))
               (file-name (match-string 3 s)))
           (concat
            (when (not (string= "" service))
              (concat service "/" ))
            test-type
            ":testOnly *"
            file-name
            (when (and wildcard (not (string= "" wildcard)))
              (concat " -- -z \"" wildcard "\""))
            ";")))))


(defun ibex:project-file-name ()
  "Relative project file-name."
  (interactive)
  (let ((file-name (buffer-file-name))
        (project-root (sbt:find-root)))
    (string-match "/.*/\\([A-Za-z0-9-_\s]?+\\)/" project-root)
    (message project-root)
    (let ((project-name (match-string 1 project-root)))
      (string-match (concat project-name "/\\(.+\\)") file-name)
      (match-string 1 file-name))))


(defun sbt-test-wildcard (&optional wildcard)
  "Run `testOnly *BUFFER-NAME -- -z WILDCARD`."
  (interactive "sWildcard: ")
  (let ((command (ibex:build-test-command (ibex:project-file-name) wildcard)))
    (message command)
    (sbt-command command)))


;; TODO - improve this to make it handle multiple lines
;; and do some checks to see that it actually looks like a test
(defun ibex:test-string ()
  "Move to the beginning of the sentence and look for a string to use as the wildcard to narrow the test."
  (interactive)
  (save-excursion
    (backward-sentence)
    (let ((s (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
      (save-match-data
        (and (string-match "\"\\([[:word:]-_\s\\]+\\)\"" s)
             (let ((s1 (match-string 1 s))
                   (s2 (match-string 2 s)))
               (or s2 s1)))))))


(defun run-single-test ()
  "Run single test (based on cursor position / highlighted region)."
  (interactive)
  (let ((wildcard (if (use-region-p)
                      ;; use whatever is in the region - it's up to the user to get this correct
                      (buffer-substring-no-properties (mark) (point))
                    ;; TODO: we should expand this to get the whole string up to but not including the quotes
                    (or (ibex:test-string) (current-word)))))
    (sbt-test-wildcard wildcard)))


(defun run-tests-in-file ()
  "Run all tests in the current file."
  (interactive)
  (sbt-test-wildcard))

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

(defun ibex-wip ()
  "Move to the beginning of the sentence and look for a string to use as the wildcard to narrow the test."
  (interactive)
  (save-excursion
    (backward-sentence)
    (let ((s (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
      (save-match-data
        (and (string-match "\"\\([[:word:]-_\s\\]+\\)\"" s)
             (let ((s1 (match-string 1 s))
                   (s2 (match-string 2 s)))
               (message (or s2 s1))))))))


(defun ibex-run-unit-tests ()
  (interactive)
  (message "running unit tests `test`")
  (sbt-command "test"))

(defun ibex-run-integration-tests ()
  (interactive)
  (message "running integration tests `it:test`")
  (sbt-command "it:test"))

;;;###autoload
(define-minor-mode ibex-mode
  "My custom Scala mode."
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c C-o") 'ensime-refactor-organize-java-imports)
            (define-key map (kbd "C-c C-t C-t") 'run-single-test)
            (define-key map (kbd "C-c C-t C-f") 'run-tests-in-file)
            (define-key map (kbd "C-c C-t C-p") 'sbt-run-previous-command)
            (define-key map (kbd "C-c C-t C-w") 'ibex-wip)
            (define-key map (kbd "C-c C-t C-u") 'ibex-run-unit-tests)
            (define-key map (kbd "C-c C-t C-i") 'ibex-run-integration-tests)
            map))

(add-hook 'scala-mode-hook 'ibex-mode)

(provide 'ibex)

;;; ibex.el ends here
