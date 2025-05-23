;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq confirm-kill-emacs nil)

(setq doom-font (font-spec :family "JetBrainsMono NFM" :size 26))

(setq doom-theme 'doom-tokyo-night)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")

(setq lsp-file-watch-threshold 2000)

(use-package! verilog-mode
  :init
  (setq verilog-indent-level 4)
  (setq verilog-indent-level-module 4)
  (setq verilog-indent-level-behavioral 4)
  (setq verilog-indent-level-declaration 4)
  (setq verilog-indent-lists nil)
  (setq verilog-case-indent 4)
  :config
  (add-hook 'verilog-mode-local-vars-hook #'lsp! 'append))

(map!
 "C-c m m" #'+make/run-last
 "C-c m n" #'+make/run)
