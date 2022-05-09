# Appier Ads iOS Swift Sample App

This is a sample app to demonstrate Appier Ads SDK and mediation to different networks.

## Install Tuist

The Xcode project is automatically generated with [Tuist](https://tuist.io).

Before anything, please [follow the instructions](https://docs.tuist.io/tutorial/get-started) to install Tuist from your terminal.

## Install fastlane

Don’t install fastlane globally. Instead, in each repository, run the following to install fastlane and the other Gem dependencies locally.

```
bundle config set --local path 'vendor/bundle'
bundle install
```

The code samples below assume an alias to `bundle exec fastlane` is set in the shell profile:

```
alias fastlane='bundle exec fastlane'
```

## Generate the Xcode workspace

After install the `Tuist` and `fastlane`, run the following command generate the workspace automatically.

```
fastlane generate
```
