;;;;;;;;;;;;;
;; Custom  ;;
;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f12083eec1537fc3bf074366999f0ee04ab23ab3eaba57614785d88b9db2a5d4" "4343cbc036f09361b2912119c63573433df725f599bfbdc16fb97f1e4847a08b" "c24f30a80f5d8f4f3a6b729510d1bf282dd7fac7969748a5e43fc8c6a836eee7" "6f1f6a1a3cff62cc860ad6e787151b9b8599f4471d40ed746ea2819fcd184e1a" "34cf3305b35e3a8132a0b1bdf2c67623bc2cb05b125f8d7d26bd51fd16d547ec" default))
 '(safe-local-variable-values '((engine . jinja2) (engine . django) (engine . jinja)))
 '(warning-suppress-log-types '((comp))))
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

(straight-use-package 'use-package)
(setq straight-use-package-by-default t
      straight-host-usernames '((github . "isottellina")))


;;;;;;;;;;;;;;;;;;
;; Personal lib ;;
;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path (concat user-emacs-directory "lib"))
(let ((default-directory (concat user-emacs-directory "modules")))
  (normal-top-level-add-subdirs-to-load-path))

(require 'module-system)

(itln/load-modules keymap basic-ui minibuffer window project)

(itln/load-modules completion git lsp term org docker spotify format doc rest make
		   devops python rust elisp yaml web asm)


;;;;;;;;;;;;;;;;;;
;; Emacs config ;;
;;;;;;;;;;;;;;;;;;

(defvar itln-quit-hook nil)

(defun itln/quit (&optional interactive)
  (interactive '(interactive))
  (let ((inhibit-quit t))
    (cond ((run-hook-with-args-until-success 'itln-quit-hook))
	  ((unwind-protect (keyboard-quit)
	     (when interactive
	       (setq this-command 'keyboard-quit)))))))

(use-package emacs
  :bind ([remap keyboard-quit] . itln/quit)
  :config
  (scroll-bar-mode -1)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (set-frame-font "Hack 9")
  (global-display-line-numbers-mode)
  (electric-pair-mode)
  (recentf-mode 1)
  (global-hl-line-mode)
  (setq backup-directory-alist `(("." . ,(expand-file-name (concat user-emacs-directory "backups"))))
	create-lockfiles nil
	use-short-answers t
	require-final-newline t
	indent-tabs-mode nil
	mode-require-final-newline t
	authinfo-hidden (regexp-opt '("password" "client-secret")))
  (add-to-list 'auto-save-file-name-transforms `("\\`/\\(\\(?:[^/]*/\\)*[^/]*\\)\\'" ,(concat user-emacs-directory "backups/\\2") t)))
(put 'magit-edit-line-commit 'disabled nil)
