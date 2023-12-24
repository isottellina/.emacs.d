(use-package ace-window
  :bind ("M-o" . ace-window)
  :config (setq aw-dispatch-always t
		aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?m)))

(use-package popper
  :bind (("C-c C-z" . popper-toggle))
  :init
  (setq popper-reference-buffers '("\\*Messages\\*"
				   "\\*Warnings\\*"
				   "Output\\*$"
				   "\\*Async Shell Command\\*"
				   "\\*Cargo [[:alpha:]]+\\*"
				   help-mode
				   compilation-mode
				   "^\\*eshell.*\\*$" eshell-mode
				   "^\\*vterm.*\\*$"  vterm-mode)
	popper-window-height 25)
  (popper-mode +1)
  (popper-echo-mode +1))

(use-package emacs
  :config
  (setq display-buffer-base-action '(display-buffer-in-direction . ((direction . rightmost))))
  (add-to-list 'display-buffer-alist `(,(regexp-quote "*Org Agenda*") . (display-buffer-in-side-window . ((side . right))))))

(provide 'init-window)
