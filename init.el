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

;; UI packages
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(set-frame-font "Hack 9")

(column-number-mode)

(use-package doom-themes
  :config
  (setq doom-themes-enable-italic t)
  (load-theme 'doom-1337 t))

(use-package marginalia
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
(use-package magit)
(use-package corfu
  :config
  (setq corfu-auto t
	completion-styles '(basic))
  :init
  (global-corfu-mode))


;; Global config
(use-package emacs
  :init
  (setq tab-always-indent 'complete)
  :bind (("M-o b" . split-window-right)
	 ("M-o v" . split-window-below)))
