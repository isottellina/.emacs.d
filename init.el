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

(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-completion
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))

(use-package doom-themes
  :config
  (setq doom-themes-enable-italic t)
  (load-theme 'doom-1337 t))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

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

(use-package which-key
  :init
  (which-key-mode))

;; DevX packages
(use-package magit
  :bind
  (:map vc-prefix-map ("B" . #'magit-blame-addition))
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1
	magit-blame-echo-style 'headings
	magit-blame-read-only t))

(use-package corfu
  :config
  (setq corfu-auto t
	completion-styles '(basic))
  :init
  (global-corfu-mode))

(use-package eglot
  :straight nil
  :config
  (add-to-list 'eglot-server-programs
	       '((python-mode python-ts-mode) . ("python" "-m" "pylsp")))
  :hook (python-mode . eglot-ensure))

;; Python
(setenv "WORKON_HOME" "~/Envs")
(use-package pyvenv)

;; Global config
(use-package emacs
  :init
  (setq tab-always-indent 'complete)
  :bind (("M-o M-b" . split-window-right)
	 ("M-o M-v" . split-window-below)
	 ("M-o M-o" . other-window)
	 ("M-o M-x" . delete-window)))
