# <img src="https://cdn.jsdelivr.net/gh/swissgrc/chocolatey-packages@26c57c8ca63a4ee86beebc92353aad2f9ec3fe21/automatic/vscode-terraform/vscode-terraform.png" width="48" height="48"/> [vscode-terraform](https://chocolatey.org/packages/vscode-terraform)

The HashiCorp [Terraform Visual Studio Code (VS Code)](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
extension with the [Terraform Language Server](https://github.com/hashicorp/terraform-ls) adds editing features for
[Terraform](https://www.terraform.io/) files such as syntax highlighting, IntelliSense, code navigation, code formatting, module explorer and much more!

## Features

* [IntelliSense](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform#intellisense-and-autocomplete)
  Edit your code with auto-completion of providers, resource names, data sources, attributes and more
* [Syntax validation](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform#syntax-validation)
  Diagnostics using `terraform validate` provide inline error checking
* [Syntax highlighting](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform#syntax-highlighting)
  Highlighting syntax from Terraform 0.12 to 1.X
* [Code Navigation](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform#code-navigation)
  Navigate through your codebase with Go to Definition and Symbol support
* [Code Formatting](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform#code-formatting)
  Format your code with `terraform fmt` automatically
* [Code Snippets](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform#code-snippets)
  Shortcuts for commmon snippets like for_each and variable
* [Terraform Module Explorer](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform#terraform-module-and-provider-explorer)
  View all modules and providers referenced in the currently open document.
* [Terraform commands](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform#terraform-commands)
Directly execute commands like `terraform init` or `terraform plan` from the VS Code Command Palette.

## Notes

* This package requires Visual Studio Code 1.2.0 or newer.
  You can install either the [vscode](https://chocolatey.org/packages/vscode) or [vscode-insiders](https://chocolatey.org/packages/vscode-insiders) package.
* The extension will be installed in any edition of Visual Studio Code which can be found.
* While this package installs a specific version of the extension, Visual Studio Code by default will update the extension to the latest version on startup
  if there's a newer version available on the marketplace.
  See [Extension auto-update](https://code.visualstudio.com/docs/editor/extension-gallery#_extension-autoupdate) for instructions how to disable auto-update.
