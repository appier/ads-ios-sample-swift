import UIKit
import AppierAds

final class AppierAdsInterstitialViewController: UIViewController {
    var interstitialAd: APRInterstitialAd!

    let adUnitId = ""

    private lazy var instructionImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "illustration_interstitial_step0_art"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please follow our steps"
        label.textColor = .lightGray
        return label
    }()

    private var stepsImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "illustration_interstitial_step0"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var loadShowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load ad", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loadShowInterstitialAd(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()

    var isLoad: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButton()
        setupInterstitialAd()
        step(0)
    }

    private func setupButton() {
        view.addSubview(instructionImageView)
        view.addSubview(instructionLabel)
        view.addSubview(stepsImageView)
        view.addSubview(loadShowButton)

        NSLayoutConstraint.activate([
            instructionImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            instructionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            instructionImageView.heightAnchor.constraint(equalTo: instructionImageView.widthAnchor, multiplier: 480.0 / 252.0),

            instructionLabel.topAnchor.constraint(equalTo: instructionImageView.bottomAnchor, constant: 20),
            instructionLabel.centerXAnchor.constraint(equalTo: instructionImageView.centerXAnchor),

            stepsImageView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20),
            stepsImageView.centerXAnchor.constraint(equalTo: instructionLabel.centerXAnchor),
            stepsImageView.widthAnchor.constraint(equalToConstant: 100),
            stepsImageView.heightAnchor.constraint(equalTo: stepsImageView.widthAnchor, multiplier: 80.0 / 300.0),

            loadShowButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            loadShowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadShowButton.widthAnchor.constraint(equalToConstant: 100),
            loadShowButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func setupInterstitialAd() {
        let extra = APRAdExtras()
        extra.set(key: .adUnitId, value: adUnitId)
        extra.set(key: .zoneId, value: "6242")

        interstitialAd = APRInterstitialAd(adUnitId: APRAdUnitId(adUnitId))
        interstitialAd.delegate = self
        interstitialAd.set(extras: extra)
    }

    @objc func loadShowInterstitialAd(_ sender: UIButton) {
        if isLoad {
            interstitialAd.show()
        } else {
            interstitialAd.load()
            step(1)
        }
    }

    func step(_ step: Int) {
        switch step {
            case 0:
                isLoad = false
                instructionImageView.image = UIImage(named: "illustration_interstitial_step0_art")
                stepsImageView.image = UIImage(named: "illustration_interstitial_step0")
                loadShowButton.setTitle("Load", for: .normal)
                loadShowButton.isEnabled = true
            case 1:
                instructionImageView.image = UIImage(named: "illustration_interstitial_step1_art")
                stepsImageView.image = UIImage(named: "illustration_interstitial_step1")
                loadShowButton.isEnabled = false
            case 2:
                isLoad = true
                instructionImageView.image = UIImage(named: "illustration_interstitial_step2_art")
                stepsImageView.image = UIImage(named: "illustration_interstitial_step2")
                loadShowButton.setTitle("Show", for: .normal)
                loadShowButton.isEnabled = true
            default: break
        }
    }
}

extension AppierAdsInterstitialViewController: APRInterstitialAdDelegate {
    func onAdNoBid(_ interstitialAd: AppierAds.APRInterstitialAd) {
        print(#function)
    }
    
    func onAdLoaded(_ interstitialAd: AppierAds.APRInterstitialAd) {
        print(#function)
        step(2)
    }
    
    func onAdLoadedFailed(_ interstitialAd: AppierAds.APRInterstitialAd, error: AppierAds.APRError) {
        print(#function)
    }
    
    func onAdShown(_ interstitialAd: AppierAds.APRInterstitialAd) {
        print(#function)
    }

    func onAdShownFailed(_ interstitialAd: AppierAds.APRInterstitialAd) {
        print(#function)
    }

    func onAdDismiss(_ interstitialAd: AppierAds.APRInterstitialAd) {
        print(#function)
    }
    
    func onAdClickedRecorded(_ interstitialAd: AppierAds.APRInterstitialAd) {
        print(#function)
    }
}
