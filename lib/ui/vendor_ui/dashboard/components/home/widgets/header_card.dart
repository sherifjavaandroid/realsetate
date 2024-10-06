import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/recent_product_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../../../../vendor_ui/common/ps_ui_widget.dart';
import '../../../../../vendor_ui/common/shimmer_item.dart';

class HeaderCard extends StatefulWidget {
  const HeaderCard({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  State<StatefulWidget> createState() => HeaderCardWidgetState();
}

class HeaderCardWidgetState extends State<HeaderCard> {
  // ignore: unused_field
  String? _currentId;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<RecentProductProvider>(builder: (BuildContext context,
          RecentProductProvider productProvider, Widget? child) {
        return AnimatedBuilder(
            animation: widget.animationController!,
            child: Container(
              margin: const EdgeInsets.only(
                  left: PsDimens.space16,
                  right: PsDimens.space16,
                  top: PsDimens.space16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'header_card_title'.tr,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Utils.isLightMode(context)
                              ? PsColors.text800
                              : PsColors.text200,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    const SizedBox(
                      height: PsDimens.space16,
                    ),
                    Text(
                      'header_card_desc'.tr,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Utils.isLightMode(context)
                              ? PsColors.text500
                              : PsColors.text400,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                    if (productProvider.productList.data != null &&
                        productProvider.productList.data!.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(
                            top: PsDimens.space24, bottom: PsDimens.space40),
                        child: Row(children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: PsDimens.space260,
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 30),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(PsDimens.space20),
                                child: PsNetworkImage(
                                  photoKey:
                                      '${productProvider.productList.data![0].id}${PsConst.HERO_TAG__IMAGE}',
                                  defaultPhoto: productProvider
                                      .productList.data![0].defaultPhoto,
                                  boxfit: BoxFit.cover,
                                  imageAspectRation: PsConst.Aspect_Ratio_2x,
                                  onTap: () {
                                    goToItemDetail(0);
                                  },
                                ),
                              ),
                            ),
                          ),
                          if (productProvider.productList.data!.length >= 2)
                            Flexible(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    height: PsDimens.space140,
                                    margin: Directionality.of(context) ==
                                            TextDirection.ltr
                                        ? const EdgeInsets.only(
                                            left: PsDimens.space16)
                                        : const EdgeInsets.only(
                                            right: PsDimens.space16),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          PsDimens.space20),
                                      child: PsNetworkImage(
                                        photoKey:
                                            '${productProvider.productList.data![1].id}${PsConst.HERO_TAG__IMAGE}',
                                        defaultPhoto: productProvider
                                            .productList.data![1].defaultPhoto,
                                        boxfit: BoxFit.cover,
                                        imageAspectRation:
                                            PsConst.Aspect_Ratio_2x,
                                        onTap: () {
                                          goToItemDetail(1);
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: PsDimens.space20,
                                  ),
                                  if (productProvider
                                          .productList.data!.length >=
                                      3)
                                    Container(
                                      height: PsDimens.space100,
                                      margin: Directionality.of(context) ==
                                              TextDirection.ltr
                                          ? const EdgeInsets.only(
                                              left: PsDimens.space16)
                                          : const EdgeInsets.only(
                                              right: PsDimens.space16),
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            PsDimens.space20),
                                        child: PsNetworkImage(
                                          photoKey:
                                              '${productProvider.productList.data![2].id}${PsConst.HERO_TAG__IMAGE}',
                                          defaultPhoto: productProvider
                                              .productList
                                              .data![2]
                                              .defaultPhoto,
                                          boxfit: BoxFit.cover,
                                          imageAspectRation:
                                              PsConst.Aspect_Ratio_2x,
                                          onTap: () {
                                            goToItemDetail(2);
                                          },
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ]),
                      )
                    else
                      Container(
                        height: PsDimens.space260,
                        child: const ShimmerItem(),
                      )
                  ]),
            ),
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                  opacity: curveAnimation(widget.animationController!),
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0,
                          100 *
                              (1.0 -
                                  curveAnimation(widget.animationController!)
                                      .value),
                          0.0),
                      child: child));
            });
      }),
    );
  }

  void goToItemDetail(int index) {
    final RecentProductProvider productProvider =
        Provider.of<RecentProductProvider>(context, listen: false);

    final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
        productId: productProvider.productList.data![index].id,
        heroTagImage: productProvider.productList.data![index].id! +
            PsConst.HERO_TAG__IMAGE,
        heroTagTitle: productProvider.productList.data![index].id! +
            PsConst.HERO_TAG__TITLE);
    Navigator.pushNamed(context, RoutePaths.productDetail, arguments: holder);
  }
}
