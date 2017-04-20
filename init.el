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
(require-package 'helm-dash)
(require-package 'company)
(require-package 'dumb-jump)
(require-package 'web-mode)
(require-package 'emmet-mode)
(require-package 'moe-theme)
(require-package 'helm)
(require-package 'helm-ls-git)
(require-package 'magit)
(require-package 'js2-mode)
(require-package 'whitespace-cleanup-mode)
(require-package 'flycheck)
(require-package 'exec-path-from-shell)
(require-package 'js-auto-beautify)
(require-package 'avy)
(require-package 'ag)
(require-package 'projectile)
(require-package 'company-tern)
(require-package 'json-mode)
(require-package 'js-doc)
(require-package 'youdao-dictionary)
(require-package 'hackernews)
(require-package 'markdown-mode)
(require-package 'markdown-preview-mode)
(require-package 'web-narrow-mode)
(require-package 'python-mode)
(require-package 'company-jedi)
(require-package 'editorconfig)
(require-package 'graphviz-dot-mode)

;; global config

(require 'editorconfig)
(editorconfig-mode 1)

(require 'python-mode)
(add-hook 'python-mode-hook
          (lambda ()
            (add-to-list 'company-backends 'company-jedi)))

(require 'projectile)
(setq projectile-enable-caching t)
(setq projectile-require-project-root nil)

(require 'whitespace-cleanup-mode)
(add-hook 'before-save-hook 'whitespace-cleanup)

(require 'smartparens-config)
(smartparens-mode t)
(smartparens-strict-mode)

(require 'helm-dash)
(setq helm-dash-min-length 2)


(require 'markdown-mode)
(require 'markdown-preview-mode)
(define-key markdown-mode-map (kbd "C-c C-c") 'markdown-preview-mode)

(require 'company)
(require 'company-tern)
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "<tab>") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (setq company-dabbrev-downcase nil)
  (add-to-list 'company-backends 'company-tern))

(require 'js2-mode)
(require 'web-mode)
(require 'emmet-mode)
(require 'web-narrow-mode)
;;; web-mode

(add-hook 'web-mode-hook 'web-narrow-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'js-auto-beautify-mode)
(add-hook 'web-mode-hook 'smartparens-mode)
(add-to-list 'web-mode-content-types '("jsx" . "\\.vue\\'"))
(add-to-list 'web-mode-content-types '("json" . "\\.json"))
(add-to-list 'web-mode-content-types '("jsx" . ".\\.js[x]?\\"))

(define-key web-mode-map (kbd "C-j") 'emmet-expand-line)

(define-key lisp-mode-map (kbd "C-c C-c") 'eval-buffer)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-buffer)

(require 'json-mode)
(add-hook 'json-mode-hook 'flycheck-mode)

(require 'dumb-jump)
(dumb-jump-mode)

(require 'moe-theme)
(setq moe-theme-highlight-buffer-id t)
(moe-theme-set-color 'cyan)
(moe-dark)

(require 'helm-config)
(helm-mode 1)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

(setq hackernews-top-story-limit 50)

;;; lint tool
(require 'flycheck)
(require 'exec-path-from-shell)
(setq-default flycheck-disabled-checkers
        (append flycheck-disabled-checkers '(javascript-jshint)))
(add-hook 'web-mode-hook 'flycheck-mode)
(flycheck-add-mode 'javascript-eslint 'web-mode)
(setq-default flycheck-temp-prefix ".flycheck")
(setq-default flycheck-disable-checkers
        (append flycheck-disabled-checkers '(json-jsonlist)))
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; file association
(add-to-list 'auto-mode-alist '("\.jsx" . web-mode))
(add-to-list 'auto-mode-alist '("\.vue" . web-mode))
(add-to-list 'auto-mode-alist '("\.html" . web-mode))
(add-to-list 'auto-mode-alist '("\.css" .web-mode))
(add-to-list 'auto-mode-alist '("\.js" . web-mode))
(add-to-list 'auto-mode-alist '("\.json" . json-mode))
(add-to-list 'auto-mode-alist '("\.scss" . css-mode))

;; key binging
(global-set-key (kbd "C-c C-v q") 'helm-dash-at-point)
(global-set-key (kbd "C-c C-v a") 'helm-dash-activate-docset)
(global-set-key (kbd "C-^") 'helm-ls-git-ls)
(global-set-key (kbd "C-c g s") 'magit-status)
(global-set-key (kbd "C-c g c") 'magit-checkout)
(global-set-key (kbd "C-c g f c") 'magit-file-checkout)
(global-set-key (kbd "C-c g p u") 'magit-push-current)
(global-set-key (kbd "C-c g p l") 'magit-pull)
(global-set-key (kbd "C-c g l") 'magit-log)
(global-set-key (kbd "C-c g m") 'magit-merge)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-1") 'avy-goto-char)
(global-set-key (kbd "M-2") 'avy-goto-char-2)
(global-set-key (kbd "M-l") 'avy-goto-line)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-l")
        (lambda ()
          (interactive) (find-file (expand-file-name "~/.emacs.d/init.el"))))
(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point+)
(global-set-key (kbd "C-c C-y") 'youdao-dictionary-play-voice-at-point)
(global-set-key (kbd "C-c C-h C-n") 'hackernews)
(global-set-key (kbd "C-M-h") 'dumb-jump-go)
;;; quick jump to eshell window
(global-set-key (kbd "C-c .")
  (lambda ()
    (interactive)
    (if (get-buffer-window "*eshell*")
      (select-window (get-buffer-window "*eshell*"))
      (eshell))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq backup-by-copying t
      backup-directory-alist
      '(("." . "~/.saves"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;;; 磁盘上文件变更自动更新buffer
(global-auto-revert-mode)

;;; org-mode custom config
(setq org-clock-into-drawer t)
(setq org-agenda-include-diary t)
(setq org-src-fontify-natively t)
(setq org-confirm-babel-evaluate nil)
(setq org-image-actual-width 400)
(setq org-log-done 'time)
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t)
   (emacs-lisp . t)
   (C . t)
   (js . t)
   (calc . t)
   (octave . t)
   (python . t)))

;;; emacs custom
(show-paren-mode 1)
(setq-default indent-tabs-mode nil)

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

;;; 仅仅mac下使用复制粘贴
(if (string-equal system-type "cygwin")
    (progn
      (setq interprogram-cut-function 'paste-to-osx)
      (setq interprogram-paste-function 'copy-from-osx)
      ))
