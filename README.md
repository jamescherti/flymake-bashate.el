# flymake-bashate.el - A Flymake backend for bashate
![Build Status](https://github.com/jamescherti/flymake-bashate.el/actions/workflows/ci.yml/badge.svg)
[![MELPA](https://melpa.org/packages/flymake-bashate-badge.svg)](https://melpa.org/#/flymake-bashate)
[![MELPA Stable](https://stable.melpa.org/packages/flymake-bashate-badge.svg)](https://stable.melpa.org/#/flymake-bashate)
![License](https://img.shields.io/github/license/jamescherti/flymake-bashate.el)
![](https://jamescherti.com/misc/made-for-gnu-emacs.svg)

The `flymake-bashate` Emacs package provides a Flymake backend for `bashate`, enabling real-time style checking for Bash shell scripts within Emacs.

*(This package can also work with Flycheck: simply use the flymake-flycheck package, which allows any Emacs Flymake backend to function as a Flycheck checker.)*

If this enhances your workflow, please show your support by **⭐ starring flymake-bashate.el on GitHub** to help more Emacs users discover its benefits.

## Installation

To install `flymake-bashate` from MELPA:

1. If you haven't already done so, [add MELPA repository to your Emacs configuration](https://melpa.org/#/getting-started).

2. Add the following code to your Emacs init file to install `flymake-bashate` from MELPA:
```emacs-lisp
(use-package flymake-bashate
  :ensure t
  :commands flymake-bashate-setup
  :hook (((bash-ts-mode sh-mode) . flymake-bashate-setup)
         ((bash-ts-mode sh-mode) . flymake-mode))
  :custom
  (flymake-bashate-max-line-length 80))
```

## Customizations

### Ignoring Bashate errors

To make `bashate` ignore specific Bashate rules, such as E003 (ensure all indents are a multiple of 4 spaces) and E006 (check for lines longer than 79 columns), set the following variable:
```emacs-lisp
(setq flymake-bashate-ignore "E003,E006")
```

(This corresponds to the `-i` or `--ignore` option in Bashate.)

### Setting maximum line length

To define the maximum line length for Bashate to check:

```emacs-lisp
(setq flymake-bashate-max-line-length 80)
```

(This corresponds to the `--max-line-length` option in Bashate.)

### Specifying the Bashate executable

To change the path or filename of the Bashate executable:

```emacs-lisp
(setq flymake-bashate-executable "/opt/different-directory/bin/bashate")
```

(Defaults to "bashate".)

## License

Copyright (C) 2024-2025 [James Cherti](https://www.jamescherti.com)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.

## Links

- [flymake-bashate.el @GitHub](https://github.com/jamescherti/flymake-bashate.el)
- [flymake-bashate.el @MELPA](https://melpa.org/#/flymake-bashate)
- [Bashate @GitHub](https://github.com/openstack/bashate)

Other Emacs packages by the same author:
- [minimal-emacs.d](https://github.com/jamescherti/minimal-emacs.d): This repository hosts a minimal Emacs configuration designed to serve as a foundation for your vanilla Emacs setup and provide a solid base for an enhanced Emacs experience.
- [compile-angel.el](https://github.com/jamescherti/compile-angel.el): **Speed up Emacs!** This package guarantees that all .el files are both byte-compiled and native-compiled, which significantly speeds up Emacs.
- [outline-indent.el](https://github.com/jamescherti/outline-indent.el): An Emacs package that provides a minor mode that enables code folding and outlining based on indentation levels for various indentation-based text files, such as YAML, Python, and other indented text files.
- [easysession.el](https://github.com/jamescherti/easysession.el): Easysession is lightweight Emacs session manager that can persist and restore file editing buffers, indirect buffers/clones, Dired buffers, the tab-bar, and the Emacs frames (with or without the Emacs frames size, width, and height).
- [vim-tab-bar.el](https://github.com/jamescherti/vim-tab-bar.el): Make the Emacs tab-bar Look Like Vim’s Tab Bar.
- [elispcomp](https://github.com/jamescherti/elispcomp): A command line tool that allows compiling Elisp code directly from the terminal or from a shell script. It facilitates the generation of optimized .elc (byte-compiled) and .eln (native-compiled) files.
- [tomorrow-night-deepblue-theme.el](https://github.com/jamescherti/tomorrow-night-deepblue-theme.el): The Tomorrow Night Deepblue Emacs theme is a beautiful deep blue variant of the Tomorrow Night theme, which is renowned for its elegant color palette that is pleasing to the eyes. It features a deep blue background color that creates a calming atmosphere. The theme is also a great choice for those who miss the blue themes that were trendy a few years ago.
- [Ultyas](https://github.com/jamescherti/ultyas/): A command-line tool designed to simplify the process of converting code snippets from UltiSnips to YASnippet format.
- [flymake-ansible-lint.el](https://github.com/jamescherti/flymake-ansible-lint.el): An Emacs package that offers a Flymake backend for ansible-lint.
- [inhibit-mouse.el](https://github.com/jamescherti/inhibit-mouse.el): A package that disables mouse input in Emacs, offering a simpler and faster alternative to the disable-mouse package.
- [quick-sdcv.el](https://github.com/jamescherti/quick-sdcv.el): This package enables Emacs to function as an offline dictionary by using the sdcv command-line tool directly within Emacs.
- [enhanced-evil-paredit.el](https://github.com/jamescherti/enhanced-evil-paredit.el): An Emacs package that prevents parenthesis imbalance when using *evil-mode* with *paredit*. It intercepts *evil-mode* commands such as delete, change, and paste, blocking their execution if they would break the parenthetical structure.
- [stripspace.el](https://github.com/jamescherti/stripspace.el): Ensure Emacs Automatically removes trailing whitespace before saving a buffer, with an option to preserve the cursor column.
- [persist-text-scale.el](https://github.com/jamescherti/persist-text-scale.el): Ensure that all adjustments made with text-scale-increase and text-scale-decrease are persisted and restored across sessions.
- [pathaction.el](https://github.com/jamescherti/pathaction.el): Execute the pathaction command-line tool from Emacs. The pathaction command-line tool enables the execution of specific commands on targeted files or directories. Its key advantage lies in its flexibility, allowing users to handle various types of files simply by passing the file or directory as an argument to the pathaction tool. The tool uses a .pathaction.yaml rule-set file to determine which command to execute. Additionally, Jinja2 templating can be employed in the rule-set file to further customize the commands.
