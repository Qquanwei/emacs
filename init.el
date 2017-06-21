;;; package -- Summary
;;; Commentary:
;;; Code:

(setq package-archives
  '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")
     ("melpa" . "http://elpa.zilongshanren.com/melpa/")
     ("org"   . "http://elpa.zilongshanren.com/org/")))

(package-initialize)

(unless
    (package-installed-p 'use-package)
  (package-install 'use-package))

;; package install
(use-package smartparens
  :ensure t
  :init
  (smartparens-global-mode)
  (show-smartparens-global-mode)
  :bind (
         ("C-M-f" . sp-forward-sexp)
         ("C-M-b" . sp-backward-sexp)
         ("C-M-n" . sp-next-sexp)
         ("C-M-p" . sp-previous-sexp)
         ("C-M-k" . sp-kill-sexp)
         ("M-[" . sp-unwrap-sexp)))
(use-package nvm
  :load-path "./lisp/nvm.el"
  :config
  (nvm-use "default"))
(use-package helm-dash
  :ensure t
  :config
  (setq helm-dash-min-length 2)
  :bind (("C-c C-v q" . helm-dash-at-point)
         ("C-c C-v a" . helm-dash-activate-docset)))
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-dabbrev-downcase nil)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "<tab>") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

(use-package dumb-jump
  :ensure t
  :init
  (setq dumb-jump-selector 'helm)
  :bind (("C-M-h" . dumb-jump-back)
         ("C-M-g" . dumb-jump-go))
  :config (dumb-jump-mode))


(use-package tide
  :ensure
  :config
  (flycheck-mode t)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode t)
  (add-hook 'before-save-hook 'tide-format-before-save))
(use-package web-mode
  :ensure t
  :mode (("\\.jsx\\'" . web-mode)
         ("\\.vue\\'" . web-mode)
         ("\\.js\\'" . web-mode)
         ("\\.css\\'" . web-mode)
         ("\\.json\\'" . web-mode)
         ("\\.html\\'" . web-mode))
  :config
  (add-hook 'web-mode-hook 'linum-mode)
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'web-narrow-mode)
  (add-hook 'web-mode-hook 'smartparens-mode)
  (add-hook 'web-mode-hook 'flycheck-mode)
  (add-hook 'web-mode-hook 'editorconfig-mode)
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name)
                                  (tide-setup)))))
  (add-hook 'web-mode-hook (lambda ()
                             (when (string= web-mode-content-type "jsx")
                               (progn
                                 (setq-local emmet-expand-jsx-className? t)))))
  (define-key web-mode-map (kbd "C-j") 'emmet-expand-line)
  (define-key web-mode-map (kbd "C-c z z") 'nodejs-repl)
  (define-key web-mode-map (kbd "C-c z r") 'nodejs-repl-send-region)
  (define-key web-mode-map (kbd "C-c z l") 'nodejs-repl-send-last-sexp)
  (add-to-list 'web-mode-content-types '("html" . "\\.vue\\'"))
  (add-to-list 'web-mode-content-types '("json" . "\\.json\\'"))
  (add-to-list 'web-mode-content-types '("jsx" . ".\\.js[x]?\\'")))
(use-package emmet-mode
  :ensure t)
(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
  :bind (("C-x C-b" . helm-buffers-list)
         ("C-c b" . helm-buffers-list)
         ("C-x C-f" . helm-find-files)
         ("M-x" . helm-M-x)))
(use-package magit
  :ensure t
  :bind (("C-c g c" . magit-checkout)
         ("C-c g f c" . magit-file-checkout)))
(use-package whitespace-cleanup-mode
  :ensure t
  :config
  (add-hook 'before-save-hook 'whitespace-cleanup))
(use-package flycheck
  :ensure t)
(use-package exec-path-from-shell
  :ensure t)
(use-package avy
  :ensure t
  :bind (("M-1" . avy-goto-char)
         ("M-2" . avy-goto-char-2)
         ("M-l" . avy-goto-line)))
(use-package ag
  :ensure t)
(use-package projectile
  :ensure t
  :config
  (projectile-mode 1)
  (projectile-register-project-type 'npm '("package.json")
            :compile "npm run build"
            :test "npm test"
            :run "npm start"
            :test-suffix ".spec")
  (setq projectile-create-missing-test-files t)
  (setq projectile-enable-caching t)
  (setq projectile-require-project-root nil))
(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))
(use-package company-tern
  :ensure t)
(use-package js-doc
  :ensure t)
(use-package youdao-dictionary
  :ensure t
  :bind (("C-c y" . youdao-dictionary-search-at-point+)
         ("C-c C-y" . youdao-dictionary-play-voice-at-point)))
(use-package hackernews
  :ensure t
  :bind ("C-c C-h C-n" . hackernews))
(use-package markdown-mode
  :ensure t
  :config
  (define-key markdown-mode-map (kbd "C-c C-c") 'markdown-preview-mode))
(use-package markdown-preview-mode
  :ensure t
  :defer t)
(use-package web-narrow-mode
  :ensure t)
(use-package python-mode
  :ensure t
  :config
  (add-hook 'python-mode-hook
            (lambda ()
              (add-to-list 'company-backends 'company-jedi))))
(use-package company-jedi
  :ensure)
(use-package editorconfig
  :ensure)
(use-package helpful
  :ensure
  :bind (("C-h f" . helpful-function)))
(use-package powerline
  :ensure
  :init
  (powerline-default-theme))
(use-package pass
  :ensure)
(use-package mode-icons
  :ensure
  :config
  (mode-icons-mode))
(use-package org-bullets
  :ensure
  :init
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))



(define-key global-map (kbd "S-<left>") 'windmove-left)
(define-key global-map (kbd "S-<right>") 'windmove-right)
(define-key global-map (kbd "S-<up>") 'windmove-up)
(define-key global-map (kbd "S-<down>") 'windmove-down)



(define-key lisp-mode-map (kbd "C-c C-c") 'eval-buffer)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-buffer)

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

;; key binging
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-x C-l")
        (lambda ()
          (interactive) (find-file (expand-file-name "~/.emacs.d/init.el"))))


(setq backup-by-copying t
      backup-directory-alist
      '(("." . "~/.saves"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;;; 磁盘上文件变更自动更新buffer
(global-auto-revert-mode)

;;; 显示时间在状态栏上
(display-time-mode)

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
(setq-default indent-tabs-mode nil)
(menu-bar-mode 0)
(tool-bar-mode 0)


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

;; compile beautify
(eval-after-load
  'compile
  '(add-hook 'compilation-filter-hook
     (lambda () (ansi-color-process-output nil))))
