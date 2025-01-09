fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios develop_mode

```sh
[bundle exec] fastlane ios develop_mode
```

Switch cocoapods reference, use_local: Bool

### ios setup_and_build

```sh
[bundle exec] fastlane ios setup_and_build
```

Xcode project setup and build ipa file

### ios generate

```sh
[bundle exec] fastlane ios generate
```



### ios build

```sh
[bundle exec] fastlane ios build
```

Build ipa file

### ios download_public_release

```sh
[bundle exec] fastlane ios download_public_release
```

Download public release from GitHub

### ios install_framework_with_cocoapods

```sh
[bundle exec] fastlane ios install_framework_with_cocoapods
```



### ios clean

```sh
[bundle exec] fastlane ios clean
```



### ios clean_local_framework

```sh
[bundle exec] fastlane ios clean_local_framework
```



### ios upload

```sh
[bundle exec] fastlane ios upload
```

Build and upload to TestFlight

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
