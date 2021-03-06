import 'package:firebase_admob/firebase_admob.dart';
import 'dart:io';

const String testDevice = null;

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
    String appId = Platform.isAndroid
        ? "ca-app-pub-7723933178431532~7033211783"
        : "ca-app-pub-7723933178431532~7900065733";
    FirebaseAdMob.instance.initialize(appId: appId);
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

  showBanner({AdSize adSize, double anchorOffset = 0}) {
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

  showVideoAd() {
    RewardedVideoAd.instance.load(
        adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo);
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.loaded) {
        RewardedVideoAd.instance.show();
      }
    };
  }

  InterstitialAd showInterstitialAd() {
    _interstitialAd = this.createInterstitialAd((MobileAdEvent event) {
      if (event == MobileAdEvent.loaded) {
        _interstitialAd.show();
      }
    })
      ..load();
    return _interstitialAd;
  }
}
