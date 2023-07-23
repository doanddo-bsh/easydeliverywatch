import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Admob {

  Admob({required BuildContext context});

  Map<String, String> unitId = kReleaseMode
      ? {
    'ios': 'ca-app-pub-7191096510845066/6197350170',
    'android': 'ca-app-pub-7191096510845066/7151339198',
  }
      : {
    'ios': 'ca-app-pub-3940256099942544/2934735716',
    'android': 'ca-app-pub-3940256099942544/6300978111',
  };

  BannerAd getBanner(context){

    TargetPlatform os = Theme.of(context).platform;

    BannerAd banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},
      ),
      size: AdSize.banner,
      adUnitId: unitId[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      request: AdRequest(),
    )..load();

    return banner;
  }

}