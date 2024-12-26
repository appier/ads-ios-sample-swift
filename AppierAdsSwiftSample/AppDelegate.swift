import UIKit
import AppierAds
import AppLovinSDK
//import GoogleMobileAds
import AppTrackingTransparency

let keyAPRAdsTestMode = "APRAds_testMode"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        initAppierAds()
        
        initAppLovinSDK();
        
        //        GADMobileAds.sharedInstance().start { status in
        //            let adapterStatuses = status.adapterStatusesByClassName
        //            for (adapter, _) in adapterStatuses {
        //                APRLogger.delegate.debug("Adapter Name: \(adapter)")
        //            }
        //        }
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = MainViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
    
    private func initAppierAds() {
        // (Optional) Enable test mode for Ad response
        let testMode = UserDefaults.standard.object(forKey: keyAPRAdsTestMode) as? NSNumber
        APRAds.shared.configuration.testMode = (1 == testMode) ? .bid : .none
        
        // (Optional) Set GDPR explicitly
        APRAds.shared.configuration.gdprApplies = true
        
        // (Optional) Set COPPA explicitly to follow the regulations
        APRAds.shared.configuration.coppaApplies = true
        
        // (Optional) Set browser agent explicitly
        APRAds.shared.configuration.browserAgent = .native
        
        // Initialize Appier Ads SDK
        APRAds.shared.start { completion in
            APRLogger.delegate.info("complete to initialize Appier Ads SDK: \(completion)")
        }
    }
    
    private func initAppLovinSDK(){
        let YOUR_SDK_KEY = "5PRz32n_vi41LTITQC4JcXSXUSnkUMxWXVotDbWPTGCDKPuN3zSU7JCa17XDiSJ6RacLhIVyG5JU25SMz_hyOW"
        
        // Create the initialization configuration
        let initConfig = ALSdkInitializationConfiguration(sdkKey: YOUR_SDK_KEY) { builder in
            builder.mediationProvider = "Appier"
        }
        
        // Initialize the SDK with the configuration
        ALSdk.shared().initialize(with: initConfig) { sdkConfig in
            // AppLovin SDK is initialized, start loading ads now or later if ad gate is reached
            APRLogger.delegate.debug("AppLovin SDK initiailzed")
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { _ in }
        }
    }
}
