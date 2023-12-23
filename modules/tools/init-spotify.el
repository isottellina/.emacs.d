;;; init-spotify.el --- Control Spotify within Emacs. Use Smudge  -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Louise Zanier

;; Author: Louise Zanier <louise@Lovelace>
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

(use-package smudge
  :bind (:map itln/tools-keymap ("s" . smudge-command-map))
  :config
  (let* ((auth-info (car (auth-source-search :host "spotify.com")))
	 (client-id (plist-get auth-info :client-id))
	 (client-secret (plist-get auth-info :client-secret)))
    (setq smudge-oauth2-client-id client-id
	  smudge-oauth2-client-secret client-secret
	  smudge-oauth2-callback-port "4444"
	  smudge-api-oauth2-callback "http://localhost:4444/smudge-api-callback")))

(provide 'init-spotify)
;;; init-spotify.el ends here
