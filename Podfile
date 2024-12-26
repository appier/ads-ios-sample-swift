# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

$UsingCocoaPodsAppierFramework = ENV["APPIER_FRAMEWORK_SOURCE_COCOAPODS"] == "YES"

use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

target 'AppierAdsSwiftSample' do
  # Comment the next line if you don't want to use dynamic frameworks
  if $UsingCocoaPodsAppierFramework
    pod 'AppierAds'
  end
  pod 'AppLovinSDK'
end
