;; Straight.el bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq straight-use-package-by-default t)

;; Quality of life
(use-package no-littering
  :config
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

;; UI packages
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(set-frame-font "Hack 9")

(column-number-mode)
(global-display-line-numbers-mode)

(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-completion
  :after (marginalia all-the-icons)
  :if (display-graphic-p)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))

(use-package doom-themes
  :config
  (setq doom-themes-enable-italic t)
  (load-theme 'doom-1337 t))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5)
                          (projects . 5)
                          (agenda . 5))))

(use-package marginalia
  :config
  (setq marginalia-align 'right)
  :init
  (marginalia-mode))

(use-package vertico
  :straight (vertico :files ("*.el" "extensions/*.el"))
  :config
  (setq vertico-resize nil
        vertico-count 20
        vertico-cycle t)
  :init
  (vertico-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles orderless partial-completion))))
  (orderless-matching-styles
   '(orderless-literal
     orderless-prefixes
     orderless-initialism
     orderless-regexp)))

(use-package vertico-directory
                                        ; Package is in vertico, so straight will try to
                                        ; install it via a repo but it shouldn't.
  :straight nil
  :after vertico
  :bind (:map vertico-map
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word)))

(use-package consult
  :config
  :init
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :bind (("C-x b" . consult-buffer)))

(use-package embark)
(use-package embark-consult)

(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package which-key
  :init
  (which-key-mode))

(use-package ace-window
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
        aw-dispatch-always t)
  :bind ("M-o" . ace-window))

;; DevX packages
(add-hook 'before-save-hook 'whitespace-cleanup)
(use-package magit
  :bind
  (:map vc-prefix-map ("B" . #'magit-blame-addition))
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1
        magit-blame-echo-style 'headings
        magit-blame-read-only t
        magit-save-repository-buffers nil))

(use-package forge
  :after magit)
(use-package ghub
  :after ghub)

(use-package corfu
  :config
  (setq corfu-auto t)
  :init
  (global-corfu-mode))

(use-package corfu-terminal
  :init
  (corfu-terminal-mode +1))

(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-use-icons t)
  (kind-icon-default-face 'corfu-default)
  (kind-icon-blend-background nil)
  (kind-icon-blend-frac 0.08)
  (svg-lib-icons-dir (no-littering-expand-var-file-name "svg-lib/cache/")) ; Change cache dir
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
  (add-hook 'kb/themes-hooks #'(lambda () (interactive) (kind-icon-reset-cache))))

(use-package eglot
  :straight nil
  :config
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode) . ("pyright-langserver" "--stdio")))
  :hook ((python-mode . eglot-ensure)
         (python-ts-mode . eglot-ensure)
         (rust-ts-mode . eglot-ensure)))

(use-package language-id
  :straight (language :type git :host github :repo "lassik/emacs-language-id"
                      :fork (:host github :repo "isottellina/emacs-language-id" :branch "add-ts-modes")))

(use-package format-all
  :bind
  ("C-c f" . format-all-buffer))

;; Python
(use-package pyvenv
  :config
  (setenv "WORKON_HOME" "~/Envs"))


(use-package py-isort
  :commands py-isort-buffer)

;; Web
(use-package restclient
  :mode ("\\.rc\\'" . restclient-mode))

;; Rust
(use-package rust-mode
  :after eglot
  :commands rust-mode
  :hook (rust-mode . eglot-ensure))

(use-package cargo
  :after rust-mode
  :commands cargo-minor-mode)

;; Minor languages
(use-package terraform-mode)
(use-package yaml-mode
  :mode ("\\.ya?ml" . yaml-mode))

;; Global config
(use-package org
  :custom (org-agenda-files '("/home/louise/org/agenda.org")))

(use-package emacs
  :mode (("Dockerfile\\(?:\\'\\|\\.[^z-a]\\)" . dockerfile-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode))
  :config
  (add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))
  :init
  (setq-default tab-always-indent 'complete
                use-short-answers t
                indent-tabs-mode nil))
