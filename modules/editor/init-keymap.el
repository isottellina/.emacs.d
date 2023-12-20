
(define-prefix-command 'personal-keymap 'personal-keymap)
(bind-keys :map personal-keymap
	   ("C-b" . previous-buffer)
	   ("C-p" . next-buffer))

(bind-key "C-é" #'personal-keymap)

(define-prefix-command 'itln/tools-keymap 'itln/tools-keymap)
(bind-key "C-c o" #'itln/tools-keymap)

(provide 'init-keymap)
