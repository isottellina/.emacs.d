;;; init-web.el --- Web-mode                         -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Louise 

;; Author: Louise  <louise@Lovelace>
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

(use-package web-mode
  :mode "\\.html\\'"
  :config (setq web-mode-enable-engine-detection t
		web-mode-markup-indent-offset 2
		web-mode-css-indent-offset 2
		web-mode-code-indent-offset 2))

(provide 'init-web)
;;; init-web.el ends here
