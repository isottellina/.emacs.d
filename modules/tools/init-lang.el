; ASM
(use-package nasm-mode
  :ensure t
  :mode "\\.S\\'")

; C
(defun lzr/set-c-prettify-symbols ()
  (setq-local prettify-symbols-alist '((">=" . ?≥)
				       ("<=" . ?≤)
				       ("!=" . ?≠)
				       ("->" . ?→)))
  (prettify-symbols-mode))

(use-package cc-mode
  :ensure nil
  :config
  (setf (alist-get 'c++-mode c-default-style) "bsd"
	(alist-get 'c-mode c-default-style) "bsd"
	c-basic-offset 4)
  :hook (((c-mode c++-mode) . eglot-ensure)
	 ((c-mode c++-mode) . subword-mode)
	 ((c-mode c++-mode) . lzr/set-c-prettify-symbols)))

;; Emacs lisp
(use-package highlight-quoted
  :ensure t
  :hook (emacs-lisp-mode . highlight-quoted-mode))

(use-package paredit
  :ensure t
  :hook (emacs-lisp-mode . paredit-mode))

(use-package emacs
  :ensure nil
  :hook (emacs-lisp-mode . auto-insert-mode))

;; Lisp
(use-package racket-mode)

;; Rust
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
  :bind (:map magit-cargo-map ("C-c C-a" . cargo-minor-mode-command-map))
  :after rust-mode
  :hook (rust-mode . cargo-minor-mode))

(use-package magit
  :ensure nil
  :after cargo
  :hook (magit-mode . magit-cargo-mode-if-rust-project))

(use-package devdocs
  :ensure nil
  :after rust-mode
  :config
  (add-hook 'rust-mode-hook (lambda () (setq-local devdocs-current-docs '("rust")))))

;; Python
(use-package python-mode
  :hook (python-mode . eglot-ensure))

(use-package pyvenv)

(use-package devdocs
  :ensure nil
  :after python-mode
  :config
  (add-hook 'python-mode-hook (lambda () (setq-local devdocs-current-docs '("python~3.12")))))

;; Web
(use-package web-mode
  :mode "\\.html\\'"
  :config (setq web-mode-enable-engine-detection t
		web-mode-markup-indent-offset 2
		web-mode-css-indent-offset 2
		web-mode-code-indent-offset 2))

(provide 'init-lang)

(use-package haskell-mode)
