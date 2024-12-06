import Foundation

import UIKit
import AppierAds

class AppierAdNativeAdViewController: BaseNativeAdViewController {
    var adNativeAd: APRNativeAd! // Loader
    var nativeAdView: StandaloneNativeAdView!

    let adUnitId = "6d810d9b09ed44efa4ad87ea3ca81780" // 7906

    override func viewDidLoad() {
        super.viewDidLoad()

        let nativeAdView = StandaloneNativeAdView(frame: .zero)

        self.nativeAdView = nativeAdView
        nativeAdView.backgroundColor = .AppierAdPlaceHolder
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
        let appierExtras = APRAdExtras()
        appierExtras.set(key: .adUnitId, value: adUnitId)
        appierExtras.set(key: .appInfo, value: SampleAppInfo())  // Pass additional information
        appierExtras.set(key: .zoneId, value: "5904")

        adNativeAd = APRNativeAd(adUnitId: APRAdUnitId(adUnitId))
        adNativeAd.delegate = self
        adNativeAd.set(renderer: nativeAdView)
        adNativeAd.set(extras: appierExtras)
        adNativeAd.loadAd()
    }
}

extension AppierAdNativeAdViewController: NativeAdDelegate {
    func onAdLoaded(_ nativeAd: AppierAds.APRNativeAd) {
        print(#function)
        DispatchQueue.main.async {
            nativeAd.render()
        }
    }

    func onAdLoadedFailed(_ nativeAd: AppierAds.APRNativeAd, error: AppierAds.APRError) {
        print(#function)
    }

    func onAdNoBid(_ nativeAd: AppierAds.APRNativeAd) {
        print(#function)
    }

    func onAdShown(_ nativeAd: AppierAds.APRNativeAd) {
        print(#function)
    }

    func onAdImpressionRecorded(_ nativeAd: AppierAds.APRNativeAd) {
        print(#function)
    }

    func onAdImpressionRecordedFailed(_ nativeAd: AppierAds.APRNativeAd, error: AppierAds.APRError) {
        print(#function)
    }

    func onAdClickedRecorded(_ nativeAd: AppierAds.APRNativeAd) {
        print(#function)
    }

    func onAdClickedRecordedFailed(_ nativeAd: AppierAds.APRNativeAd, error: AppierAds.APRError) {
        print(#function)
    }
}

