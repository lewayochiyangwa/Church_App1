import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobAdvert extends StatefulWidget {
  const AdmobAdvert({Key? key}) : super(key: key);

  @override
  State<AdmobAdvert> createState() => _AdmobAdvertState();
}
//BannerAd myBanner;
class _AdmobAdvertState extends State<AdmobAdvert> {
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;

  BannerAd bannerAd = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );


  @override
  void initState() {
    super.initState();
    bannerAd.load();
    // Initialize the RewardedAd


  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: bannerAd);
    final Container adContainer = Container(
      child: adWidget,
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
    );
    return Column(
      children: [
        content(adContainer),
      ],
    );
  }

  Widget content(Widget ads) {
    return Container(
        child: Container(
          height: 50,
          width: 320,
          child: ads,
        )
    );
  }

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/5224354917',

        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            //  _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            /*   _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }*/
          },
        ));
  }
}