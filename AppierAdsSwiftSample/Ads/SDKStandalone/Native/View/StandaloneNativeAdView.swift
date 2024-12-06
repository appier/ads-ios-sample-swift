import UIKit
import AppierAds

class StandaloneNativeAdView: UIView {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private var mainTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()

    private var callToActionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .gray
        return label
    }()

    private var adLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AD"
        label.font = .systemFont(ofSize: 10)
        label.textColor = .white
        label.backgroundColor = .systemGreen
        return label
    }()

    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var privacyInformationIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(mainTextLabel)
        addSubview(callToActionLabel)
        addSubview(adLabel)
        addSubview(iconImageView)
        addSubview(mainImageView)
        addSubview(privacyInformationIconImageView)

        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)

        mainTextLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        mainTextLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

        mainImageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

        callToActionLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            iconImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),

            privacyInformationIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            privacyInformationIconImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            privacyInformationIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            privacyInformationIconImageView.heightAnchor.constraint(equalToConstant: 20),
            privacyInformationIconImageView.widthAnchor.constraint(equalTo: privacyInformationIconImageView.heightAnchor),

            mainTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            mainTextLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            mainTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            mainImageView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            mainImageView.topAnchor.constraint(equalTo: mainTextLabel.bottomAnchor, constant: 8),
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            adLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            adLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            callToActionLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 8),
            callToActionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            callToActionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
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
        return mainImageView
    }

    var nativeAdPrivacyInformationIconView: UIView? {
        return privacyInformationIconImageView
    }

    func getNativeAdClickableViews() -> [UIView] {
        return [
            titleLabel,
            mainTextLabel,
            callToActionLabel,
            iconImageView,
            mainImageView,
            privacyInformationIconImageView,
            self
        ]
    }
}
