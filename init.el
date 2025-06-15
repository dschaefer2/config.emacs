(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(load (expand-file-name (concat user-emacs-directory "autoload.el")))

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(use-package emacs
    :init
    (menu-bar-mode -1)
    (fido-vertical-mode)
    (setq make-backup-files nil))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-tokyo-night t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package savehist
  :ensure nil ; it is built-in
  :hook (after-init . savehist-mode))

(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :config
  (setq corfu-auto t)
  (setq corfu-auto-prefix 1)
  (setq tab-always-indent 'complete)
  (setq corfu-preview-current nil)
  (setq corfu-min-width 20)

  (setq corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1) ; shows documentation after `corfu-popupinfo-delay'

  ;; Sort by input history (no need to modify `corfu-sort-function').
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

(use-package corfu-terminal
  :ensure t
  :hook ((corfu-mode . corfu-terminal-mode)))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles orderless partial-completion)))
        orderless-component-separator #'orderless-escapable-split-on-space))

(use-package which-key
    :ensure t
    :commands (which-key-mode)
    :init
    (which-key-mode))

(use-package markdown-mode
  :ensure t)

(use-package swift-mode
  :ensure t)

(use-package verilog-mode
  :ensure nil
  :config
  (setq verilog-indent-level             4
        verilog-indent-level-module      4
        verilog-indent-level-declaration 4
        verilog-indent-level-behavioral  4
        verilog-indent-level-directive   1
        verilog-case-indent              2
        verilog-auto-newline             t
        verilog-auto-indent-on-newline   t
        verilog-tab-always-indent        t
        verilog-auto-endcomments         t
        verilog-minimum-comment-distance 40
        verilog-indent-begin-after-if    t
        verilog-auto-lineup              'declarations))

(use-package eglot
  :ensure nil
  :after swift-mode
  :hook ((swift-mode . eglot-ensure)
	 (verilog-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               '(swift-mode . ("sourcekit-lsp")))
  (add-to-list 'eglot-server-programs
	       '(verilog-mode . ("svlangserver"))))

(use-package cape
  :ensure t)

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode t))

(use-package yasnippet-capf
  :after cape yasnippet
  :config
  (add-to-list 'completion-at-point-functions #'yasnippet-capf)
  :hook ('eglot-managed-mode-hook #'doug/eglot-capf-with-yasnippet))

(use-package makefile-executor
  :ensure t
  :bind (("C-c m n" . doug/make-run)
	 ("C-c m m" . doug/make-last)))
