;;; flymake-bashate.el --- A Flymake handler for Bash scripts using Bashate  -*- lexical-binding: t; -*-

;; Copyright (C) 2024 James Cherti | https://www.jamescherti.com/contact/

;; Author: James Cherti
;; Version: 0.9.9
;; URL: https://github.com/jamescherti/flymake-bashate.el
;; Keywords: tools
;; Package-Requires: ((flymake-quickdef "1.0.0") (emacs "26.1"))
;; SPDX-License-Identifier: GPL-3.0-or-later

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;; The `flymake-bashate` Emacs package integrates Bashate with Flymake, enabling
;; real-time syntax and style checks for Bash scripts directly within Emacs.
;;
;; Bashate is a Bash script syntax checker, enforcing a set of style and syntax
;; rules to ensure that your scripts are consistent, clean, and easy to read.

;;; Code:

(require 'flymake)
(require 'flymake-quickdef)

(defgroup flymake-bashate nil
  "Non-nil if flymake-bashate mode mode is enabled."
  :group 'flymake-bashate
  :prefix "flymake-bashate-"
  :link '(url-link
          :tag "Github"
          "https://github.com/jamescherti/flymake-bashate.el"))

(flymake-quickdef-backend flymake-bashate-checker
  :pre-let ((bashate-exec (executable-find "bashate")))
  :pre-check (unless bashate-exec (error "Cannot find bashate executable"))
  :write-type 'file
  :proc-form (list bashate-exec fmqd-temp-file)
  ;; Equivalent to:
  ;; "^[^:]+:\\([0-9]+\\):\\([0-9]+\\):[ \t]+\\(E[0-9]+\\) \\(.+\\)$"
  :search-regexp (rx bol
                     (zero-or-more (not ":")) ":"
                     (group (one-or-more digit)) ":"
                     (group (one-or-more digit)) ":"
                     (one-or-more (syntax whitespace))
                     (group "E" (one-or-more digit))
                     (one-or-more (syntax whitespace))
                     (group (one-or-more any))
                     eol)
  :prep-diagnostic
  (let* ((lnum (string-to-number (match-string 1)))
         (colnum (string-to-number (match-string 2)))
         (code (match-string 3))
         (text (match-string 4))
         (pos (flymake-diag-region fmqd-source lnum colnum))
         (beg (car pos))
         (end (cdr pos))
         (type (cond
                ;; E040: Syntax errors reported by bash -n
                ((string= code "E040") :error)
                ;; The other errors are actually warnings (code style)
                (t :warning)))
         (msg (format "%s: %s" code text)))
    (list fmqd-source beg end type msg)))

;;;###autoload
(defun flymake-bashate-load ()
  "Enable Flymake and flymake-bashate."
  (add-hook 'flymake-diagnostic-functions 'flymake-bashate-checker nil t)
  (flymake-mode t))

(provide 'flymake-bashate)
;;; flymake-bashate.el ends here
