(setq make-backup-files nil)

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package emacs
    :init
    (menu-bar-mode -1)
    (fido-vertical-mode))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-tokyo-night t))

(use-package which-key
    :ensure t
    :commands (which-key-mode)
    :init
    (which-key-mode))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))
