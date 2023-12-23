(use-package highlight-quoted
  :hook (emacs-lisp-mode . highlight-quoted-mode))

(use-package paredit
  :hook (emacs-lisp-mode . paredit-mode))

(use-package emacs
  :hook (emacs-lisp-mode . auto-insert-mode))

(provide 'init-elisp)
