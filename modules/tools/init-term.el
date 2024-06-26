(require 'itln)

(use-package vterm  
  :hook (vterm-mode . itln/line-number-disable))

(use-package multi-vterm
  :bind (:map itln/tools-keymap ("t" . multi-vterm)))

(provide 'init-term)
