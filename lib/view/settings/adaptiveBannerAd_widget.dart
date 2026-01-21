import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdaptiveBannerAd extends StatefulWidget {
  const AdaptiveBannerAd({super.key});

  @override
  State<AdaptiveBannerAd> createState() => _AdaptiveBannerAdState();
}

class _AdaptiveBannerAdState extends State<AdaptiveBannerAd> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  double _adHeight = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAdaptiveAd();
  }

  Future<void> _loadAdaptiveAd() async {
    final double width = MediaQuery.of(context).size.width.truncateToDouble();

    final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width.truncate());

    if (size == null) {
      return;
    }

    _adHeight = size.height.toDouble();

    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Ad Unit ID
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          setState(() {
            _isAdLoaded = false;
          });
        },
      ),
    );

    await _bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _adHeight == 0 ? 50 : _adHeight,
      width: double.infinity,
      child: _isAdLoaded && _bannerAd != null
          ? AdWidget(ad: _bannerAd!)
          : const SizedBox(), // Box فاضي
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
