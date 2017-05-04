;;;
;;; 识别项目中的html/body font-size 属性， 自动应用转换rem参数
;;;

(require 's)

(defun css-rem-recover
    ()
  (interactive)
  (let ((text (thing-at-point 'sexp))
        (location (bounds-of-thing-at-point 'sexp)))
    (cond
     ((s-ends-with? "rem" text)
      (delete-region (car location) (cdr location))
      (message "using font-size: %d", 16)
      (insert (format "%dpx" (* 16 (string-to-number text)))))
     ((s-ends-with? "px" text)
      (delete-region (car location) (cdr location))
      (insert (format "%.2frem" (/ (string-to-number text) 16)))))))

(provide 'css-rem-recover)


;;; ends here
