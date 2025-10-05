(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(load-theme 'modus-vivendi)
(menu-bar-mode -1)

(setq make-backup-files nil)

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode))

(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :config
  (setq tab-always-indent 'complete)

  (setq corfu-auto t)
  (setq corfu-quit-no-match 'separator)
  (setq corfu-auto-delay 0)
  (setq corfu-auto-prefix 0)

  ;; Sort by input history (no need to modify `corfu-sort-function').
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

(use-package corfu-terminal
  :ensure t
  :if (not (display-graphic-p))
  :hook (corfu-mode . corfu-terminal-mode))

(use-package yasnippet
  :ensure t
  :config
  :hook (after-init . yas-global-mode))

(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t))

(use-package swift-mode
  :ensure t
  :config
  (setq swift-mode:parenthesized-expression-offset 4))

(use-package eglot
  :ensure nil
  :hook ((swift-mode . eglot-ensure))
  :config
  (setq eglot-strict-mode nil)
  (add-to-list 'eglot-server-programs
	       '(swift-mode . ("sourcekit-lsp"))))
