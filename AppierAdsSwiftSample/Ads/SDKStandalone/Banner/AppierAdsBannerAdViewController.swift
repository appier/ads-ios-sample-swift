import UIKit
import AppierAds

class AppierAdsBannerAdViewController: UIViewController {
    var bannerAd: APRBannerAd!
    var banner: UIView!

    let adUnitId = "e7dd194871e34a8cbc4627609fe43c80"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBannerAd()
    }

    func setupBannerAd() {
        let extra = APRAdExtras()
        extra.set(key: .adUnitId, value: adUnitId)
        extra.set(key: .zoneId, value: "5933")

        bannerAd = APRBannerAd(adUnitId: APRAdUnitId(adUnitId))
        bannerAd.delegate = self
        bannerAd.set(extras: extra)
        bannerAd.load()
    }

    func setupBannerConstraint() {
        view.addSubview(banner)
        banner.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            banner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            banner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            banner.heightAnchor.constraint(equalTo: banner.widthAnchor, multiplier: 50 / 320.0)
        ])
    }
}

extension AppierAdsBannerAdViewController: APRBannerAdDelegate {
    func onAdNoBid(_ bannerAd: APRBannerAd) {
        print(#function)
    }

    func onAdLoaded(_ bannerAd: AppierAds.APRBannerAd, banner: UIView) {
        print(#function)
        self.banner = banner
        setupBannerConstraint()
    }
    
    func onAdLoadedFailed(_ bannerAd: AppierAds.APRBannerAd, error: AppierAds.APRError) {
        print(#function)
    }
    
    func onAdImpressionRecorded(_ bannerAd: AppierAds.APRBannerAd) {
        print(#function)
    }
    
    func onAdImpressionRecordedFailed(_ bannerAd: AppierAds.APRBannerAd, error: AppierAds.APRError) {
        print(#function)
    }
    
    func onAdClickedRecorded(_ bannerAd: AppierAds.APRBannerAd) {
        print(#function)
    }
    
    func onAdClickedRecordedFailed(_ bannerAd: AppierAds.APRBannerAd, error: AppierAds.APRError) {
        print(#function)
    }
}
