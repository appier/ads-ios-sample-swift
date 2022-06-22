import UIKit
import AppierAds
import GoogleMobileAds
import AppierAdsAdMobMediation

class AdMobNativeViewController: BaseNativeAdViewController {
    var adLoader: GADAdLoader!
    var nativeAdView: GADNativeAdView!

    let adUnitId = "ca-app-pub-9553415307894531/1594080241" // 7906

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let nibObjects = Bundle.main.loadNibNamed(
            String(describing: AdMobMediumNativeAdView.self), owner: nil, options: nil),
              let nativeAdView = nibObjects.first as? GADNativeAdView else {
            assert(false, "Could not load nib file for adView")
        }
        self.nativeAdView = nativeAdView
        nativeAdPlaceholder.addSubview(nativeAdView)
        nativeAdView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nativeAdView.topAnchor.constraint(equalTo: nativeAdPlaceholder.topAnchor),
            nativeAdView.bottomAnchor.constraint(equalTo: nativeAdPlaceholder.bottomAnchor),
            nativeAdView.leftAnchor.constraint(equalTo: nativeAdPlaceholder.leftAnchor),
            nativeAdView.rightAnchor.constraint(equalTo: nativeAdPlaceholder.rightAnchor)
        ])

        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nativeAdPlaceholder.isHidden = true

        /*
         * Initialize AdMob native
         *
         * To enable Appier AdMob Mediation, the AdUnit requires at least one "Custom Event",
         * with the following settings:
         *
         *   "Class Name": "AppierAdsAdMobMediation.APRAdAdapter".
         *   "Parameter":  { "zoneId": "<THE ZONE ID PROVIDED BY APPIER>" }
         *
         */

        // Assign self as `eventDelegate` to receive impression/clicked callback events.
        APRAdMobAdManager.shared.eventDelegate = self

        // Build Request
        adLoader = GADAdLoader(
            adUnitID: adUnitId,
            rootViewController: self,
            adTypes: [.native],
            options: nil)
        adLoader.delegate = self
        let appierExtras = APRAdExtras()
        appierExtras.set(key: .adUnitId, value: adUnitId)
        appierExtras.set(key: .appInfo, value: SampleAppInfo())  // Pass additional information

        // Load Ad
        let request = GADRequest()
        request.register(appierExtras)
        adLoader.load(request)
    }
}

extension AdMobNativeViewController: GADNativeAdLoaderDelegate {
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        APRLogger.controller.debug("\(#function)")
        nativeAd.delegate = self
        nativeAdPlaceholder.isHidden = false

        (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
        nativeAdView.headlineView?.isHidden = nativeAd.headline == nil

        (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
        nativeAdView.bodyView?.isHidden = nativeAd.body == nil

        (nativeAdView.callToActionView as? UILabel)?.text = nativeAd.callToAction
        nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil

        (nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
        nativeAdView.iconView?.isHidden = nativeAd.icon == nil

        // when the advertiser name is `Appier`, the ad is provided by Appier.
        if let advertiser = nativeAd.advertiser,
           let imageView = nativeAdView.advertiserView as? UIImageView,
           let image = nativeAd.extraAssets?[APRAdMobMediation.shared.advertiserIcon] as? UIImage,
           advertiser == APRAdMobMediation.shared.advertiserName {

            // We provide advertiser image for user to get our advertising ploicy.
            imageView.image = image
        } else {
            (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
        }
        nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil

        // get app information through extraAssets.
        if let advertiser = nativeAd.advertiser,
           let appInfo = nativeAd.extraAssets?[APRAdMobMediation.shared.appInfo] as? SampleAppInfo,
           advertiser == APRAdMobMediation.shared.advertiserName {
            APRLogger.controller.debug("uuid: \(appInfo.uuid)")
        }

        (nativeAdView.imageView as? UIImageView)?.image = nativeAd.images?.first?.image

        nativeAdView.callToActionView?.isUserInteractionEnabled = false

        // Associate the native ad view with the native ad object. This is
        // required to make the ad clickable.
        // Note: this should always be done after populating the ad views.
        nativeAdView.nativeAd = nativeAd
    }

    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        APRLogger.controller.debug("\(#function)")
        APRLogger.controller.debug("\(error)")
    }
}

extension AdMobNativeViewController: GADNativeAdDelegate {
    func nativeAdDidRecordImpression(_ nativeAd: GADNativeAd) {
        APRLogger.controller.debug("\(#function)")
    }

    func nativeAdDidRecordClick(_ nativeAd: GADNativeAd) {
        APRLogger.controller.debug("\(#function)")
    }
}

extension AdMobNativeViewController: APRAdMobAdEventDelegate {
    func onNativeAdImpressionRecorded(nativeAd: APRAdMobNativeAd) {
        APRLogger.controller.debug("\(#function)")
        APRLogger.controller.debug("adunit id: \(nativeAd.adUnitId)")
        APRLogger.controller.debug("zone id: \(nativeAd.zoneId)")

        // Get app information which is passed by localExtras.
        if let appInfo = nativeAd.appInfo as? SampleAppInfo {
            APRLogger.controller.debug("uuid: \(appInfo.uuid)")
        }
    }

    func onNativeAdImpressionRecordedFailed(nativeAd: APRAdMobNativeAd, error: APRError) {
        APRLogger.controller.debug("\(#function)")
        APRLogger.controller.debug("adunit id: \(nativeAd.adUnitId)")
        APRLogger.controller.debug("zone id: \(nativeAd.zoneId)")

        // Get app information which is passed by localExtras.
        if let appInfo = nativeAd.appInfo as? SampleAppInfo {
            APRLogger.controller.debug("uuid: \(appInfo.uuid)")
        }
        APRLogger.controller.debug("\(error)")
    }

    func onNativeAdClickedRecorded(nativeAd: APRAdMobNativeAd) {
        APRLogger.controller.debug("\(#function)")
        APRLogger.controller.debug("adunit id: \(nativeAd.adUnitId)")
        APRLogger.controller.debug("zone id: \(nativeAd.zoneId)")

        // Get app information which is passed by localExtras.
        if let appInfo = nativeAd.appInfo as? SampleAppInfo {
            APRLogger.controller.debug("uuid: \(appInfo.uuid)")
        }
    }

    func onNativeAdClickedRecordedFailed(nativeAd: APRAdMobNativeAd, error: APRError) {
        APRLogger.controller.debug("\(#function)")
        APRLogger.controller.debug("adunit id: \(nativeAd.adUnitId)")
        APRLogger.controller.debug("zone id: \(nativeAd.zoneId)")

        // Get app information which is passed by localExtras.
        if let appInfo = nativeAd.appInfo as? SampleAppInfo {
            APRLogger.controller.debug("uuid: \(appInfo.uuid)")
        }
        APRLogger.controller.debug("\(error)")
    }
}
