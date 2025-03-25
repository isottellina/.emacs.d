(defvar elpaca-installer-version 0.10)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

(use-package use-package
  :config
  (setq use-package-always-ensure t))

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
(elpaca-process-queues)

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
  :ensure nil
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
