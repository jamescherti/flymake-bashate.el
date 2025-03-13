;;; flymake-bashate.el --- A Flymake backend for bashate, a Bash scripts style checker -*- lexical-binding: t; -*-

;; Copyright (C) 2024-2025 James Cherti | https://www.jamescherti.com/contact/

;; Author: James Cherti
;; Version: 1.0.2
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
;; The flymake-bashate Emacs package provides a Flymake backend for bashate,
;; enabling real-time style checking for Bash shell scripts within Emacs.
;;
;; (Bashate is a Bash script syntax checker, enforcing a set of style and syntax
;; rules to ensure that your scripts are consistent, clean, and easy to read.)
;;
;; (This package can also work with Flycheck: simply use the `flymake-flycheck`
;; package, which allows any Emacs Flymake backend to function as a Flycheck
;; checker.)*
;;
;; Installation from MELPA:
;; ------------------------
;; (use-package flymake-bashate
;;   :ensure t
;;   :commands flymake-bashate-setup
;;   :hook (((bash-ts-mode sh-mode) . flymake-bashate-setup)
;;          ((bash-ts-mode sh-mode) . flymake-mode))
;;   :custom
;;   (flymake-bashate-max-line-length 80))
;;
;; Customizations:
;; ---------------
;; To make bashate ignore specific Bashate rules, such as E003 (ensure all
;; indents are a multiple of 4 spaces) and E006 (check for lines longer than 79
;; columns), set the following variable:
;;   (setq flymake-bashate-ignore "E003,E006")
;;
;; To define the maximum line length for Bashate to check:
;;   (setq flymake-bashate-max-line-length 80)
;;
;; To change the path or filename of the Bashate executable:
;;   (setq flymake-bashate-executable "/opt/different-directory/bin/bashate")
;;
;; Links:
;; ------
;; - flymake-bashate.el @GitHub:
;;   https://github.com/jamescherti/flymake-bashate.el

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

(defcustom flymake-bashate-ignore nil
  "The Bashate rules to ignore.
For example, to ignore rules E003 and E006, set this to: \"E003,E006\".
This corresponds to the `-i` or `--ignore` option in Bashate."
  :type '(choice (const :tag "None" nil)
                 (string :tag "Rules to ignore"))
  :group 'flymake-bashate)

(defcustom flymake-bashate-max-line-length nil
  "The maximum line length in characters. Must be a positive integer.
This corresponds to the `--max-line-length` option in Bashate."
  :type 'integer
  :group 'flymake-bashate)

(defcustom flymake-bashate-executable "bashate"
  "Path to the Bashate executable.
If not specified with a full path (e.g., bashate), `flymake-bashate-backend'
will search for the executable in the directories listed in the $PATH
environment variable."
  :type 'string
  :group 'flymake-bashate)

(flymake-quickdef-backend flymake-bashate-backend
  :pre-let ((bashate-exec (executable-find flymake-bashate-executable)))
  :pre-check (progn
               (unless bashate-exec
                 (error "The '%s' executable was not found" bashate-exec))
               (unless (numberp flymake-bashate-max-line-length)
                 (error
                  "The `flymake-bashate-max-line-length' must be a number")))
  :write-type 'file
  :proc-form `(,bashate-exec
               ,@(when flymake-bashate-ignore
                   `("--ignore" ,flymake-bashate-ignore))
               ,@(when (and flymake-bashate-max-line-length
                            (numberp flymake-bashate-max-line-length))
                   `("--max-line-length"
                     ,(number-to-string flymake-bashate-max-line-length)))
               ,fmqd-temp-file)
  :search-regexp (rx bol
                     (zero-or-more any)
                     (literal (file-name-nondirectory fmqd-temp-file)) ":"
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
                ;; All other errors are warnings related to code style
                (t :warning)))
         (msg (format "%s: %s" code text)))
    (list fmqd-source beg end type msg)))

;;;###autoload
(defun flymake-bashate-setup ()
  "Set up Flymake for Bashate linting in the current buffer.
This function adds `flymake-bashate-backend' to the list of Flymake diagnostic
functions, enabling Bashate style checks locally for the current buffer."
  (add-hook 'flymake-diagnostic-functions #'flymake-bashate-backend nil t))

(provide 'flymake-bashate)
;;; flymake-bashate.el ends here
