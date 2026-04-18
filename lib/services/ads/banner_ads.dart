import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:baseprogrammer/constants/ad_constants.dart';

class BannerAdsWidget extends StatefulWidget {
  const BannerAdsWidget({super.key});

  @override
  State<BannerAdsWidget> createState() => _BannerAdsWidgetState();
}

class _BannerAdsWidgetState extends State<BannerAdsWidget> {
  BannerAd? bannerAd;
  bool isLoaded = false;

  void loadBannerAds() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdConstants.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              isLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Banner Ad failed to load: $error');
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    loadBannerAds();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded && bannerAd != null) {
      return Container(
        width: bannerAd!.size.width.toDouble(),
        height: bannerAd!.size.height.toDouble(),
        alignment: Alignment.center,
        child: AdWidget(ad: bannerAd!),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
