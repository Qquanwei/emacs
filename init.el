;;; package --- Summary:
;;; Commentary:
;; Code:
(add-to-list 'load-path
	     (expand-file-name "lisp" user-emacs-directory))
;; load elpa
(require 'init-elpa)
(require 'package)

(defun require-package (package &optional min-version no-refresh)
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
	(package-install package)
      (progn
	(package-refresh-contents)
	(require-package package min-version t)))))

;; required plugin
(require-package 'web-mode)
(require-package 'auto-complete)
(require-package 'ac-js2)
(require-package 'js2-mode)
(require-package 'yasnippet)
(require-package 'google-translate)
(require-package 'highlight-symbol)
(require-package 'helm)

;; config
(require 'javascript-ide)
(require 'translate-ch-en)
(require 'highlight-config)
(require 'emacs-helm)


(setq backup-directory-alist '(("." . "~/.save")))
(put 'upcase-region 'disabled nil)
(show-paren-mode t)
(linum-mode t)
(require 'electric)
(electric-indent-mode t)
(electric-pair-mode t)
(electric-layout-mode t)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
