import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/chat_history_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/user_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../core/vendor/viewobject/user.dart';
import '../../../../common/bluemark_icon.dart';
import '../../../../common/ps_ui_widget.dart';
import '../../../../common/user_rating_widget.dart';

class SellerInfoTileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider provider =
        Provider.of<ItemDetailProvider>(context);

    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);

    final User? productOwner = provider.productOwner;
    if (productOwner == null ||
        Utils.isOwnerItem(psValueHolder, provider.product))
      return const SliverToBoxAdapter(child: SizedBox());

    if (provider.product.vendorId != '' && //item is from vendor
        psValueHolder.vendorFeatureSetting == PsConst.ONE)
      return const SliverToBoxAdapter(child: SizedBox());

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
            top: PsDimens.space32,
            bottom: PsDimens.space16,
            left: PsDimens.space16,
            right: PsDimens.space16),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                onSellerInfoClick(context, provider.product);
              },
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        //image
                        Container(
                          width: 53,
                          height: 53,
                          child: PsNetworkCircleImageForUser(
                            photoKey: '',
                            imagePath: provider.product.user!.userCoverPhoto,
                            boxfit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //username
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                      provider.product.user!.name == ''
                                          ? 'default__user_name'.tr
                                          : provider.product.user!.name ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontSize: 18,
                                              color: Utils.isLightMode(context)
                                                  ? PsColors.achromatic900
                                                  : PsColors.text200)),
                                ),
                                if (productOwner.isVefifiedBlueMarkUser)
                                  const BluemarkIcon()
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text('item_detail_owner'.tr,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: PsColors.text500,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: UserRatingWidget(
                                user: provider.product.user,
                                starCount: 5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Directionality.of(context) == TextDirection.ltr
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if (productOwner.showEmail)
                              Container(
                                margin: const EdgeInsets.only(
                                    left: PsDimens.space16),
                                child: InkWell(
                                    onTap: () async {
                                      final Uri params = Uri(
                                          scheme: 'mailto',
                                          path: productOwner.userEmail);
                                      final String url = params.toString();
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      } else {
                                        print('Could not launch $url');
                                      }
                                    },
                                    child: Container(
                                      padding:
                                          const EdgeInsets.all(PsDimens.space6),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Utils.isLightMode(context)
                                            ? PsColors.primary50
                                            : PsColors.primary200,
                                      ),
                                      child: const Icon(
                                        Remix.mail_line,
                                        size: 22,
                                      ),
                                    )),
                              ),
                            if (productOwner.showPhone &&
                                provider.productOwner!.hasPhone)
                              Container(
                                margin: const EdgeInsets.only(
                                    left: PsDimens.space16),
                                child: InkWell(
                                    onTap: () async {
                                      if (await canLaunchUrl(Uri.parse(
                                          'tel://${provider.product.user!.userPhone}'))) {
                                        await launchUrl(Uri.parse(
                                            'tel://${provider.product.user!.userPhone}'));
                                      } else {
                                        throw 'Could not Call Phone Number 1';
                                      }
                                    },
                                    child: Container(
                                      padding:
                                          const EdgeInsets.all(PsDimens.space6),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Utils.isLightMode(context)
                                            ? PsColors.primary50
                                            : PsColors.primary200,
                                      ),
                                      child: const Icon(
                                        Remix.phone_line,
                                        size: 22,
                                      ),
                                    )),
                              ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: PsDimens.space16),
                              child: InkWell(
                                  onTap: () async {
                                    if (await Utils
                                        .checkInternetConnectivity()) {
                                      Utils.navigateOnUserVerificationView(
                                          context, () async {
                                        Navigator.pushNamed(
                                            context, RoutePaths.chatView,
                                            arguments: ChatHistoryIntentHolder(
                                              chatFlag:
                                                  PsConst.CHAT_FROM_SELLER,
                                              itemId: provider.product.id,
                                              buyerUserId:
                                                  psValueHolder.loginUserId,
                                              sellerUserId:
                                                  provider.product.addedUserId,
                                              userCoverPhoto: provider
                                                  .product.user!.userCoverPhoto,
                                              userName:
                                                  provider.product.user!.name,
                                              itemDetail: provider.product,
                                            ));
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.all(PsDimens.space6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Utils.isLightMode(context)
                                          ? PsColors.primary50
                                          : PsColors.primary200,
                                    ),
                                    child: const Icon(
                                      Remix.chat_3_line,
                                      size: 22,
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (provider.product.user!.userAboutMe != '')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: PsDimens.space24,
                  ),
                  Text('item_detail_overview'.tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Utils.isLightMode(context)
                              ? PsColors.achromatic900
                              : PsColors.text200,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                  const SizedBox(
                    height: PsDimens.space8,
                  ),
                  Text(provider.product.user!.userAboutMe ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Utils.isLightMode(context)
                              ? PsColors.text500
                              : PsColors.text400)),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void onSellerInfoClick(BuildContext context, Product product) {
    Navigator.pushNamed(context, RoutePaths.userDetail,
        arguments: UserIntentHolder(
            userId: product.addedUserId, userName: product.user?.name ?? ''));
  }
}
