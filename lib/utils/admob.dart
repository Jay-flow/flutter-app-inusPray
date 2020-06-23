import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'YOUR_DEVICE_ID';

enum AdType { BANNER, INTERSTITIAL, VIDEO }

class AdMob {
  AdMob() {
    init();
  }

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  init() {
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {};
  }

  BannerAd createBannerAd({AdSize adSize}) {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: adSize,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {},
    );
  }

  InterstitialAd createInterstitialAd(Function eventCallback) {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) => eventCallback(event),
    );
  }

  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }

  showBanner({AdSize adSize, double anchorOffset=0}) {
    _bannerAd ??= createBannerAd(adSize: adSize);
    _bannerAd
      ..load()
      ..show(
        anchorOffset: anchorOffset,
      );
  }

  removeBanner() {
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  showVideo(Function eventCallback) {
    RewardedVideoAd.instance.load(
        adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo);
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      eventCallback(event);
    };
  }
}
