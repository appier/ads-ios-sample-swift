# Appier Ads iOS Swift Sample App

This is a sample app to demonstrate Appier Ads SDK and mediation to different networks.

## How to integrate with SDK

### Clone repositories 
Clone the repositories and place them in the same folder.

```
- appier-ads-ios-development
  - appier-ads-ios
  - appier-ads-ios-sample
  - appier-applovin-ios-mediation
```

![Screenshot 2025-01-08 at 5 05 55 PM](https://github.com/user-attachments/assets/7988cb6d-0bf2-4530-96fd-b030e7f164e0)

### Install fastlane

Don’t install fastlane globally. Instead, in each repository, run the following to install fastlane and the other Gem dependencies locally.

```
bundle config set --local path 'vendor/bundle'
bundle install
```

The code samples below assume an alias to `bundle exec fastlane` is set in the shell profile:

```
alias fastlane='bundle exec fastlane'
```

### Integrate sample app and sdks

Execute the command `fastlane develop_mode use_local:true` under the sample app directory.

Now, **AppierAds** and **AppierAppLovinMediation** refer to local sources via CocoaPods, allowing you to edit the code directly in the pod  .

![Screenshot 2025-01-09 at 3 21 42 PM](https://github.com/user-attachments/assets/b64f3ccf-28f1-4f65-acfe-b33789358cbb)

