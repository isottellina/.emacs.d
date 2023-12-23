(unbind-key "C-z")

(use-package dashboard
  :config
  (setq dashboard-center-content t)
  (dashboard-setup-startup-hook))

(use-package doom-themes
  :init (load-theme 'doom-nord))

(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-add-column-padding 3))

(use-package ibuffer
  :bind ([remap list-buffers] . #'ibuffer-other-window))

(use-package solaire-mode
  :config
  (solaire-global-mode +1))

(provide 'init-basic-ui)
