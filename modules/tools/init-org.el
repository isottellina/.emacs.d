(define-prefix-command 'itln/org-keymap 'itln/org-keymap)
(bind-key "C-c n" #'itln/org-keymap)

(defun itln/find-file-in-org-directory ()
  (interactive)
  (let ((current-directory org-directory))
    (find-file (read-file-name "Org file? " (concat org-directory "/")))))

(defvar itln/org-todo-file)
(defun itln/todo-in-sidebar ()
  (interactive)
  (let* ((buffer (find-file-noselect itln/org-todo-file))
	 (buffer-window (get-buffer-window buffer)))
    (if (and buffer-window
	     (window-at-side-p buffer-window 'right))
	(quit-window nil buffer-window) ; if buffer is already displayed, kill the window
      (pop-to-buffer buffer '(display-buffer-in-side-window . ((side . right)))))))

(use-package org
  :hook (org-mode . org-indent-mode)
  :bind (:map itln/org-keymap (("c" . #'org-capture)
			       ("f" . #'itln/find-file-in-org-directory)
			       ("o" . #'org-clock-out)
			       ("a" . #'org-agenda)
			       ("t" . #'itln/todo-in-sidebar)))
  :config
  (setq itln/org-todo-file (concat org-directory "/todo.org")
	org-default-notes-file (concat org-directory "/notes.org")
	org-capture-templates `(("t" "Add to my TODO list"
				 entry (file+headline ,itln/org-todo-file "Inbox")
				 "** TODO %?" :empty-lines-after 1)
				("l" "TODO list with link"
				 entry (file+headline ,itln/org-todo-file "Inbox")
				 "** TODO %?\n%a" :empty-lines-after 1)
				("c" "TODO list and clock in immediately"
				 entry (file+headline ,itln/org-todo-file "Inbox")
				 "** TODO %?\n%a" :empty-lines-after 1 :clock-in t))
	org-agenda-custom-commands '(("g" "View tasks per todo tag"
				      ((todo "BACKLOG") (todo "TODO") (todo "IN PROGRESS") (todo "DONE"))))
	org-agenda-files '("todo.org" "agenda.org")
	org-todo-keywords '((sequence "BACKLOG" "TODO" "IN PROGRESS" "|" "DONE"))))

(use-package orgit
  :after org)

(use-package org-roam
  :config
  (setq org-roam-directory (file-truename "~/org/roam")
	org-roam-node-display-template
        (concat "${title:*} "
                (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  :bind (:map itln/org-keymap
	      ("r c" . org-roam-capture)
	      ("r f" . org-roam-node-find)
	      ("r i" . org-roam-node-insert)))

(provide 'init-org)
