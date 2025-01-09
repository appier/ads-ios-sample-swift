import UIKit
import AppLovinSDK
import Foundation

class ALNativeManualViewController: UIViewController {

    private var nativeAdView: MANativeAdView!
    var nativeAdLoader: MANativeAdLoader!
    var nativeAd: MAAd!
    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        label = UILabel()
        label.text = "AppLovin Native Ad Manual"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])

        let nativeAdViewNib = UINib(nibName: "ALNativeManualAdView", bundle: Bundle.main)
        nativeAdView = nativeAdViewNib.instantiate(withOwner: nil, options: nil).first! as? MANativeAdView

        let adViewBinder = MANativeAdViewBinder(builderBlock: { builder in
            builder.titleLabelTag = 1001
            //            builder.advertiserLabelTag = 1002
            builder.bodyLabelTag = 1003
            builder.iconImageViewTag = 1004
            builder.optionsContentViewTag = 1005
            builder.mediaContentViewTag = 1006
            builder.callToActionButtonTag = 1007
            //            builder.starRatingContentViewTag = 1008
        })
        nativeAdView.bindViews(with: adViewBinder)

        nativeAdLoader = MANativeAdLoader(adUnitIdentifier: "a8a784cef0c37783")
        nativeAdLoader.nativeAdDelegate = self
        nativeAdLoader.loadAd(into: nativeAdView)
    }

    deinit {
        if let currentNativeAd = nativeAd {
            nativeAdLoader.destroy(currentNativeAd)
        }

        if let currentNativeAdView = nativeAdView {
            currentNativeAdView.removeFromSuperview()
        }

        nativeAdLoader.nativeAdDelegate = nil
    }
}

extension ALNativeManualViewController: MANativeAdDelegate {
    func didLoadNativeAd(_ maxNativeAdView: MANativeAdView?, for ad: MAAd) {
        print(#function)

        // Save ad for clean up
        nativeAd = ad

        if let adView = maxNativeAdView {
            // Add ad view to view
            nativeAdView = adView
            view.addSubview(adView)
            adView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                adView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
                adView.leftAnchor.constraint(equalTo: view.leftAnchor),
                adView.rightAnchor.constraint(equalTo: view.rightAnchor),
                adView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 250.0 / 300.0)
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
