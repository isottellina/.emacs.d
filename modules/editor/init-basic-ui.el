(use-package dashboard
  :config
  (setq dashboard-center-content t)
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (dashboard-setup-startup-hook))

(use-package doom-themes
  :init (load-theme 'doom-nord))

(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-add-column-padding 3))

(use-package solaire-mode
  :config
  (solaire-global-mode +1))

(provide 'init-basic-ui)