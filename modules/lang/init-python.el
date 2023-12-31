(use-package python-mode
  :hook (python-mode . eglot-ensure))

(use-package devdocs
  :after python-mode
  :config
  (add-hook 'python-mode-hook (lambda () (setq-local devdocs-current-docs '("python~3.12")))))

(provide 'init-python)
