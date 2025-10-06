(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(load-theme 'modus-vivendi)
(menu-bar-mode -1)
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(let ((mono-space-font "Cascadia Mono")
      (proportionately-spaced-font "Sans"))
  (set-face-attribute 'default nil :family mono-space-font :height 120)
  (set-face-attribute 'fixed-pitch nil :family mono-space-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

(setq make-backup-files nil)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

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

(use-package verilog-mode
  :ensure nil
  :config
  (setq verilog-indent-level 4)
  (setq verilog-case-indent 4)
  (setq verilog-cexp-indent 4)
  (setq verilog-indent-level-module 4)
  (setq verilog-indent-level-declaration 4)
  (setq verilog-auto-newline nil)
  (setq verilog-indent-lists nil))

(use-package eglot
  :ensure nil
  :hook ((swift-mode . eglot-ensure)
	 (verilog-mode . eglot-ensure))
  :bind (("C-x ." . xref-find-references))
  :config
  (setq eglot-strict-mode nil)
  (add-to-list 'eglot-server-programs
	       '(swift-mode . ("sourcekit-lsp")))
  (add-to-list 'eglot-server-programs
	       '(verilog-mode . ("verible-verilog-ls"))))
