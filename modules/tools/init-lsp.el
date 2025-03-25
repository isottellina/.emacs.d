(use-package eglot
  :commands (eglot eglot-ensure)
  :config
  (setf (alist-get '(python-mode python-ts-mode) eglot-server-programs nil nil #'equal)
	'("pyright-langserver" "--stdio"))
  (setq-default eglot-workspace-configuration '(:pylsp (:plugins (:rope_autoimport (:enabled t)))))
  :custom
  (eglot-ignored-server-capabilities '(:documentOnTypeFormattingProvider)))

(use-package consult-eglot-embark
  :after eglot)

(use-package consult-eglot
  :bind (:map itln/tools-keymap
	      ("o" . consult-eglot-symbols)))

(provide 'init-lsp)
