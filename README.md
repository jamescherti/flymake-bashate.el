# flymake-bashate
![Build Status](https://github.com/jamescherti/flymake-bashate.el/actions/workflows/ci.yml/badge.svg)
![License](https://img.shields.io/github/license/jamescherti/flymake-bashate.el)

A Flymake handler for Bash scripts using Bashate

## Installation

### Install using straight

To install the `flymake-bashate` using `straight.el`:

1. If you haven't already done so, [add the straight.el bootstrap code](https://github.com/radian-software/straight.el?tab=readme-ov-file#getting-started) to your init file.

2. Add the following code to your Emacs init file:
```
(use-package flymake-bashate
  :ensure t
  :straight (flymake-bashate
             :type git
             :host github
             :repo "jamescherti/flymake-bashate.el"))
```

## License

Copyright (C) 2024 [James Cherti](https://www.jamescherti.com)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.

## Links

- [flymake-bashate.el @GitHub](https://github.com/jamescherti/flymake-bashate.el)