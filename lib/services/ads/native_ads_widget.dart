import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:baseprogrammer/constants/ad_constants.dart';

class NativeAdsWidget extends StatefulWidget {
  final TemplateType templateType;
  const NativeAdsWidget({super.key, this.templateType = TemplateType.medium});

  @override
  State<NativeAdsWidget> createState() => _NativeAdsWidgetState();
}

class _NativeAdsWidgetState extends State<NativeAdsWidget> {
  NativeAd? _nativeAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _nativeAd = NativeAd(
      adUnitId: AdConstants.nativeAdUnitId,
      factoryId:
          'adFactoryExample', // Not used with templates but required by API in some versions/cases
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('NativeAd failed to load: $error');
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: widget.templateType,
        mainBackgroundColor: Colors.white10,
        cornerRadius: 12.0,
      ),
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdLoaded && _nativeAd != null) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        height: widget.templateType == TemplateType.medium ? 320 : 90,
        alignment: Alignment.center,
        child: AdWidget(ad: _nativeAd!),
      );
    }
    return const SizedBox.shrink();
  }
}
