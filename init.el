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

(use-package straight
  :custom
  (straight-use-package-by-default t)
  (straight-host-usernames '((github . "isottellina")))
  (straight-built-in-pseudo-packages (append '(project xref flymake) straight-built-in-pseudo-packages)))

;; Load custom file before loading anything else
(setq custom-file (expand-file-name (concat user-emacs-directory "custom.el")))
(load custom-file)

;;;;;;;;;;;;;;;;;;
;; Personal lib ;;
;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path (concat user-emacs-directory "lib"))
(let ((default-directory (concat user-emacs-directory "modules")))
  (normal-top-level-add-subdirs-to-load-path))

(require 'module-system)

(itln/load-modules keymap basic-ui minibuffer window project)

(itln/load-modules completion git lsp term org docker spotify format doc rest make gdb
		   lang)

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
  :custom
  (native-comp-async-report-warnings-errors 'silent)
  :config
  (scroll-bar-mode -1)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (set-frame-font "Hack 9")
  (add-hook 'after-make-frame-functions
	    (lambda (frame) (with-selected-frame frame (set-frame-font "Hack 8"))))
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
