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


(let
    ((__dirname (file-name-directory load-file-name)))

  ;; load setting.org
  (org-babel-load-file
   (expand-file-name "setting.org" __dirname))
  ;; remove sideeffect setting.el
  (when (file-exists-p (expand-file-name "setting.el" __dirname))
    (delete-file (expand-file-name "setting.el" __dirname))))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(browse-url-browser-function (quote eww-browse-url))
 '(column-number-mode t)
  '(custom-safe-themes
     (quote
       ("b3bcf1b12ef2a7606c7697d71b934ca0bdd495d52f901e73ce008c4c9825a3aa" "3f67aee8f8d8eedad7f547a346803be4cc47c420602e19d88bdcccc66dba033b" "d9dab332207600e49400d798ed05f38372ec32132b3f7d2ba697e59088021555" "0809485f08aa8c9b0100033eaa2d04f6a7410c2afcdbd76ce368a7a8e5744ffb" default)))
 '(org-download-screenshot-method "xclip -selection clipboard -t image/png -o > %s")
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(org-trello-current-prefix-keybinding "C-c o" nil (org-trello))
  '(org-trello-files
     (seq-filter
       (lambda
         (x)
         (s-suffix\? ".org" x))
       (directory-files "~/org/trello" t)) nil (org-trello))
  '(package-selected-packages
     (quote
       (org-trello magithub magit-todos nginx-mode ox-gfm ox-pandoc web-beautify geiser direx ag which-key lsp-javascript html-mode sass-mode less-mode dot-mode gitter lsp-javascript-typescript rust-mode lsp-flycheck lsp-vue company-lsp ht vue-mode kv lsp-mode json-mode company-quickhelp company-tern window-purpose markdown-preview-mode markdown-mode python-mode editorconfig helpful pass diminish dashboard snazzy-theme base16-theme dante grizzl hackernews youdao-dictionary counsel-projectile projectile avy magit whitespace-cleanup-mode counsel-dash haskell-mode web-mode nodejs-repl emmet-mode dumb-jump dockerfile-mode company-jedi company pyim eshell-git-prompt smartparens mode-icons org-download s use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-face-highlight-textual ((t (:foreground "steel blue"))))
 '(markdown-code-face ((t (:inherit fixed-pitch :background "gray20" :foreground "dark orange"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 2.0))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.8)))))
