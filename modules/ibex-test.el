;;; ibex-test.el --- Unit tests

;;; Commentary:

;; This file is part of Ibex.

;;; Code:

(require 'ibex)

(ert-deftest ibex:build-test-command-test ()
  (should (string= "domain/it:testOnly *MySpec;"
                   (ibex:build-test-command "domain/src/it/scala/com/foo/bar/MySpec.scala")))

  (should (string= "domain/it:testOnly *MySpec -- -z \"string from test\";"
                     (ibex:build-test-command "domain/src/it/scala/com/foo/bar/MySpec.scala" "string from test")))

  (should (string= "empty-wildcard/it:testOnly *MySpec;"
                   (ibex:build-test-command "empty-wildcard/src/it/scala/com/foo/bar/MySpec.scala" "")))

  (should (string= "test:testOnly *SomeSpec;"
                   (ibex:build-test-command "src/test/scala/foo/bar/SomeSpec.scala")))

  (should (string= "it:testOnly *Hello;"
                   (ibex:build-test-command "src/it/scala/a/b/c/d/e/Hello.scala")))

  (should (string= "my-module/it:testOnly *Hello;"
                   (ibex:build-test-command "my-module/src/it/scala/a/b/c/d/e/Hello.scala")))

  (should (string= "my-module/it:testOnly *Hello;"
                   (ibex:build-test-command "/foo/bar/my-module/src/it/scala/a/b/c/d/e/Hello.scala"))))

;;; ibex-test.el ends here
