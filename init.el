;;; package -- Summary
;;; Commentary:
;;; Code:
;;; -*- lexical-binding: t -*-


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(setq package-archives
      '(
	("gnu"   . "https://elpa.gnu.org/packages/")	
        ("melpa" . "https://melpa.org/packages/")
        ("melpa-cn" . "http://elpa.emacs-china.org/melpa/")
        ("org-cn"   . "http://elpa.emacs-china.org/org/")
        ("gnu-cn"   . "http://elpa.emacs-china.org/gnu/")
        ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
        ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(require 'use-package)

;;; guess-word
(use-package guess-word
  :load-path "./site-lisp/emacs-guess-word-game"
  :config
  (setq guess-word-org-file (f-expand "~/org/esl.org"))
  :commands (guess-word))

;;; org-mode
(use-package org
  :config
  (defun org-clocking-buffer (&rest _))
  (auto-save-mode)
  (org-clock-persistence-insinuate)
  (setq org-clock-history-length 23)
  (setq org-clock-in-resume t)
  (setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
  (setq org-clock-into-drawer t)
  (setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
  (setq org-clock-report-include-clocking-task t)

  (setq org-enforce-todo-checkbox-dependencies t)
  (setq org-enforce-todo-dependencies t)
  (require 'org-crypt)
  (org-crypt-use-before-save-magic)
  (setq org-tags-exclude-from-inheritance (quote ("crypt")))
  (when (and (file-exists-p "~/org")
             (file-directory-p "~/org"))
    (setq org-agenda-files '("~/org")))

  (setq org-crypt-key "liquanwei")
  (define-key org-mode-map (kbd "C-c u d") 'org-decrypt-entry)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((dot . t)
     (emacs-lisp . t)
     (C . t)
     (js . t)
     (calc . t)
     (octave . t)
     (python . t)))
  (setq org-clock-into-drawer t)
  (setq org-agenda-include-diary t)
  (setq org-src-fontify-natively t)
  (setq org-confirm-babel-evaluate nil)
  (setq org-image-actual-width 400)
  (setq org-log-done 'time)
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
  (defun skip-item-by-closed-in-two-weeks ()
    "Skip tree when out two weeks"
    (let ((closed (org-entry-get (point) "CLOSED" nil)))
      (if (and
           closed
           (< (- (float-time)
                 (org-time-string-to-seconds closed))
              (* 14 24 60 60)))
          nil
        (save-excursion (org-end-of-subtree)))))

  (setq org-agenda-custom-commands
        '(
          ("a" "Agenda for work"
           (
            (agenda "" ((org-agenda-skip-function '(org-agenda-skip-entry-if 'nottodo '("TODO" "DONE")))))
            (todo "NOTE" ((org-agenda-skip-function 'skip-item-by-closed-in-two-weeks)))
            (todo "LATER")
            (alltodo "" ((org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))))
            ))
          ("n" todo "NOTE")))

  ;; 关于org—capture的配置，灵感捕捉会存放在 work.org 目录中
  (setq org-default-notes-file (expand-file-name (concat (car org-agenda-files) "/work.org")))
  ;; 配置模板，我常用的就是一级目录的模板，直接放个一级entry为该项

  (setq org-capture-templates
        '(
          ("t" "添加一条到work.org"
           entry (file org-default-notes-file)
           "* TODO %?\n CAPTURE: %T %i \n %F"
           :jump-to-captured t
           :empty-lines 1)))

  (setq org-todo-keyword-faces
        '(("TODO" . org-warning) ("LATER" . "purple")
          ("NOTE" . (:foreground "blue" :weight bold))
          ("CANCELED" . "gray")))

  (setq org-todo-keywords
        '((sequence "TODO(t)" "|" "DONE(d)")
          (sequence "TODO" "LATER(l)" "|" "DONE")
          (sequence "|" "NOTE(n)")
          (sequence "|" "CANCELED(c)")
          ))
  :bind
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture)
  ("C-c b" . org-switchb)
  )

;;; smartparens

(use-package smartparens
  :ensure
  :init
  (use-package smartparens-config)
  (use-package smartparens-html)
  (use-package smartparens-org)
  (use-package smartparens-python)
  (smartparens-global-mode 1)
  (show-smartparens-global-mode 1)
  :bind (
         ("C-M-f" . sp-forward-sexp)
         ("C-M-b" . sp-backward-sexp)
         ("C-M-n" . sp-next-sexp)
         ("C-M-p" . sp-previous-sexp)
         ("C-M-k" . sp-kill-sexp)
         ("M-[" . sp-unwrap-sexp)))

(use-package dash
  :ensure)

;;; yasnippet
(use-package yasnippet
  :ensure
  :config
  (yas-reload-all)
  :hook (after-load . (lambda () (yas-global-mode t))))

(use-package yasnippet-snippets
  :ensure)

(use-package dockerfile-mode
  :ensure)


;;; avy
(use-package avy
  :ensure t
  :bind (("M-1" . avy-goto-char)
         ("M-l" . avy-goto-line)))

;;; projectile
(use-package projectile
  :init
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  :config
  (setq projectile-create-missing-test-files t)
  (setq projectile-enable-caching t)
  (setq projectile-require-project-root nil)
  (projectile-register-project-type
   'npm '("package.json")
   :compile "npm run build"
   :test "npm run test"
   :run "npm run start"
   :test-suffix ".spec"))

(use-package neotree
  :ensure t
  :config
  (setq neo-autorefresh nil)
  (defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (projectile-project-root))
          (file-name (buffer-file-name)))
      (neotree-toggle)
      (if project-dir
          (if (neo-global--window-exists-p)
              (progn
                (neotree-dir project-dir)
                (neotree-find file-name)))
        (message "Could not find git project root."))))
  (global-set-key [f8] 'neotree-project-dir))


(projectile-global-mode)


;;; magit
(use-package magit
  :ensure
  :init
  (use-package magit-blame)
  (setq magit-refresh-status-buffer nil)
  :bind (("C-c g c" . magit-checkout)
         ("C-c g f c" . magit-file-checkout)))

;;; js config

(use-package emmet-mode
  :ensure)

;; 默认C-j补全配置
(use-package emmet-mode
  :init
  (add-hook 'js-mode-hook 'emmet-mode)
  (add-hook 'js-mode-hook 'editorconfig-mode)
  :config
  (setq emmet-preview-default nil))

;; js,jsx,ts,tsx自动补全配置
(use-package posframe
  :ensure)

(use-package yasnippet :ensure
  :init
  (yas-global-mode 1))

(use-package lsp-bridge
  :load-path "./site-lisp/lsp-bridge"
  :hook
  (after-init . global-lsp-bridge-mode)
  :config
  (setq lsp-bridge-lang-server-extension-list
        '(
          (("js") . "javascript")
          (("ts") . "typescript")
          (("tsx") . "typescriptreact"))))

(setq acm-enable-icon nil)

;; 在写css时候还是希望能有company补全一下的
(add-hook 'less-css-mode-hook 'company-mode)
(add-hook 'css-mode 'company-mode)

;; 为了使用js2-refactor, 需要开启js2-minor-mode
(use-package js2-mode :ensure)
(use-package js2-refactor :ensure
  :config
  (js2r-add-keybindings-with-prefix "C-c C-r")
  )

;;; theme
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-code-face ((t (:inherit fixed-pitch :background "gray20" :foreground "dark orange"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 2.0))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.8)))))
;;; dashboard

(use-package dashboard
  :ensure
  :init
  (dashboard-setup-startup-hook)
  :config
  (setq dashboard-banner-logo-title "Happy Coding")
  (setq dashboard-startup-banner "~/.emacs.d/logo.png")
  (setq dashboard-items
        '((recents . 5)
          (bookmarks . 5)
          (projects . 3)
          (agenda . 5))))

(use-package diminish
  :ensure
  :init
  (diminish 'projectile-mode)
  (diminish 'company-mode)
  (diminish 'guide-key-mode)
  (diminish 'ivy-mode))

(use-package pass
  :ensure
  :config
  (setq password-store-executable "pass"))

(use-package comint
  :config
  (add-hook 'comint-mode-hook 'company-mode))

(use-package dimmer
  :ensure
  :init
  (dimmer-activate))

(use-package slime
  :ensure
  :config
  (setq inferior-lisp-program "sbcl"))

(use-package youdao-dictionary
  :bind (("C-c t y" . youdao-dictionary-search-at-point+)
         ("C-c t C-y" . youdao-dictionary-play-voice-at-point)))

(use-package mw-thesaurus
  :ensure
  :bind (("C-c t w" . mw-thesaurus--lookup-at-point)))

(use-package expand-region
  :ensure)
(global-set-key (kbd "C-=") 'er/expand-region)

(use-package which-key
  :ensure
  :init
  (which-key-mode))


;;; markdown

(use-package markdown-mode
       :ensure
       :config
       (define-key markdown-mode-map (kbd "C-c C-c") 'markdown-preview-mode))
     (use-package markdown-preview-mode
       :ensure t
       :defer t)

;;; editorconfig
(use-package editorconfig
  :ensure)

;;; helpful

(use-package helpful
  :ensure
  :bind
  (
   ("C-h f" . helpful-function)
   ("C-h g" . helpful-macro)))

;;; display

(setq-default indent-tabs-mode nil)
(tool-bar-mode 0)
(menu-bar-mode 0)

(setq frame-title-format
      (list (format "%s %%S: %%j" (system-name))
            '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

(eval-after-load
    'compile
  '(add-hook 'compilation-filter-hook
             (lambda () (ansi-color-process-output nil))))

(display-time-mode)
(when (display-graphic-p)
  (scroll-bar-mode -1))

;;; macos

(setq mac-option-key-is-meta t)
(setq mac-command-key-is-meta nil)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))
(if (string-equal system-type "cygwin")
    (progn
      (setq interprogram-cut-function 'paste-to-osx)
      (setq interprogram-paste-function 'copy-from-osx)
      ))

;;; whitespace
(use-package whitespace-cleanup-mode
  :ensure t
  :config
  (add-hook 'before-save-hook 'whitespace-cleanup))

;;; ivy

(use-package ivy
  :ensure
  :config
  (ivy-mode t)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (define-key global-map (kbd "C-x C-b") 'ivy-switch-buffer)
  (define-key global-map (kbd "C-s") 'swiper)
  (define-key global-map (kbd "C-x C-f") 'counsel-find-file)
  (define-key global-map (kbd "M-x") 'counsel-M-x))

;;; dash

(use-package counsel-dash
  :ensure
  :config
  (setq counsel-dash-browser-func 'browse-web)
  :bind (("C-c C-v a" . counsel-dash-activate-docset)
         ("C-c C-v q" . counsel-dash)))

;;; haskell-mode

(use-package haskell-mode
  :ensure
  :config
  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))

;;; emacs-lisp-mode

(add-hook 'emacs-lisp-mode-hook 'company-mode)
(define-key lisp-mode-map (kbd "C-c C-c") 'eval-buffer)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-buffer)

;;; web-mode
(use-package web-beautify
  :ensure)

(defun setup-web-mode-company-mode ()
  (setq-local
   company-backends
   '(company-files company-etags company-dabbrev company-yasnippet company-keywords company-css)))

(use-package web-mode
  :ensure t
  :mode (
         ("\\.vue\\'" . web-mode)
         ("\\.less\\'" . css-mode)
         ("\\.json\\'" . web-mode)
         ("\\.html\\'" . web-mode))
  :config
  (add-hook 'web-mode-hook 'company-mode)
  (add-hook 'web-mode-hook 'setup-web-mode-company-mode)
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'smartparens-mode)
  (add-hook 'web-mode-hook 'editorconfig-mode)
  (add-hook 'web-mode-hook
            (lambda ()
              (progn
                (setq web-mode-script-padding 0)
                (when (string= web-mode-content-type "jsx")
                  (progn
                    (setq-local emmet-expand-jsx-className? t))))))
  (define-key web-mode-map (kbd "C-j") 'emmet-expand-line)
  (define-key web-mode-map (kbd "C-c z z") 'nodejs-repl)
  (define-key web-mode-map (kbd "C-c z r") 'nodejs-repl-send-region)
  (define-key web-mode-map (kbd "C-c z l") 'nodejs-repl-send-last-sexp)
  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
  (add-to-list 'web-mode-content-types '("html" . "\\.vue\\'"))
  (add-to-list 'web-mode-content-types '("json" . "\\.json\\'"))
  (add-to-list 'web-mode-content-types '("jsx" . ".\\.js[x]?\\'")))

;;; company
(use-package company-quickhelp
       :ensure)

(use-package company
  :ensure t
  :config
  (setq company-minimum-prefix-length 1)
  (setq company-dabbrev-downcase nil)
  (setq company-dabbrev-ignore-case nil)
  (setq company-idle-delay 0.5)
  (setq company-echo-delay 0.5)
  (add-hook 'company-mode-hook 'company-quickhelp-mode)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "<tab>") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))
;;; eshell
(use-package eshell-git-prompt
  :ensure)
(use-package eshell
  :config
  (remove-hook 'completion-at-point-functions 'pcomplete-completions-at-point t))
(use-package eshell-functions
  :load-path "./lisp")

;;; emacs config
(let ((tempname (expand-file-name "setting.el" user-emacs-directory)))
  (when (file-exists-p tempname)
    (delete-file tempname)))

(setq-default browse-url-browser-function 'eww-browse-url)
(global-unset-key (kbd "C-\\"))
;; (require 'f)
;; (when (f-exists-p "/usr/share/emacs/site-lisp/mu4e/mu4e.el")
;;   (add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
;;   (require 'mu4e))

(use-package citre
  :load-path "./site-lisp/citre")

(use-package eaf
  :load-path "./site-lisp/emacs-application-framework"
  :commands (eaf-open)
  :config
  (require 'eaf-pdf-viewer)
  )

;; (require 'citre)
;; (require 'citre-config)

(unless (f-directory-p "~/.emacs.d/backups")
  (f-mkdir "~/.emacs.d/backups"))

(unless (f-directory-p "~/.emacs.d/autosaves")
  (f-mkdir "~/.emacs.d/autosaves"))

(custom-set-variables
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))
(setq create-lockfiles nil)
(global-auto-revert-mode)

(define-key global-map (kbd "C-x C-n") '(lambda () (interactive) (other-window 1)))
(define-key global-map (kbd "C-x C-p") '(lambda () (interactive) (other-window -1)))
(define-key global-map (kbd "C--") 'execute-extended-command)

(setq backup-by-copying t
      backup-directory-alist
      '(("." . "~/.saves"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(set-language-environment "UTF-8")
(define-key global-map (kbd "C-c ,") 'rename-buffer)

(use-package exec-path-from-shell
  :load-path "./site-lisp/exec-path-from-shell"
  :ensure)

(exec-path-from-shell-copy-env "PATH")
(setenv "TZ" "Asia/Shanghai")

(use-package hl-line
  :ensure
  :hook (after-init . global-hl-line-mode))


;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
 '(dired-listing-switches "-alh")
 '(line-number-mode nil)
 '(package-selected-packages
   '(lsp-bridge rust-mode js2-refactor multiple-cursors emmet-jsx-major-modes js-mode js2-mode posframe yaml-mode pdf-tools csv-mode org-analyzer edit-indirect org tide flycheck-mode flycheck web-beautify neotree json-mode ag company-quickhelp company-tern window-purpose markdown-preview-mode markdown-mode python-mode editorconfig helpful pass diminish dashboard snazzy-theme base16-theme dante grizzl hackernews youdao-dictionary counsel-projectile projectile avy magit whitespace-cleanup-mode counsel-dash haskell-mode web-mode nodejs-repl emmet-mode dumb-jump dockerfile-mode company-jedi company eshell-git-prompt smartparens mode-icons org-download s)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-code-face ((t (:inherit fixed-pitch :background "gray20" :foreground "dark orange"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 2.0))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.8))))
 '(minibuffer-prompt ((t (:foreground "blue" :weight bold)))))


(with-current-buffer (get-buffer " *Echo Area 0*")                             ; the leading space character is correct
  (setq-local face-remapping-alist
              '((default (:foreground "red") variable-pitch)))) ; etc.
