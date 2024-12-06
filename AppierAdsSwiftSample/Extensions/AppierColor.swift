import UIKit
import AppierAds

extension UIColor {
    static let AppierPrimary: UIColor = .init(hex: "#1440E5")
    static let AppierPrimaryDark: UIColor = .init(hex: "#1036C2")
    static let AppierAccent: UIColor = .init(hex: "#FFFFFF")
    static let AppierAdPlaceHolder: UIColor = .init(hex: "#D8D8D8")
    static let AppierTextDefault: UIColor = .init(hex: "#808080")
    static let AppierTextFaded: UIColor = .init(hex: "#E8E8E8")
    static let AppierSponsored: UIColor = .init(hex: "#43A047")
    static let AppierDarkGray: UIColor = .init(hex: "#AAAAAA")

    convenience init(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            self.init()
        } else {
            var rgbValue: UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)
            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
    }
}
