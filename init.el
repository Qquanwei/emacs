;;; package -- Summary
;;; Commentary:
;;; Code:
;;; -*- lexical-binding: t -*-


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'org)
(org-babel-load-file
 (expand-file-name "setting.org" user-emacs-directory))

(let ((tempname (expand-file-name "setting.el" user-emacs-directory)))
  (when (file-exists-p tempname)
    (delete-file tempname)))



;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company-quickhelp company-tern window-purpose markdown-preview-mode markdown-mode python-mode editorconfig helpful pass diminish dashboard snazzy-theme base16-theme dante grizzl hackernews youdao-dictionary counsel-projectile projectile avy magit whitespace-cleanup-mode counsel-dash haskell-mode web-mode nodejs-repl emmet-mode dumb-jump dockerfile-mode company-jedi company pyim eshell-git-prompt smartparens mode-icons org-download s use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-code-face ((t (:inherit fixed-pitch :background "gray20" :foreground "dark orange"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 2.0))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.8)))))
