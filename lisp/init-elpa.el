(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(add-to-list 'package-archives
	     '("popkit" . "https://elpa.popkit.org/packages/"))

(package-initialize)
(provide 'init-elpa)
