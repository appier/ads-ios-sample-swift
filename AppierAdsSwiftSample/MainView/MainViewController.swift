import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let adMobMediationController = createAdController(title: "AdMob Mediation", dataSource: [
            AdDataSource(
                header: .init(title: "Native", image: .init(named: "illustration_native.png")!),
                cells: [
                    .init(title: "basic", ctrCls: AdMobNativeViewController.self)
            ])
        ])

        let sdkStandaloneViewController = createAdController(title: "SDK Standalone", dataSource: [
            AdDataSource(header: .init(title: "Native", image: .init(named: "illustration_native.png")!),
                         cells: [.init(title: "basic", ctrCls: AdMobNativeViewController.self)]),
            AdDataSource(header: .init(title: "banner", image: .init(named: "illustration_banner.png")!),
                         cells: [.init(title: "basic", ctrCls: AppierAdsBannerAdViewController.self)]),
            AdDataSource(header: .init(title: "Interstitial", image: .init(named: "illustration_interstitial.png")!),
                         cells: [.init(title: "basic", ctrCls: AppierAdsInterstitialViewController.self)])
        ])

        self.setViewControllers([sdkStandaloneViewController, adMobMediationController], animated: true)
        self.tabBar.tintColor = .AppierPrimary
        self.tabBar.unselectedItemTintColor = .AppierTextDefault
        self.tabBar.backgroundColor = .AppierTextFaded
    }

    func createAdController(title: String, dataSource: [AdDataSource]) -> UINavigationController {
        let adTableController = AdTableViewController(
            nibName: String(describing: AdTableViewController.self),
            bundle: nil
        )
        adTableController.title = title
        adTableController.dataSource = dataSource

        let navigationController = UINavigationController(rootViewController: adTableController)
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.AppierPrimary]
        navigationController.tabBarItem = createTabBarItem(title: title)

        return navigationController
    }

    func createTabBarItem(title: String) -> UITabBarItem {
        let item = UITabBarItem(title: title, image: nil, selectedImage: nil)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: -15)
        item.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
        return item
    }
}
