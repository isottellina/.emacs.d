;;; init-format.el --- Formatters for my code        -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Louise

;; Author: Louise <louise@Lovelace>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(use-package apheleia
  :bind (:map prog-mode-map ("C-c c f" . apheleia-format-buffer))
  :config
  (setf (alist-get 'ruff apheleia-formatters) '("ruff" "check" "--fix-only" "-"))
  (setf (alist-get 'ruff-format apheleia-formatters) '("ruff" "format" "-"))
  (setf (alist-get 'python-mode apheleia-mode-alist) '(ruff ruff-format))
  (setf (alist-get 'python-ts-mode apheleia-mode-alist) '(ruff ruff-format)))

(provide 'init-format)
;;; init-format.el ends here
