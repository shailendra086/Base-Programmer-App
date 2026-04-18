import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:baseprogrammer/constants/ad_constants.dart';
import 'package:get/get.dart';

class AdService extends GetxService {
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdLoaded = false;

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdConstants.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdLoaded = true;
          _setInterstitialListener(ad);
        },
        onAdFailedToLoad: (error) {
          print('InterstitialAd failed to load: $error');
          _isInterstitialAdLoaded = false;
        },
      ),
    );
  }

  void _setInterstitialListener(InterstitialAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadInterstitialAd(); // Load next ad
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        loadInterstitialAd();
      },
    );
  }

  void showInterstitialAd() {
    if (_isInterstitialAdLoaded && _interstitialAd != null) {
      _interstitialAd!.show();
      _isInterstitialAdLoaded = false; // Reset for next load
    } else {
      print('Interstitial ad not loaded yet.');
      loadInterstitialAd(); // Try to load if not already
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadInterstitialAd();
  }
}
