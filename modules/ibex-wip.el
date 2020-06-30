(let* ((proj-root "/Users/alexking/bestmile/vehicle-service/")
       (filename "/Users/alexking/bestmile/vehicle-service/service/src/it/scala/com/bestmile/vehicle/AlexIntegrationSpec.scala")
       (path-parts (s-split "/" (s-replace proj-root "" filename)))
       (module (if (string= "src" (car path-parts))
                   nil ;; root - no module prefix needed
                 (car path-parts)))
       (test-type (nth 2 path-parts)))
  (print module)

  
  (print test-type)
  (print path-parts)
;;  (print (car path-parts))

  )

(defun ibex-build-sbt-command (dirs &optional acc prev)
  (if dirs
      (let* ((part (car dirs))
             (command-string (if (and acc prev)
                                 acc
                               ;; otherwise - we're on the first element, check for submodule
                               (if (string= "src" part)
                                   ""
                                 (concat part "/")))))

        (if (string= "scala" part)
            (concat command-string prev ":testOnly")
          (ibex-build-sbt-command (cdr dirs) command-string part)))
    acc))

(ibex-build-sbt-command (list "service" "src" "it" "scala" "com"))

(ibex-build-sbt-command (list "src" "test" "scala" "com"))



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




