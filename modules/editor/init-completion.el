;; (use-package corfu
;;   :init
;;   (global-corfu-mode)
;;   (corfu-echo-mode +1)
;;   :config
;;   (setq corfu-auto t)
;;   (setq corfu-echo-delay '(1.0 . 0.0)))

(use-package company
  :config (global-company-mode))

(provide 'init-completion)
