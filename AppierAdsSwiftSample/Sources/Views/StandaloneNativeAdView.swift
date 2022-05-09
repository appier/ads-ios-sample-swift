import UIKit
import AppierAds

class StandaloneNativeAdView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var callToActionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var mainImgeView: UIImageView!
    @IBOutlet weak var privacyInformationIconImgeView: UIImageView!
}


extension StandaloneNativeAdView: APRNativeAdRendering {
    var nativeAdTitleLabel: UILabel? {
        return titleLabel
    }

    var nativeAdMainTextLabel: UILabel? {
        return mainTextLabel
    }

    var nativeAdCallToActionLabel: UILabel? {
        return callToActionLabel
    }

    var nativeAdIconImageView: UIImageView? {
        return iconImageView
    }

    var nativeAdMainImageView: UIImageView? {
        return mainImgeView
    }

    var nativeAdPrivacyInformationIconView: UIView? {
        return privacyInformationIconImgeView
    }
    
    func getNativeAdClickableViews() -> [UIView] {
        return [
            titleLabel,
            mainTextLabel,
            callToActionLabel,
            iconImageView,
            mainImgeView,
            privacyInformationIconImgeView,
            self
        ]
    }
}
