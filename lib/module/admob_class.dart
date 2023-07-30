import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {

  static String? get bannerAdUnitId{
    if (kReleaseMode){
      if (Platform.isAndroid) {
        return 'ca-app-pub-7191096510845066/7151339198';
      } else if (Platform.isIOS){
        return 'ca-app-pub-7191096510845066/6197350170';
      }
    } else {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/6300978111';
      } else if (Platform.isIOS){
        return 'ca-app-pub-3940256099942544/2934735716';
      }
    }
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad loaded.'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad failed to load: $error');
    },
    onAdOpened: (ad) => debugPrint('Ad opened'),
    onAdClosed: (ad) => debugPrint('Ad closed'),
  );
}
