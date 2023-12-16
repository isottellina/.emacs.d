;;;;;;;;;;;;;
;; Custom  ;;
;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("34cf3305b35e3a8132a0b1bdf2c67623bc2cb05b125f8d7d26bd51fd16d547ec" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;;;
;; Init straight.el ;;
;;;;;;;;;;;;;;;;;;;;;;

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(straight-use-package 'use-package)

;;;;;;;;;;;;;;;;;;;;;
;; Basic UI config ;;
;;;;;;;;;;;;;;;;;;;;;

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package doom-themes
  :init (load-theme 'doom-nord))

(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-add-column-padding 3))

(use-package vertico
  :init (vertico-mode)
  :config (setq vertico-count 20
		vertico-resize nil))

(use-package all-the-icons-completion
  :if (display-graphic-p)
  :after marginalia
  :config (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)
  :init (all-the-icons-completion-mode))

(use-package marginalia
  :bind (:map minibuffer-local-map ("M-A" . marginalia-cycle))
  :init (marginalia-mode))

(use-package consult
  :bind (([remap switch-to-buffer] . consult-buffer)
	 ("C-x B" . consult-buffer-other-window)
	 ("C-h t" . consult-theme))
  :config (setq xref-show-xrefs-function #'consult-xref
		xref-show-definitions-function #'consult-xref))

(use-package ace-window
  :bind ("M-o" . ace-window)
  :config (setq aw-dispatch-always t
		aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?m)))

;;;;;;;;;;;;;;;
;; Dev setup ;;
;;;;;;;;;;;;;;;

(use-package corfu
  :init (global-corfu-mode)
  :config (setq corfu-auto t))

(use-package magit
  :bind ("C-x g" . magit))

;;;;;;;;;;;;;;;;;;;;;
;; Personal keymap ;;
;;;;;;;;;;;;;;;;;;;;;

(define-prefix-command 'personal-keymap 'personal-keymap)
(bind-keys :map personal-keymap
	   ("C-b" . previous-buffer)
	   ("C-p" . next-buffer))

(bind-key "C-é" #'personal-keymap)

;;;;;;;;;;;;;;;;;;
;; Emacs config ;;
;;;;;;;;;;;;;;;;;;

(use-package emacs
  :config
  (scroll-bar-mode -1)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (set-frame-font "Iosevka NF 10")
  (global-display-line-numbers-mode)
  (electric-pair-mode)
  (recentf-mode 1)
  (setq backup-directory-alist `(("." . ,(expand-file-name (concat user-emacs-directory "backups"))))
	create-lockfiles nil
	use-short-answers t)
  (add-to-list 'auto-save-file-name-transforms `("\\`/\\(\\(?:[^/]*/\\)*[^/]*\\)\\'" ,(concat user-emacs-directory "backups/\\2") t)))
