(use-package magit
  :bind ("C-x g" . magit)
  :init (setq magit-define-global-key-bindings 'recommended)
  :config (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package magit-todos
  :after magit
  :config (magit-todos-mode 1))

(provide 'init-git)
