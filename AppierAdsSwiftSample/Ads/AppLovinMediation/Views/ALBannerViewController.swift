import UIKit
import AppLovinSDK

class ALBannerViewController: UIViewController, MAAdViewAdDelegate {
    
    // labels
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
    
    // views
    var banner320x50: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var label320x480: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "320 x 480 (Not supported)"
        label.textColor = .gray
        return label
    }()
    
    var banner320x480: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var adView: MAAdView!
    var mrecView: MAAdView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        adView = MAAdView(adUnitIdentifier: "6ca36e7bc4dccac0")
        adView.delegate = self
        adView.translatesAutoresizingMaskIntoConstraints = false
        adView.loadAd()
        
        mrecView = MAAdView(adUnitIdentifier: "1aeb3ceff6dab148", adFormat: MAAdFormat.mrec)
        mrecView.delegate = self
        mrecView.translatesAutoresizingMaskIntoConstraints = false
        mrecView.loadAd()
        
        setupBannerConstraint()
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
    
    deinit {
        adView.removeFromSuperview()
        adView.delegate = nil
        adView = nil
        
        mrecView.removeFromSuperview()
        mrecView.delegate = nil
        mrecView = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: MAAdDelegate Protocol
    
    func didExpand(_ ad: MAAd) {
        print(#function)
    }
    
    func didCollapse(_ ad: MAAd) {
        print(#function)
    }
    
    func didLoad(_ ad: MAAd) {
        print(#function + ", network:\(ad.networkName), placementId:\(ad.networkPlacement)")
        
        // Banner 320*50
        if(ad.format == MAAdFormat.banner){
            setBannerConstraint(bannerView: adView, parentView: banner320x50)
            if(ad.networkName == "Appier"){
                adView.stopAutoRefresh()
            }
        }
        
        // MREC 300*250
        if(ad.format == MAAdFormat.mrec){
            setBannerConstraint(bannerView: mrecView, parentView: banner300x250)
            if(ad.networkName == "Appier"){
                mrecView.stopAutoRefresh()
            }
        }
    }
    
    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        print(#function + ":\(error.message)")
    }
    
    func didDisplay(_ ad: MAAd) {
        print(#function)
    }
    
    func didHide(_ ad: MAAd) {
        print(#function)
    }
    
    func didClick(_ ad: MAAd) {
        print(#function)
    }
    
    func didFail(toDisplay ad: MAAd, withError error: MAError) {
        print(#function + ":\(error.message)")
    }
}

