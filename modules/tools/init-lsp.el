(use-package eglot
  :commands (eglot eglot-ensure)
  :config
  (setf (alist-get '(python-mode python-ts-mode) eglot-server-programs nil nil #'equal)
	'("pylsp"))
  (setq-default eglot-workspace-configuration '(:pylsp (:plugins (:rope_autoimport (:enabled t))))))

(provide 'init-lsp)
