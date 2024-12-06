import UIKit
import AppierAds
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

    func applicationDidBecomeActive(_ application: UIApplication) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { _ in }
        }
    }
}
