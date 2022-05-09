import ProjectDescription
import AppierAdsSample

let lintAction = TargetAction.post(path: .relativeToCurrentFile("./../scripts/lint.sh"), name: "SwiftLint")

let project = Project(
    name: "AppierAdsSwiftSample",
    organizationName: "Appier Inc.",
    packages: [],
    targets: [
        Target(
            name: "AppierAdsSwiftSample",
            platform: .iOS,
            product: .app,
            bundleId: "com.appier.AppierAdsSwiftSample",
            deploymentTarget: .iOS(targetVersion: "12.0", devices: [.iphone, .ipad]),
            infoPlist: appierAdsSwiftSample.infoPlist,
            sources: appierAdsSwiftSample.sources,
            resources: appierAdsSwiftSample.resources,
            actions: [lintAction]
        )
    ],
    schemes: [
        Scheme(
            name: "AppierAdsSwiftSample",
            buildAction: BuildAction(targets: ["AppierAdsSwiftSample"]),
            runAction: RunAction(
                executable: "AppierAdsSwiftSample",
                arguments: Arguments(environment: ["APRDebug": "YES"])
            )
        )
    ]
)
