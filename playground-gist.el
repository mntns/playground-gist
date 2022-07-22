;;; playground-gist.el --- Share code snippets on the Rust Playground -*- lexical-binding: t; -*-

;; Copyright (C) 2022 Niklas Kunz

;; Author: Niklas Kunz <post@monoton.space>
;; Maintainer: Niklas Kunz <post@monoton.space>
;; Created: 22 Jul 2022
;; Version: 0.0.1

;; Keywords: rust gist playground
;; URL: https://github.com/mntns/playground-gist

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; playground-gist enables you to share code snippets
;; on the Rust Playground directly from within Emacs.

;;; Code:

(require 'json)
(require 'request)
(require 'browse-url)

(defvar playground-gist-url "https://play.rust-lang.org" "URL of the rust-playground instance")

(defun playground-gist--open (gist-id)
  (browse-url
   (format "%s%s%s"
           playground-gist-url
           "/?version=stable&mode=debug&edition=2021&gist="
           gist-id)))

(defun playground-gist--share (code)
  (request (concat playground-gist-url "/meta/gist")
  :type "POST"
  :data (json-encode `(("code" . ,code)))
  :headers '(("Content-Type" . "application/json"))
  :parser 'json-read
  :success (cl-function
            (lambda (&key data &allow-other-keys)
              (playground-gist--open (alist-get 'id data))))))

(defun playground-gist-share-buffer ()
  "Shares the current buffer on the Rust Playground"
  (interactive)
  (playground-gist--share
   (buffer-substring-no-properties (point-min) (point-max))))

(defun playground-gist-share-region ()
  "Shares the current region on the Rust Playground"
  (interactive)
  (playground-gist--share
   (buffer-substring-no-properties (region-beginning) (region-end))))
    
(provide 'playground-gist)

;;; playground-gist.el ends here
