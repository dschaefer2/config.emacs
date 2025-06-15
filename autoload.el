;;;###autoload
(defun doug/eglot-capf-with-yasnippet ()
  (setq-local completion-at-point-functions
              (list 
	       (cape-capf-super
		#'eglot-completion-at-point
		#'yasnippet-capf))))

 ;;;###autoload
(defun doug/make-run ()
  (interactive)
  (makefile-executor-execute-project-target))

;;;###autoload
(defun doug/make-last ()
  (interactive)
  (makefile-executor-execute-last nil))
