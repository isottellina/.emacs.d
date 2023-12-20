(defmacro itln/load-modules (&rest modules)
  `(progn ,@(mapcar (lambda (module) `(require (quote ,(intern (concat "init-" (symbol-name module)))))) modules)))

(provide 'module-system)
