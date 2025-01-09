import UIKit
import AppLovinSDK

class ALNativeMediumViewController: UIViewController {

    var nativeAdView: UIView!
    var nativeAdLoader: MANativeAdLoader!
    var nativeAd: MAAd!
    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        label = UILabel()
        label.text = "AppLovin Native Ad Medium"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])

        nativeAdLoader = MANativeAdLoader(adUnitIdentifier: "fdaa884a3a0301e3")
        nativeAdLoader.nativeAdDelegate = self
        nativeAdLoader.loadAd()
    }

    deinit {
        if let currentNativeAd = nativeAd {
            nativeAdLoader.destroy(currentNativeAd)
        }

        if let currentNativeAdView = nativeAdView {
            currentNativeAdView.removeFromSuperview()
        }

        nativeAdLoader.nativeAdDelegate = nil
        nativeAdLoader.revenueDelegate = nil
    }
}

extension ALNativeMediumViewController: MANativeAdDelegate {
    func didLoadNativeAd(_ maxNativeAdView: MANativeAdView?, for ad: MAAd) {
        print(#function)

        // Save ad for clean up
        nativeAd = ad

        if let adView = maxNativeAdView {
            // Add ad view to view
            nativeAdView = adView
            view.addSubview(adView)
            adView.translatesAutoresizingMaskIntoConstraints = false

            // Set ad view to span width and height of container and center the ad
            NSLayoutConstraint.activate([
                nativeAdView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
                nativeAdView.leftAnchor.constraint(equalTo: view.leftAnchor),
                nativeAdView.rightAnchor.constraint(equalTo: view.rightAnchor),
                // change the aspect ratio of the view to 300x250
                nativeAdView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 250.0 / 300.0)
            ])
        }
    }

    func didFailToLoadNativeAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        print(#function)
    }

    func didClickNativeAd(_ ad: MAAd) {
        print(#function)
    }
}
