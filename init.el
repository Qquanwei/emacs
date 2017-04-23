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

(require-package 'use-package)
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

(defun npm-install
    (pname) (interactive "sEnter package name:") (compile (format "npm install %s" pname)))
(defun npm-run-test
    () (interactive) (compile "npm run test"))
(defun npm-run-lint
    () (interactive) (compile "npm run lint"))

(use-package web-mode
  :ensure t
  :mode "\\.(jsx|json|js|vue|html|css|scss)\\'"
  :bind (("C-c n t" . npm-run-test)
         ("C-c n l" . npm-run-lint)
         ("C-c n i" . npm-run-install))
  :config
  (add-hook 'web-mode-hook 'linum-mode)
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'web-narrow-mode)
  (add-hook 'web-mode-hook 'smartparens-mode)
  (add-hook 'web-mode-hook 'flycheck-mode)
  (add-hook 'web-mode-hook 'editorconfig-mode)
  (add-hook 'web-mode-hook (lambda ()
                             (when (string= web-mode-content-type "jsx")
                               (progn
                                 (setq-local emmet-expand-jsx-className? t)))))
  (add-to-list 'web-mode-content-types '("html" . "\\.vue\\'"))
  (add-to-list 'web-mode-content-types '("json" . "\\.json\\'"))
  (add-to-list 'web-mode-content-types '("jsx" . ".\\.js[x]?\\'")))
(use-package emmet-mode
  :ensure t)
(use-package moe-theme
  :ensure t)
(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
  :bind (("C-x C-b" . helm-buffers-list)
         ("C-c b" . helm-buffers-list)
         ("C-x C-f" . helm-find-files)))
(use-package magit
  :ensure t
  :bind (("C-c g s" . magit-status)
         ("C-c g c" . magit-checkout)
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
  :bind ("C-c C-h C-n" . hacknews))
(use-package markdown-mode
  :ensure t
  :bind ("C-c C-c" . markdown-preview-mode))
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
  :ensure t)
(use-package editorconfig
  :ensure t)
(use-package powerline
  :ensure t
  :init
  (powerline-default-theme))

(define-key global-map (kbd "S-<left>") 'windmove-left)
(define-key global-map (kbd "S-<right>") 'windmove-right)
(define-key global-map (kbd "S-<up>") 'windmove-up)
(define-key global-map (kbd "S-<down>") 'windmove-down)


(with-eval-after-load 'company
  (setq company-dabbrev-downcase nil)
  (add-to-list 'company-backends 'company-tern))


(define-key web-mode-map (kbd "C-j") 'emmet-expand-line)

(define-key lisp-mode-map (kbd "C-c C-c") 'eval-buffer)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-buffer)

(require 'moe-theme)
(setq moe-theme-highlight-buffer-id t)
(moe-theme-set-color 'cyan)
(moe-dark)

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

(custom-set-faces
 '(mode-line ((t (:foreground "#00ff00" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#5f5f5f" :background "#666666" :box nil)))))
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
