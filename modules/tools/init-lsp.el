(use-package eglot
  :commands (eglot eglot-ensure)
  :config (setf (alist-get '(python-mode python-ts-mode) eglot-server-programs nil nil #'equal)
		'("pyright-langserver" "--stdio")))

(provide 'init-lsp)
