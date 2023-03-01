[![Build](https://img.shields.io/github/actions/workflow/status/swissgrc/chocolatey-packages/update.yml?branch=main&style=flat-square)](https://github.com/swissgrc/chocolatey-packages/actions/workflows/update.yml)
[Update status](https://gist.github.com/swissgrc-bot/bcac0ec9e5582d0c4c76777c9effcddb)
[![](http://transparent-favicon.info/favicon.ico)](#)
[chocolatey/swissgrc](https://chocolatey.org/profiles/swissgrc)

This repository contains [automatic Chocolatey packages](https://chocolatey.org/docs/automatic-packages).
The repository is setup so that it is possible to manage packages entirely from the GitHub web interface (using GitHub Actions to update and push packages) and/or using the local repository copy.

## Prerequisites

To run locally you will need:

* Powershell 5+.
* [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au): `Install-Module au` or `choco install au`.

## Create a package

To create a new package see [Creating the package updater script](https://github.com/majkinetor/au#creating-the-package-updater-script).

## Testing the package

In a package directory run: `Test-Package`. This function can be used to start testing in [chocolatey-test-environment](https://github.com/majkinetor/chocolatey-test-environment) via `Vagrant` parameter or it can test packages locally.

## Automatic package update

### Single package

Run from within the directory of the package to update that package:

```powershell
cd <package_dir>
./update.ps1
```

If this script is missing, the package is not automatic.
Set `$au_Force = $true` prior to script call to update the package even if no new version is found.

### Multiple packages

To update all packages run `./update_all.ps1`. It accepts few options:

```powershell
./update_all.ps1 -Name a*                                           # Update all packages which name start with letter 'a'
./update_all.ps1 -ForcedPackages 'cpu-z copyq'                      # Update all packages and force cpu-z and copyq
./update_all.ps1 -ForcedPackages 'copyq:1.2.3'                      # Update all packages but force copyq with explicit version
./update_all.ps1 -ForcedPackages 'libreoffice-streams\fresh:6.1.0]' # Update all packages but force libreoffice-streams package to update stream `fresh` with explicit version `6.1.0`.
./update_all.ps1 -Root 'c:\packages'                                # Update all packages in the c:\packages folder
```

The following global variables influence the execution of `update_all.ps1` script if set prior to the call:

```powershell
$au_NoPlugins = $true        # Do not execute plugins
$au_Push      = $false       # Do not push to chocolatey.org
```

You can also call AU method `Update-AUPackages` (alias `updateall`) on its own in the repository root. This will just run the updater for the each package without any other option from `update_all.ps1` script. For example to force update of all packages with a single command execute:

```powershell
updateall -Options ([ordered]@{ Force = $true })
```

## Testing all packages

You can force the update of all or subset of packages to see how they behave when complete update procedure is done:

```powershell
./test_all.ps1                            # Test force update on all packages
./test_all.ps1 'cdrtfe','freecad', 'p*'   # Test force update on only given packages
./test_all.ps1 'random 3'                 # Split packages in 3 groups and randomly select and test 1 of those each time
```

**Note**: If you run this locally your packages will get updated. Use `git reset --hard` after running this to revert the changes.

## Pushing to community repository with GitHub Action

It is possible to force package update and push using GitHub Action.

### Pushing automatic packages

When manually running [Update Action](https://github.com/swissgrc/chocolatey-packages/actions/workflows/update.yml) it is
possible to pass list of packages for which update should be forced.
To see how versions behave when package update is forced see the [force documentation](https://github.com/majkinetor/au/blob/master/README.md#force-update).

### Pushing manual packages

When manually running [Run Command Action](https://github.com/swissgrc/chocolatey-packages/actions/workflows/run-command.yml) it is
possible to pass list of manual packages which should be pushed.

## Pushing to community repository via commit message

You can force package update and push using Git commit message.

This can either be done by setting commit message when merging a PR,
or by manually creating and pushing an empty commit using the `--allow-empty`
Git parameter:

```powershell
git commit -m '[AU copyq less:2.0]' --allow-empty
git push
```

### Pushing automatic packages

A GitHub Action is set up to pass arguments from the commit message to the `./update_all.ps1` script.

If commit message includes `[AU <forced_packages>]` message on the first line, the `forced_packages` string will be sent to the updater.

Examples:

* `[AU pkg1 pkg2]`
Force update ONLY packages `pkg1` and `pkg2`.
* `[AU pkg1:ver1 pkg2 non_existent]`
Force `pkg1` and use explicit version `ver1`, force `pkg2` and ignore `non_existent`.

To see how versions behave when package update is forced see the [force documentation](https://github.com/majkinetor/au/blob/master/README.md#force-update).

### Pushing manual packages

You can also push manual packages with command `[PUSH pkg1 ... pkgN]`.
This works for any package anywhere in the file hierarchy and will not invoke AU updater at all.
