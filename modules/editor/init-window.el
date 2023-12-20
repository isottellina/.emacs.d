(use-package ace-window
  :bind ("M-o" . ace-window)
  :config (setq aw-dispatch-always t
		aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?m)))

(use-package popper
  :init
  (setq popper-reference-buffers '("\\*Messages\\*"
				   "\\*Warnings\\*"
				   "Output\\*$"
				   "\\*Async Shell Command\\*"
				   help-mode
				   compilation-mode
				   "^\\*eshell.*\\*$" eshell-mode
				   "^\\*vterm.*\\*$"  vterm-mode)
	popper-window-height 25)
  (popper-mode +1)
  (popper-echo-mode +1))

(use-package emacs
  :config
  (setq display-buffer-base-action '(display-buffer-in-direction . ((direction . right)))))

(provide 'init-window)
