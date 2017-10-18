(require 's)

(defun setup-docker-machine-env ()
  " Parse the output of docker-machine env and setup the needed env vars"
  (interactive)
  (mapcar
    (lambda (e)
     (if e
       (let ((var-value (split-string (car e) "=")))
           (setenv (s-chop-suffix "=" (car var-value)) (s-replace "\"" "" (car (cdr var-value)))))))
   (mapcar
    (lambda (e)
      (cdr (s-split " " e 't)))
    (remove-if
      (lambda (e)
       (s-starts-with? "#"e))
      (s-lines (shell-command-to-string "docker-machine env"))))))

(provide 'docker-machine-setup)
