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

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)


;;;;;;;;;;;;;;;;;;
;; Personal lib ;;
;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path (concat user-emacs-directory "lib"))
(let ((default-directory (concat user-emacs-directory "modules")))
  (normal-top-level-add-subdirs-to-load-path))

(require 'module-system)


;;;;;;;;;;;;;;;;;;;;;
;; Basic UI config ;;
;;;;;;;;;;;;;;;;;;;;;

(itln/load-modules basic-ui minibuffer window project)


;;;;;;;;;;;;;;;;;;;;;
;; Personal keymap ;;
;;;;;;;;;;;;;;;;;;;;;

(define-prefix-command 'personal-keymap 'personal-keymap)
(bind-keys :map personal-keymap
	   ("C-b" . previous-buffer)
	   ("C-p" . next-buffer))

(bind-key "C-é" #'personal-keymap)

(define-prefix-command 'itln/tools-keymap 'itln/tools-keymap)
(bind-key "C-c o" #'itln/tools-keymap)

;;;;;;;;;;;;;;;
;; Dev setup ;;
;;;;;;;;;;;;;;;

(itln/load-modules completion git lsp term
		   python rust elisp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Display-buffer config ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package emacs
  :config
  (add-to-list 'display-buffer-alist `(,(regexp-opt '("*Warnings*" "*Messages*"))
					       (display-buffer-in-side-window)
					       (side . bottom))))

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
  (set-frame-font "Iosevka NF 10")
  (global-display-line-numbers-mode)
  (electric-pair-mode)
  (recentf-mode 1)
  (global-hl-line-mode)
  (setq backup-directory-alist `(("." . ,(expand-file-name (concat user-emacs-directory "backups"))))
	create-lockfiles nil
	use-short-answers t
	require-final-newline t
	indent-tabs-mode nil
	mode-require-final-newline t)
  (add-to-list 'auto-save-file-name-transforms `("\\`/\\(\\(?:[^/]*/\\)*[^/]*\\)\\'" ,(concat user-emacs-directory "backups/\\2") t)))
