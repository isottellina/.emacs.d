(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))


(use-package all-the-icons-completion
  :if (display-graphic-p)
  :after marginalia
  :config (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)
  :init (all-the-icons-completion-mode))


(use-package marginalia
  :bind (:map minibuffer-local-map ("M-A" . marginalia-cycle))
  :init (marginalia-mode))


(use-package vertico
  :init (vertico-mode)
  :config (setq vertico-count 20
		vertico-resize nil)
  :bind (:map vertico-map
	      ("DEL" . vertico-directory-delete-char)
	      ("M-q" . vertico-quick-insert)
	      ("C-q" . vertico-quick-quit)))


(use-package consult
  :bind (([remap switch-to-buffer] . consult-buffer)
	 ("C-x B" . consult-buffer-other-window)
	 ("C-h t" . consult-theme))
  :config (setq xref-show-xrefs-function #'consult-xref
		xref-show-definitions-function #'consult-xref))

(provide 'init-minibuffer)
