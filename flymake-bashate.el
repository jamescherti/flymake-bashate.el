;;; flymake-bashate.el --- A flymake handler for Bash scripts using Bashate  -*- lexical-binding: t; -*-

;; Copyright (C) 2024 James Cherti | https://www.jamescherti.com/contact/

;; Author: James Cherti
;; Version: 0.9.9
;; URL: https://github.com/jamescherti/flymake-bashate.el
;; Keywords: tools
;; Package-Requires: ((flymake-quickdef "1.0.0") (emacs "24.1"))
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
;; A flymake handler for Bash script using Bashate

;;; Code:

(require 'flymake-quickdef)

(defgroup flymake-bashate nil
  "Non-nil if flymake-bashate mode mode is enabled."
  :group 'flymake-bashate
  :prefix "flymake-bashate-"
  :link '(url-link
          :tag "Github"
          "https://github.com/jamescherti/flymake-bashate.el"))


(provide 'flymake-bashate)
;;; flymake-bashate.el ends here
