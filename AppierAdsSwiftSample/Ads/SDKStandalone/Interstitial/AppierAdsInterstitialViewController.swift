import UIKit
import AppierAds

final class AppierAdsInterstitialViewController: UIViewController {
    var interstitialAd: APRInterstitialAd!

    let adUnitId = ""

    private lazy var showButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show ad", for: .normal)
        button.addTarget(self, action: #selector(showInterstitialAd(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButton()
        setupInterstitialAd()
    }

    private func setupButton() {
        view.addSubview(showButton)

        NSLayoutConstraint.activate([
            showButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func setupInterstitialAd() {
        let extra = APRAdExtras()
        extra.set(key: .adUnitId, value: adUnitId)
        extra.set(key: .zoneId, value: "6242")

        interstitialAd = APRInterstitialAd(adUnitId: APRAdUnitId(adUnitId))
        interstitialAd.delegate = self
        interstitialAd.set(extras: extra)
        interstitialAd.load()
    }

    @objc func showInterstitialAd(_ sender: UIButton) {
        interstitialAd.show()
    }
}

extension AppierAdsInterstitialViewController: APRInterstitialAdDelegate {
    func onAdNoBid(_ interstitialAd: AppierAds.APRInterstitialAd) {
        print(#function)
    }
    
    func onAdLoaded(_ interstitialAd: AppierAds.APRInterstitialAd) {
        print(#function)
    }
    
    func onAdLoadedFailed(_ interstitialAd: AppierAds.APRInterstitialAd, error: AppierAds.APRError) {
        print(#function)
    }
    
    func onAdImpressionRecorded(_ interstitialAd: AppierAds.APRInterstitialAd) {
        print(#function)
    }
    
    func onAdImpressionFailed(_ interstitialAd: AppierAds.APRInterstitialAd) {
        print(#function)
    }
    
    func onAdClickedRecorded(_ interstitialAd: AppierAds.APRInterstitialAd) {
        print(#function)
    }
}
