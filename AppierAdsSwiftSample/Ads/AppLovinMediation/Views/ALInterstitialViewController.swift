import UIKit
import AppLovinSDK

class ALInterstitialViewController: UIViewController, MAAdViewAdDelegate {

    private var retryAttempt = 0.0
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

    var interstitialAd: MAInterstitialAd!
    var isLoad: Bool = false

    deinit {
        interstitialAd.delegate = nil
        interstitialAd = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupButton()

        interstitialAd = MAInterstitialAd(adUnitIdentifier: "c644df92dbb2f964")
        interstitialAd.delegate = self

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

    @objc func loadShowInterstitialAd(_ sender: UIButton) {
        if isLoad {
            if interstitialAd.isReady {
                interstitialAd.show()
            } else {
                print("Interstitial Ad is not ready to show")
                step(0)
            }
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
                loadShowButton.backgroundColor = UIColor.systemBlue
            case 1:
                instructionImageView.image = UIImage(named: "illustration_interstitial_step1_art")
                stepsImageView.image = UIImage(named: "illustration_interstitial_step1")
                loadShowButton.isEnabled = false
                loadShowButton.setTitle("Loading...", for: .normal)
                loadShowButton.backgroundColor = UIColor.lightGray
            case 2:
                isLoad = true
                instructionImageView.image = UIImage(named: "illustration_interstitial_step2_art")
                stepsImageView.image = UIImage(named: "illustration_interstitial_step2")
                loadShowButton.setTitle("Show", for: .normal)
                loadShowButton.isEnabled = true
                loadShowButton.backgroundColor = UIColor.systemBlue
            default: break
        }
    }

    // MARK: MAAdDelegate Protocol

    func didLoad(_ ad: MAAd) {
        print(#function)
        print("from:\(ad.networkName)")
        step(2)
        //        if(ad.networkName != "Appier"){
        //            retryAttempt += 1
        //            //let delaySec = pow(2.0, min(6.0, retryAttempt))
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        //                self.interstitialAd.load()
        //            }
        //        }else{
        //            step(2)
        //        }
    }

    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        print(#function + ":" + error.message)
        step(0)
    }

    func didExpand(_ ad: MAAd) {
        print(#function)
    }

    func didCollapse(_ ad: MAAd) {
        print(#function)
    }

    func didDisplay(_ ad: MAAd) {
        print(#function)
        step(0)
    }

    func didHide(_ ad: MAAd) {
        print(#function)
    }

    func didClick(_ ad: MAAd) {
        print(#function)
    }

    func didFail(toDisplay ad: MAAd, withError error: MAError) {
        print(#function + ":" + error.message)
        step(0)
    }
}
