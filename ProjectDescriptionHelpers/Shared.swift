import ProjectDescription

public struct Files {

    public let infoPlist: InfoPlist
    public let sources:  SourceFilesList
    public let resources: ResourceFileElements
    public let headers: Headers
    public let mainHeader: Headers

    public init(
        infoPlist: InfoPlist,
        sources: SourceFilesList,
        resources: ResourceFileElements = [],
        headers: Headers = Headers(),
        mainHeader: Headers = Headers()
    ) {
        self.infoPlist = infoPlist
        self.sources = sources
        self.resources = resources
        self.headers = headers
        self.mainHeader = mainHeader
    }
}

public let appierAdsSwiftSample = Files(
    infoPlist: .file(path: .relativeToCurrentFile("./../AppierAdsSwiftSample/Info.plist")),
    sources: [
        SourceFileGlob(.relativeToCurrentFile("./../AppierAdsSwiftSample/Sources/**/*.swift"))
    ],
    resources: [
        .glob(pattern: .relativeToCurrentFile("./../AppierAdsSwiftSample/Assets/**")),
        .glob(pattern: .relativeToCurrentFile("./../AppierAdsSwiftSample/Layouts/**")),
        .glob(pattern: .relativeToCurrentFile("./../AppierAdsSwiftSample/Base.lproj/LaunchScreen.storyboard"))
    ]
)
