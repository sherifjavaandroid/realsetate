import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/provider/history/history_provider.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../custom_ui/item/detail/component/appbar/widgets/edit_widget.dart';
import '../../../../../custom_ui/item/detail/component/appbar/widgets/pop_up_menu_widget.dart';
import '../../../../../custom_ui/item/detail/component/appbar/widgets/product_detail_gallery_view.dart';
import '../../../../../custom_ui/item/detail/component/appbar/widgets/save_widget.dart';
import '../../../../common/ps_back_button_with_circle_bg_widget.dart';

const int maxFailedLoadAttempts = 3;

class ProductExpandableAppbar extends StatefulWidget {
  const ProductExpandableAppbar(
      {required this.isReadyToShowAppBarIcons, this.itemDetailBackIconOnTap});

  final bool isReadyToShowAppBarIcons;
    final Function()? itemDetailBackIconOnTap;

  @override
  State<ProductExpandableAppbar> createState() =>
      _ProductExpandableAppbarState();
}

class _ProductExpandableAppbarState extends State<ProductExpandableAppbar> {
  PsValueHolder? psValueHolder;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  bool isFirstTime = false;

  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider provider =
        Provider.of<ItemDetailProvider>(context);
    final Product product = provider.product;
    final HistoryProvider historyProvider =
        Provider.of<HistoryProvider>(context);
        //     final AppInfoProvider appInfoProvider =
        // Provider.of<AppInfoProvider>(context);

    psValueHolder = Provider.of<PsValueHolder>(context);
    if (provider.hasData) {
      if (!isFirstTime) {
        processToShowAdInItemDetail(provider);
        historyProvider.addToDatabase(provider.product);
        isFirstTime = true;
      }
    }

    /**UI Section is here */
    return SliverAppBar(
      automaticallyImplyLeading: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
      ),
      elevation: 0,
      expandedHeight: 380,
      iconTheme: Theme.of(context).iconTheme.copyWith(
          color: Utils.isLightMode(context)
              ? PsColors.primary500
              : PsColors.primary300),
      leading: PsBackButtonWithCircleBgWidget(
          leftColor: (psValueHolder!.languageCode == 'ar')
              ? PsColors.achromatic50.withAlpha(50)
              : PsColors.achromatic50,
          rightColor: (psValueHolder!.languageCode == 'ar')
              ? PsColors.achromatic50
              : PsColors.achromatic50.withAlpha(50)),
      floating: false,
      pinned: false,
      stretch: false,
      actions: !widget.isReadyToShowAppBarIcons
          ? <Widget>[
            //       Visibility(
            // visible: appInfoProvider
            //         .appInfo.data?.vendorConFig?.vendorCheckoutSetting ==
            //     PsConst.ONE,
            // child: const CustomShoppingCartWidget()),


          ]
          : <Widget>[
            //          Visibility(
            // visible: appInfoProvider
            //         .appInfo.data?.vendorConFig?.vendorCheckoutSetting ==
            //     PsConst.ONE,
            // child: const CustomShoppingCartWidget()),

              if (Utils.isOwnerItem(psValueHolder!, product))
                CustomEditWidget()
              else
                CustomSaveWidget(),
              const CustomPopUpMenuWidget(),
            ],
      flexibleSpace: const FlexibleSpaceBar(
        background: CustomProductDetailGalleryView(),
      ),
    );
  }

  void processToShowAdInItemDetail(ItemDetailProvider provider) {
    if (provider.openDetailCountLimitExceeded &&
        psValueHolder!.isShowAdsInItemDetail!) {
      _createInterstitialAd();
      provider.replaceDetailOpenCount(0);
    } else {
      if (psValueHolder!.detailOpenCount == null) {
        provider.replaceDetailOpenCount(1);
      } else {
        final int i = psValueHolder!.detailOpenCount! + 1;
        provider.replaceDetailOpenCount(i);
      }
    }
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Utils.getInterstitialUnitId(context),
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
            _interstitialAd!.show();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }
}
