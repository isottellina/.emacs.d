(use-package rust-mode
  :mode ("\\.rs\\'" . rust-mode)
  :hook (rust-mode . eglot-ensure))

(defvar magit-cargo-map (make-sparse-keymap))
(defvar magit-cargo-minor-mode nil)
(define-minor-mode magit-cargo-minor-mode
  "Cargo minor mode in magit."
  :init-value nil
  :lighter " cargo "
  :keymap magit-cargo-map)

(defun magit-cargo-mode-if-rust-project ()
  "Activate magit-cargo-minor-mode if magit is open in a project
that has a Cargo.toml at the root of it."
  (when (file-exists-p (concat magit--default-directory "/Cargo.toml"))
    (magit-cargo-minor-mode +1)))

(use-package cargo
  :straight (cargo :type git :host github
		   :repo "kwrooijen/cargo.el"
		   :fork (:branch "feature/fix_command"))
  :bind (:map magit-cargo-map ("C-c C-a" . cargo-minor-mode-command-map))
  :after rust-mode
  :hook (rust-mode . cargo-minor-mode))

(use-package magit
  :after cargo
  :hook (magit-mode . magit-cargo-mode-if-rust-project))

(use-package devdocs
  :after rust-mode
  :config
  (add-hook 'rust-mode-hook (lambda () (setq-local devdocs-current-docs '("rust")))))

(provide 'init-rust)
