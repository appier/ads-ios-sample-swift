import UIKit
import AppLovinSDK

class ALNativeSmallViewController: UIViewController {

    var nativeAdView: UIView!
    var nativeAdLoader: MANativeAdLoader!
    var nativeAd: MAAd!
    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        label = UILabel()
        label.text = "AppLovin Native Ad Small"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])

        nativeAdLoader = MANativeAdLoader(adUnitIdentifier: "6cffe134c717c8ed")
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

extension ALNativeSmallViewController: MANativeAdDelegate {
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
                // change the aspect ratio of the view to 360x120
                nativeAdView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 120.0 / 360.0)
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
