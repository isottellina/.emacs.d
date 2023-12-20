(require 'itln)

(use-package vterm
  :bind (:map itln/tools-keymap ("t" . vterm))
  :hook (vterm-mode . itln/line-number-disable))

(provide 'init-term)
