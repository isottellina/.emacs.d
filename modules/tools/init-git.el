(use-package magit
  :bind ("C-x g" . magit)
  :config (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))


(provide 'init-git)
