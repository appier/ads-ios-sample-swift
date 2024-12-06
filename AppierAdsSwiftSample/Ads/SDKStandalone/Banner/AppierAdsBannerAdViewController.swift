import UIKit
import AppierAds

class AppierAdsBannerAdViewController: UIViewController {
    var bannerAd300x250: APRBannerAd!
    var bannerAd320x50: APRBannerAd!
    var bannerAd320x480: APRBannerAd!

    var label300x250: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "300 x 250"
        label.textColor = .gray
        return label
    }()

    var banner300x250: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var label320x50: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "320 x 50"
        label.textColor = .gray
        return label
    }()

    var banner320x50: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var label320x480: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "320 x 480"
        label.textColor = .gray
        return label
    }()

    var banner320x480: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let adUnitId = "e7dd194871e34a8cbc4627609fe43c80"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBannerAd()
        setupBannerConstraint()
    }

    func setupBannerAd() {
        var extra = APRAdExtras()
        extra.set(key: .adUnitId, value: adUnitId)
        extra.set(key: .zoneId, value: "5933")

        bannerAd300x250 = APRBannerAd(adUnitId: APRAdUnitId(adUnitId))
        bannerAd300x250.delegate = self
        bannerAd300x250.set(extras: extra)
        bannerAd300x250.load()

        extra = APRAdExtras()
        extra.set(key: .adUnitId, value: adUnitId)
        extra.set(key: .zoneId, value: "6241")

        bannerAd320x50 = APRBannerAd(adUnitId: APRAdUnitId(adUnitId))
        bannerAd320x50.delegate = self
        bannerAd320x50.set(extras: extra)
        bannerAd320x50.load()

        extra = APRAdExtras()
        extra.set(key: .adUnitId, value: adUnitId)
        extra.set(key: .zoneId, value: "6242")

        bannerAd320x480 = APRBannerAd(adUnitId: APRAdUnitId(adUnitId))
        bannerAd320x480.delegate = self
        bannerAd320x480.set(extras: extra)
        bannerAd320x480.load()
    }

    func setupBannerConstraint() {
        view.addSubview(label300x250)
        view.addSubview(banner300x250)
        view.addSubview(label320x50)
        view.addSubview(banner320x50)
        view.addSubview(label320x480)
        view.addSubview(banner320x480)

        NSLayoutConstraint.activate([
            label300x250.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label300x250.leadingAnchor.constraint(equalTo: banner300x250.leadingAnchor),

            banner300x250.topAnchor.constraint(equalTo: label300x250.bottomAnchor, constant: 8),
            banner300x250.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            banner300x250.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            banner300x250.heightAnchor.constraint(equalTo: banner300x250.widthAnchor, multiplier: 250.0 / 300.0),

            label320x50.topAnchor.constraint(equalTo: banner300x250.bottomAnchor, constant: 20),
            label320x50.leadingAnchor.constraint(equalTo: banner320x50.leadingAnchor),

            banner320x50.topAnchor.constraint(equalTo: label320x50.bottomAnchor, constant: 8),
            banner320x50.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            banner320x50.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            banner320x50.heightAnchor.constraint(equalTo: banner320x50.widthAnchor, multiplier: 50.0 / 320.0),

            label320x480.topAnchor.constraint(equalTo: banner320x50.bottomAnchor, constant: 20),
            label320x480.leadingAnchor.constraint(equalTo: banner320x480.leadingAnchor),

            banner320x480.topAnchor.constraint(equalTo: label320x480.bottomAnchor, constant: 8),
            banner320x480.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            banner320x480.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            banner320x480.heightAnchor.constraint(equalTo: banner320x480.widthAnchor, multiplier: 480.0 / 320.0)
        ])
    }

    func setBannerConstraint(bannerView: UIView, parentView: UIView) {
        parentView.addSubview(bannerView)

        bannerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: parentView.topAnchor),
            bannerView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            bannerView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            bannerView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ])
    }
}

extension AppierAdsBannerAdViewController: APRBannerAdDelegate {
    func onAdNoBid(_ bannerAd: APRBannerAd) {
        print(#function)
    }

    func onAdLoaded(_ bannerAd: AppierAds.APRBannerAd, banner: UIView) {
        print(#function)
        if bannerAd.extras.get(key: .zoneId) as? String == "5933" {
            // 300 x 250
            setBannerConstraint(bannerView: banner, parentView: banner300x250)
        } else if bannerAd.extras.get(key: .zoneId) as? String == "6241" {
            // 320 x 50
            setBannerConstraint(bannerView: banner, parentView: banner320x50)
        } else if bannerAd.extras.get(key: .zoneId) as? String == "6242" {
            // 320 x 480
            setBannerConstraint(bannerView: banner, parentView: banner320x480)
        }
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
