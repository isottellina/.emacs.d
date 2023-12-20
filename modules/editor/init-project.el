(use-package projectile
  :bind ("C-c p" . projectile-command-map)
  :config
  (projectile-mode +1))

(use-package projectile
  :after consult
  :bind (:map projectile-command-map ("s" . consult-ripgrep)))

(provide 'init-project)
