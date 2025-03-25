(unbind-key "C-z")

(use-package dashboard
  :config
  (setq dashboard-center-content t)
  (dashboard-setup-startup-hook))


(use-package myron-themes
  :straight (myron-themes :host github :repo "neeasade/myron-themes" :files ("*.el" "themes/*.el")))

(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-add-column-padding 3))

(use-package ibuffer
  :config
  (unbind-key "M-o" 'ibuffer-mode-map)
  :bind ([remap list-buffers] . #'ibuffer-other-window))

(use-package diredfl
  :hook (dired-mode . diredfl-mode))

(use-package avy
  :bind (("M-g s" . 'avy-goto-char-timer)
	 ("M-g l" . 'avy-goto-line)))

(use-package anzu
  :init
  (global-anzu-mode +1))

(use-package embark
  :bind ("C-c a" . embark-act))

(use-package embark-consult
  :after (consult embark))

(use-package hl-todo
  :ensure t
  :init (global-hl-todo-mode))

(use-package solaire-mode
  :config
  (solaire-global-mode +1))

(defun itln/move-beginning-of-indent-or-line (prefix)
  (interactive "P")
  (if prefix
      (beginning-of-line)
    (beginning-of-line-text)))

(use-package emacs
  :bind ([remap move-beginning-of-line] . itln/move-beginning-of-indent-or-line))

(provide 'init-basic-ui)
