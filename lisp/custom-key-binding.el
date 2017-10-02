;; WRITESTAMP((2017-10-01 21:35:13))

(defun other-window-backword (&optional n)
  "Select the previous window"
  (interactive "p")
  (other-window (if n (- n) -1)))

(defvar writestamp-date-format "%Y-%m-%d"
  "date format")
(defvar writestamp-time-format "%H:%M:%S"
  "time format")
(defvar writestamp-prefix "WRITESTAMP(("
  "writestamp prefix")
(defvar writestamp-suffix "))"
  "writestamp suffix")

(defun writestamp (writestamp-date-format
                   writestamp-time-format
                   writestamp-prefix
                   writestamp-suffix)
  "Write stamp when save"
  (lambda ()
    (save-excursion
      (save-restriction
        (save-match-data
          (progn
            (widen)
            (goto-char 0)
            (let
                ((matchstr
                  (concat
                   (regexp-quote writestamp-prefix)
                   ".*"
                   (regexp-quote writestamp-suffix))))
              (while (re-search-forward matchstr nil t)
                (replace-match
                 (concat
                  writestamp-prefix
                  (format-time-string
                   (concat
                    writestamp-date-format
                    " "
                    writestamp-time-format)
                   (current-time))
                  writestamp-suffix))))))))))

(global-set-key (kbd "C-x C-n") 'other-window)
(global-set-key (kbd "C-x C-p") 'other-window-backword)

(add-hook 'write-file-hooks
                (writestamp writestamp-date-format
                            writestamp-time-format
                            writestamp-prefix
                            writestamp-suffix))

(provide 'custom-key-binding)
