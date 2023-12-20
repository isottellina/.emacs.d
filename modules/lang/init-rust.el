(use-package rust-mode
  :hook (rust-mode . eglot-ensure))

(use-package cargo
  :after rust-mode
  :hook (rust-mode . cargo-minor-mode))

(provide 'init-rust)
