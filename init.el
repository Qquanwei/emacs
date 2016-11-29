
;; init elpa
(setq package-archives '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")
			 ("melpa" . "http://elpa.zilongshanren.com/melpa/")
			 ("org"   . "http://elpa.zilongshanren.com/org/")))

(defun require-package (package &optional min-version no-fresh)
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-fresh)
	(package-install package)
      (progn
	(package-refresh-contents)
	(require-package package min-version t)))))

(package-initialize)

;; package install
(require-package 'smartparens)
(require-package 'flx-ido)
(require-package 'helm-dash)
(require-package 'company)
(require-package 'company-quickhelp)
(require-package 'dumb-jump)
(require-package 'web-mode)
(require-package 'emmet-mode)

;; global config
(require 'smartparens-config)
(smartparens-strict-mode)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(require 'helm-dash)
(setq helm-dash-min-length 2)
(setq helm-dash-browser-func 'browse-url)
(setq helm-dash-common-docsets '("C++" "JavaScript"))

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(require 'company-quickhelp)
(company-quickhelp-mode 1)

(require 'web-mode)
(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode-hook)

(require 'dumb-jump)
(dumb-jump-mode)

;; web-mode
(setq web-mode-content-types-alist
      '(("json" . "\\.json")
	("jsx" . ".\\.js[x]?\\'")))

;;; react-mode
(emmet-expand-jsx-className? t)

;; file association
(add-to-list 'auto-mode-alist '("\.jsx'" . web-mode))
(add-to-list 'auto-mode-alist '("\.html" . web-mode))
(add-to-list 'auto-mode-alist '("\.css" .web-mode))
(add-to-list 'auto-mode-alist '("\.js" .web-mode))

;; key binging
(global-set-key (kbd "C-c C-v q") 'helm-dash-at-point)
(global-set-key (kbd "C-j") 'emmet-expand-line)
