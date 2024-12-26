#import "AppierMediationAdapter.h"
#import <AppierAds/AppierAds-Swift.h>

#define ADAPTER_VERSION @"0.0.1"

@interface APRInterstitialAdDelegate: NSObject<APRInterstitialAdDelegate>
@property (nonatomic, weak) AppierMediationAdapter *parentAdapter;
@property (nonatomic, strong) id<MAInterstitialAdapterDelegate> delegate;
- (instancetype)initWithParentAdapter:(AppierMediationAdapter *)parentAdapter andNotify:(id<MAInterstitialAdapterDelegate>)delegate;

@end

@interface APRAdViewDelegate: NSObject <APRBannerAdDelegate>
@property (nonatomic, weak) MAAdFormat *format;
@property (nonatomic, weak) AppierMediationAdapter *parentAdapter;
@property (nonatomic, strong) id<MAAdViewAdapterDelegate> delegate;
- (instancetype)initWithParentAdapter:(AppierMediationAdapter *)parentAdapter
                               format:(MAAdFormat *)format
                            andNotify:(id<MAAdViewAdapterDelegate>)delegate;
@end

@interface APRNativeAdDelegate : NSObject <NativeAdDelegate>
@property (nonatomic,  weak) AppierMediationAdapter *parentAdapter;
@property (nonatomic, strong) id<MANativeAdAdapterDelegate> delegate;
@property (nonatomic, strong) NSDictionary<NSString *, id> *serverParameters;
- (instancetype)initWithParentAdapter:(AppierMediationAdapter *)parentAdapter
                            andNotify:(id<MANativeAdAdapterDelegate>)delegate;
@end

@interface MAAppierNativeAd : MANativeAd
@property (nonatomic, weak) AppierMediationAdapter *parentAdapter;
- (instancetype)initWithParentAdapter:(AppierMediationAdapter *)parentAdapter builderBlock:(NS_NOESCAPE MANativeAdBuilderBlock)builderBlock;
- (instancetype)initWithFormat:(MAAdFormat *)format builderBlock:(NS_NOESCAPE MANativeAdBuilderBlock)builderBlock NS_UNAVAILABLE;
@end

@interface AppierMediationAdapter ()

@property (nonatomic, strong) APRInterstitialAd *aprInterstitialAd;
@property (nonatomic, strong) APRNativeAd *aprNativeAd;
@property (nonatomic, strong) APRBannerAd *aprBannerAd;

@property (nonatomic, strong) APRInterstitialAdDelegate *interstitialAdDelegate;
@property (nonatomic, strong) APRAdViewDelegate *adViewDelegate;
@property (nonatomic, strong) APRNativeAdDelegate *nativeAdViewDelegate;

@end

@implementation AppierMediationAdapter

static APRLogger *aprLogger;

#pragma mark - Class Initialization
+ (void)initialize{
    [super initialize];
    aprLogger = [[APRLogger alloc] initWithCategory:@"ALMediationAdapter"];
}

#pragma mark - MAdatper Methods

- (void)destroy {
    self.aprInterstitialAd.delegate = nil;
    self.aprInterstitialAd = nil;
    self.interstitialAdDelegate.delegate = nil;
    self.interstitialAdDelegate = nil;
    
    self.aprNativeAd.delegate = nil;
    self.aprNativeAd = nil;
    self.nativeAdViewDelegate.delegate = nil;
    self.nativeAdViewDelegate = nil;
    
    self.aprBannerAd.delegate = nil;
    self.aprBannerAd = nil;
    self.adViewDelegate.delegate = nil;
    self.adViewDelegate = nil;
    
    aprLogger = nil;
}

- (NSString *)SDKVersion
{
    return [NSString stringWithFormat:@"%ld", (long)[APRAds version]];
}

- (NSString *)adapterVersion
{
    return ADAPTER_VERSION;
}

- (void)initializeWithParameters:(id<MAAdapterInitializationParameters>)parameters completionHandler:(void (^)(MAAdapterInitializationStatus, NSString *_Nullable))completionHandler {
    [aprLogger debugLog:@"initializeWithParameters"];
    
    // TEST ONLY
    [APRAds shared].configuration.testMode = APRTestModeBid;
    [[APRAds shared] startWithCompletion:^(BOOL success) {
        if(success){
            [aprLogger debugLog:@"APRAds SDK initialized successfully"];
            completionHandler(MAAdapterInitializationStatusInitializedSuccess, nil);
        } else {
            [aprLogger debugLog:@"Failed to initialize APRAds SDK"];
            completionHandler(MAAdapterInitializationStatusInitializedFailure, @"Failed to initialize APRAds SDK");
        }
    }];
}

#pragma mark - MAInterstitialAdapter Methods

- (void)loadInterstitialAdForParameters:(nonnull id<MAAdapterResponseParameters>)parameters andNotify:(nonnull id<MAInterstitialAdapterDelegate>)delegate {
    NSString *placementId = parameters.thirdPartyAdPlacementIdentifier;
    NSString *adUnitId = parameters.adUnitIdentifier;
    [aprLogger debugLog:[NSString stringWithFormat:@"Load Interstitial Ad... placemendId = %@, adUnitId = %@", placementId, adUnitId]];
    
    APRAdUnitId *adUnitIdentifier = [[APRAdUnitId alloc] init:adUnitId];
    self.aprInterstitialAd = [[APRInterstitialAd alloc] initWithAdUnitId:(adUnitIdentifier)];
    
    APRAdExtras *extra = [[APRAdExtras alloc] init];
    [extra setWithKey:APRDataKeyAdUnitId value:adUnitId];
    [extra setWithKey:APRDataKeyZoneId value:placementId];
    
    self.interstitialAdDelegate = [[APRInterstitialAdDelegate alloc] initWithParentAdapter:self andNotify:delegate];
    self.aprInterstitialAd.delegate = self.interstitialAdDelegate;
    [self.aprInterstitialAd setWithExtras:extra];
    [self.aprInterstitialAd load];
}

- (void)showInterstitialAdForParameters:(nonnull id<MAAdapterResponseParameters>)parameters andNotify:(nonnull id<MAInterstitialAdapterDelegate>)delegate {
    NSString *placementId = parameters.thirdPartyAdPlacementIdentifier;
    NSString *adUnitId = parameters.adUnitIdentifier;
    [aprLogger debugLog:[NSString stringWithFormat:@"Show Interstitial Ad... placemendId = %@, adUnitId = %@", placementId, adUnitId]];
    if(self.aprInterstitialAd != nil){
        [self.aprInterstitialAd show];
    }else{
        [aprLogger errorLog:@"aprInterstitialAd is nil"];
        [delegate didFailToDisplayInterstitialAdWithError: MAAdapterError.adDisplayFailedError];
    }
}

#pragma mark - MAAdViewAdapter Methods

- (void)loadAdViewAdForParameters:(nonnull id<MAAdapterResponseParameters>)parameters adFormat:(nonnull MAAdFormat *)adFormat andNotify:(nonnull id<MAAdViewAdapterDelegate>)delegate {
    NSString *placementId = parameters.thirdPartyAdPlacementIdentifier;
    NSString *adUnitId = parameters.adUnitIdentifier;
    [aprLogger debugLog:[NSString stringWithFormat:@"Load AdView Ad... placemendId = %@, adUnitId = %@", placementId, adUnitId]];
    
    APRAdUnitId *adUnitIdentifier = [[APRAdUnitId alloc] init:adUnitId];
    APRAdExtras *extra = [[APRAdExtras alloc] init];
    [extra setWithKey:APRDataKeyAdUnitId value:adUnitId];
    [extra setWithKey:APRDataKeyZoneId value:placementId];
    
    self.aprBannerAd = [[APRBannerAd alloc] initWithAdUnitId:(adUnitIdentifier)];
    self.adViewDelegate = [[APRAdViewDelegate alloc] initWithParentAdapter:self format:adFormat andNotify:delegate];
    self.aprBannerAd.delegate = self.adViewDelegate;
    [self.aprBannerAd setWithExtras:extra];
    [self.aprBannerAd load];
}

#pragma mark - MANativeAdAdapter Methods

- (void)loadNativeAdForParameters:(nonnull id<MAAdapterResponseParameters>)parameters andNotify:(nonnull id<MANativeAdAdapterDelegate>)delegate {
    NSString *placementId = parameters.thirdPartyAdPlacementIdentifier;
    NSString *adUnitId = parameters.adUnitIdentifier;
    [aprLogger debugLog:[NSString stringWithFormat:@"Load Native Ad... placemendId = %@, adUnitId = %@", placementId, adUnitId]];
    
    APRAdUnitId *adUnitIdentifier = [[APRAdUnitId alloc] init:adUnitId];
    APRAdExtras *extra = [[APRAdExtras alloc] init];
    [extra setWithKey:APRDataKeyAdUnitId value:adUnitId];
    [extra setWithKey:APRDataKeyZoneId value:placementId];
    
    self.aprNativeAd = [[APRNativeAd alloc] initWithAdUnitId:(adUnitIdentifier)];
    self.nativeAdViewDelegate = [[APRNativeAdDelegate alloc] initWithParentAdapter:self andNotify:delegate];
    self.aprNativeAd.delegate = self.nativeAdViewDelegate;
    [self.aprNativeAd setWithExtras:extra];
    dispatchOnMainQueue(^{
        [self.aprNativeAd loadAd];
    });
    
}

- (void)renderAPRNativeAd:(APRNativeAd *)nativeAd
                andNotify:(id<MANativeAdAdapterDelegate>)delegate
{
    // `nativeAd` may be nil if the adapter is destroyed before the ad loaded (timed out).
    if (!nativeAd)
    {
        [delegate didFailToLoadNativeAdWithError: MAAdapterError.noFill];
        return;
    }
    
    // Ensure UI rendering is done on main queue
    dispatchOnMainQueue(^{
        MANativeAd *maxNativeAd = [[MAAppierNativeAd alloc] initWithParentAdapter: self builderBlock:^(MANativeAdBuilder *builder) {
            builder.title = nativeAd.title;
            builder.body = nativeAd.mainText;
            builder.callToAction = nativeAd.callToAction;
            builder.icon = [[MANativeAdImage alloc] initWithImage: nativeAd.iconImage];
            
            UIImageView *optionView = [[UIImageView alloc] init];
            optionView.translatesAutoresizingMaskIntoConstraints = NO;
            [optionView setImage: nativeAd.privacyInformationImage];
            builder.optionsView = optionView;
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            [imageView setImage: nativeAd.mainImage];
            builder.mediaView = imageView;
        }];
        
        [delegate didLoadAdForNativeAd: maxNativeAd withExtraInfo: nil];
    });
}


@end

@implementation APRInterstitialAdDelegate

#pragma mark - APRInterstitialAdDelegate

- (void)onAdNoBid:(APRInterstitialAd *)interstitialAd {
    [aprLogger debugLog:@"onAdNoBid"];
    [self.delegate didFailToLoadInterstitialAdWithError:MAAdapterError.noFill];
}

- (void)onAdLoaded:(APRInterstitialAd *)interstitialAd {
    [aprLogger debugLog:@"onAdLoaded"];
    [self.delegate didLoadInterstitialAd];
}

- (void)onAdLoadedFailed:(APRInterstitialAd *)interstitialAd error:(APRError *)error {
    [aprLogger debugLog:[NSString stringWithFormat:@"onAdLoadedFailed: %@", error.description]];
    [self.delegate didFailToLoadInterstitialAdWithError:MAAdapterError.unspecified];
}

- (void)onAdShown:(APRInterstitialAd *)interstitialAd {
    [aprLogger debugLog:@"onAdShown"];
    [self.delegate didDisplayInterstitialAd];
}

- (void)onAdShownFailed:(APRInterstitialAd *)interstitialAd {
    [aprLogger debugLog:@"onAdShownFailed"];
    [self.delegate didFailToDisplayInterstitialAdWithError:MAAdapterError.unspecified];
}

- (void)onAdDismiss:(APRInterstitialAd *)interstitialAd {
    [aprLogger debugLog:@"onAdDismiss"];
    [self.delegate didHideInterstitialAd];
}

- (void)onAdClickedRecorded:(APRInterstitialAd *)interstitialAd {
    [aprLogger debugLog:@"onAdClickedRecorded"];
    [self.delegate didClickInterstitialAd];
}

- (instancetype)initWithParentAdapter:(AppierMediationAdapter *)parentAdapter andNotify:(id<MAInterstitialAdapterDelegate>)delegate {
    self = [super init];
    if(self){
        self.parentAdapter = parentAdapter;
        self.delegate = delegate;
    }
    return self;
}

@end

@implementation APRAdViewDelegate

#pragma mark - APRAdViewDelegate

- (void)onAdClickedRecorded:(APRBannerAd * _Nonnull)bannerAd {
    [aprLogger debugLog:@"onAdClickedRecorded"];
    [self.delegate didClickAdViewAd];
}

- (void)onAdClickedRecordedFailed:(APRBannerAd * _Nonnull)bannerAd error:(APRError * _Nonnull)error {
    [aprLogger debugLog:[NSString stringWithFormat:@"onAdClickedRecordedFailed: %@", error.description]];
}

- (void)onAdImpressionRecorded:(APRBannerAd * _Nonnull)bannerAd {
    [aprLogger debugLog:@"onAdImpressionRecorded"];
}

- (void)onAdImpressionRecordedFailed:(APRBannerAd * _Nonnull)bannerAd error:(APRError * _Nonnull)error {
    [aprLogger debugLog:[NSString stringWithFormat:@"onAdImpressionRecordedFailed: %@", error.description]];
}

- (void)onAdLoaded:(APRBannerAd * _Nonnull)bannerAd banner:(UIView * _Nonnull)banner {
    [aprLogger debugLog:@"onAdLoaded"];
    [self.delegate didLoadAdForAdView:banner];
}

- (void)onAdLoadedFailed:(APRBannerAd * _Nonnull)bannerAd error:(APRError * _Nonnull)error {
    [aprLogger debugLog:[NSString stringWithFormat:@"onAdLoadedFailed: %@", error.description]];
    [self.delegate didFailToLoadAdViewAdWithError:MAAdapterError.unspecified];
}

- (void)onAdNoBid:(APRBannerAd * _Nonnull)bannerAd {
    [aprLogger debugLog:@"onAdNoBid"];
    [self.delegate didFailToLoadAdViewAdWithError:MAAdapterError.noFill];
}

- (instancetype)initWithParentAdapter:(AppierMediationAdapter *)parentAdapter format:(MAAdFormat *)format andNotify:(id<MAAdViewAdapterDelegate>)delegate {
    self = [super init];
    if(self){
        self.parentAdapter = parentAdapter;
        self.delegate = delegate;
    }
    return self;
}

@end

@implementation APRNativeAdDelegate

#pragma mark - APRNativeAdDelegate

- (void)onAdClickedRecorded:(APRNativeAd * _Nonnull)nativeAd {
    [aprLogger debugLog:@"onAdClickedRecorded"];
    [self.delegate didClickNativeAd];
}

- (void)onAdClickedRecordedFailed:(APRNativeAd * _Nonnull)nativeAd error:(APRError * _Nonnull)error {
    [aprLogger debugLog:[NSString stringWithFormat:@"onAdClickedRecordedFailed: %@", error.description]];
}

- (void)onAdImpressionRecorded:(APRNativeAd * _Nonnull)nativeAd {
    [aprLogger debugLog:@"onAdImpressionRecorded"];
}

- (void)onAdImpressionRecordedFailed:(APRNativeAd * _Nonnull)nativeAd error:(APRError * _Nonnull)error {
    [aprLogger debugLog:[NSString stringWithFormat:@"onAdImpressionRecordedFailed: %@", error.description]];
}

- (void)onAdLoaded:(APRNativeAd * _Nonnull)nativeAd {
    [aprLogger debugLog:@"onAdLoaded"];
    [self.parentAdapter renderAPRNativeAd:nativeAd andNotify:self.delegate];
}

- (void)onAdLoadedFailed:(APRNativeAd * _Nonnull)nativeAd error:(APRError * _Nonnull)error {
    [aprLogger debugLog:[NSString stringWithFormat:@"onAdLoadedFailed: %@", error.description]];
    [self.delegate didFailToLoadNativeAdWithError: MAAdapterError.unspecified];
}

- (void)onAdNoBid:(APRNativeAd * _Nonnull)nativeAd {
    [aprLogger debugLog:@"onAdNoBid"];
    [self.delegate didFailToLoadNativeAdWithError:MAAdapterError.unspecified];
}

- (void)onAdShown:(APRNativeAd * _Nonnull)nativeAd {
    [aprLogger debugLog:@"onAdShown"];
    [self.delegate didDisplayNativeAdWithExtraInfo:nil];
}

- (instancetype)initWithParentAdapter:(AppierMediationAdapter *)parentAdapter andNotify:(id<MANativeAdAdapterDelegate>)delegate {
    self = [super init];
    if(self){
        self.parentAdapter = parentAdapter;
        self.delegate = delegate;
    }
    return self;
}

@end

@implementation MAAppierNativeAd

- (instancetype)initWithParentAdapter:(AppierMediationAdapter *)parentAdapter builderBlock:(NS_NOESCAPE MANativeAdBuilderBlock)builderBlock {
    self = [super initWithFormat: MAAdFormat.native builderBlock: builderBlock];
    if (self)
    {
        self.parentAdapter = parentAdapter;
    }
    return self;
}

- (BOOL)prepareForInteractionClickableViews:(NSArray<UIView *> *)clickableViews withContainer:(UIView *)container{
    APRNativeAd *nativeAd = self.parentAdapter.aprNativeAd;
    if (!nativeAd)
    {
        [aprLogger errorLog:@"Failed to register native ad views: native ad is nil."];
        return NO;
    }
    
    NSMutableArray *appierClickableViews = [NSMutableArray array];
    [appierClickableViews addObjectsFromArray: clickableViews];
    [appierClickableViews addObject: self.mediaView];
    
    // foreach clickable views, register click event
    for (UIView *clickableView in appierClickableViews){
        [clickableView setUserInteractionEnabled: YES];
        [clickableView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(onClickableViewClicked:)]];
    }
    
    // set click action for options view
    if(self.optionsView){
        [self.optionsView setUserInteractionEnabled: YES];
        [self.optionsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(onOptionsViewClicked:)]];
    }
    return YES;
}

- (void)onClickableViewClicked:(UITapGestureRecognizer *)gestureRecognizer{
    APRNativeAd *nativeAd = self.parentAdapter.aprNativeAd;
    if (!nativeAd)
    {
        [aprLogger errorLog:@"Failed to handle click event: native ad is nil."];
        return;
    }
    [nativeAd clickAdViewWithSender:gestureRecognizer];
}

- (void)onOptionsViewClicked:(UITapGestureRecognizer *)gestureRecognizer{
    APRNativeAd *nativeAd = self.parentAdapter.aprNativeAd;
    if (!nativeAd)
    {
        [aprLogger errorLog:@"Failed to handle click event for options view: native ad is nil."];
        return;
    }
    [nativeAd clickPrivacyInformationViewWithSender:gestureRecognizer];
}

@end



