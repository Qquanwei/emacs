(use-package s)
(use-package eshell)

(defun eshell/wpwd ()
  "pwd for windows. Convert windows path to unixstylish"
  (eshell/windows-path-to-unix default-directory))

(defun eshell/windows-path-to-unix (wpath)
  "Convert winstylish path to unix"
  (s-concat "//" (s-replace ":" "/" wpath)))

(defun eshell/drun (&rest args)
  "Run docker command in current directory
drun: image command [options]
options
  -p port set docker expose port
"
  (let ((curoptions nil)
        (options (make-hash-table))
        (command "")
        (flags (format "--rm -v %s:/app -w /app" (eshell/wpwd))))
    (dolist (item args)
      (if (and
           (stringp item)
           (s-starts-with-p "-" item))
          (setq curoptions item)
        (progn
          (if curoptions
              (puthash curoptions item options)
            (setq command (s-concat command " " item)))
          (setq curoptions nil))))
    (maphash
     (lambda (key value)
       (setq flags (s-concat
                    flags " "
                    (cond
                     ((string= "-p" key) (if (and
                                              (stringp value)
                                              (s-contains-p ":" value))
                                             (s-concat "-p" " " value)
                                           (format "-p %d:%d" value value)))
                     ))))
     options)
    (insert (format "docker run %s %s" flags command))
    (eshell-send-input)
    (insert "\n")))

(provide 'eshell-functions)
