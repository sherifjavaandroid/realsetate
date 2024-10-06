import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/chat/seller_chat_history_list_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/chat_history.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/chat_history_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/product_detail_and_address_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../common/bluemark_icon.dart';
import '../../../../../common/ps_ui_widget.dart';

class ChatSellerListItem extends StatelessWidget {
  const ChatSellerListItem({
    Key? key,
    required this.chatHistory,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final ChatHistory chatHistory;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    animationController?.forward();
    const Widget _spacingWidget = SizedBox(
      height: PsDimens.space2,
    );
    final Widget _dividerWidget = Divider(
      height: PsDimens.space1,
      color: Utils.isLightMode(context)
          ? PsColors.achromatic400
          : PsColors.achromatic100,
      thickness: 0.2,
    );
    return AnimatedBuilder(
        animation: animationController!,
        child: InkWell(
          onTap: () {
            onTap(context);
          },
          child: Column(
            children: <Widget>[
              // _dividerWidget,
              Container(
                color: chatHistory.hasBuyerUnreadCount
                    ? Utils.isLightMode(context)
                        ? PsColors.primary50
                        : PsColors.text700
                    : Utils.isLightMode(context)
                        ? PsColors.achromatic50
                        : PsColors.achromatic800,
                padding: const EdgeInsets.symmetric(
                    horizontal: PsDimens.space19, vertical: PsDimens.space8),
                child: Stack(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              width: PsDimens.space64,
                              height: PsDimens.space64,
                              child: PsNetworkCircleImage(
                                photoKey: '',
                                imagePath:
                                    chatHistory.item!.defaultPhoto?.imgPath,
                                boxfit: BoxFit.cover,
                                onTap: () {
                                  goToProductDetail(context, chatHistory.item!);
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              right: 1,
                              child: Container(
                                  width: PsDimens.space24,
                                  height: PsDimens.space24,
                                  child: PsNetworkCircleImageForUser(
                                    photoKey: '',
                                    imagePath:
                                        chatHistory.seller!.userCoverPhoto,
                                    boxfit: BoxFit.cover,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: PsDimens.space16,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                chatHistory.item!.title!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Utils.isLightMode(context)
                                            ? PsColors.primary500
                                            : PsColors.primary300,
                                        fontWeight: FontWeight.w600),
                              ),
                              _spacingWidget,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        chatHistory.seller?.name == ''
                                            ? 'default__user_name'.tr
                                            : chatHistory.seller?.name ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      if (chatHistory
                                          .seller!.isVefifiedBlueMarkUser)
                                        const BluemarkIcon()
                                    ],
                                  ),
                                  Padding(
                                    padding: Directionality.of(context) ==
                                            TextDirection.ltr
                                        ? const EdgeInsets.only(left: 8)
                                        : const EdgeInsets.only(right: 8),
                                    child: Text(
                                      chatHistory.addedDateStr!,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: Utils.isLightMode(context)
                                                  ? PsColors.text900
                                                  : PsColors.text50),
                                    ),
                                  )
                                ],
                              ),
                              _spacingWidget,
                              Text(
                                chatHistory.latestChatMessage ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Utils.isLightMode(context)
                                            ? PsColors.text500
                                            : PsColors.text50,
                                        fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 1,
                      right: Directionality.of(context) == TextDirection.ltr
                          ? 1
                          : 0,
                      left: Directionality.of(context) == TextDirection.ltr
                          ? 0
                          : 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const SizedBox(height: PsDimens.space4),
                          if (chatHistory.hasBuyerUnreadCount)
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Utils.isLightMode(context)
                                    ? PsColors.primary500
                                    : PsColors
                                        .primary300, //PsColors.primary500,
                                borderRadius:
                                    BorderRadius.circular(PsDimens.space28),
                              ),
                              child: Center(
                                child: Text(chatHistory.buyerUnreadCount!,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Utils.isLightMode(context)
                                                ? PsColors.achromatic50
                                                : PsColors.achromatic800,
                                            fontSize: 10)),
                              ),
                            )
                          else
                            Icon(Icons.done_all,
                                color: Utils.isLightMode(context)
                                    ? PsColors.achromatic700
                                    : PsColors.achromatic300,
                                size: 16)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              _dividerWidget
            ],
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: animation!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 100 * (1.0 - animation!.value), 0.0),
                  child: child));
        });
  }

  Future<void> onTap(BuildContext context) async {
    final SellerChatHistoryListProvider _provider =
        Provider.of<SellerChatHistoryListProvider>(context, listen: false);
    await Navigator.pushNamed(
      context,
      RoutePaths.chatView,
      arguments: ChatHistoryIntentHolder(
          chatFlag: PsConst.CHAT_FROM_SELLER,
          itemId: chatHistory.item!.id,
          buyerUserId: chatHistory.buyerUserId,
          sellerUserId: chatHistory.sellerUserId,
          userCoverPhoto: chatHistory.seller!.userCoverPhoto,
          userName: chatHistory.seller!.name,
          itemDetail: chatHistory.item),
    );
    _provider.loadDataList(reset: true);
  }

  void goToProductDetail(BuildContext context, Product product) {
    final ProductDetailAndAddress holder=ProductDetailAndAddress(productDetailIntentHolder: ProductDetailIntentHolder(productId: product.id), shippingAddressHolder: null, billingAddressHolder: null);

    // final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
    //     productId: product.id,
    //     heroTagImage: //widget.chatHistoryProvider.hashCode.toString() +
    //         product.id! + PsConst.HERO_TAG__IMAGE,
    //     heroTagTitle: //widget.chatHistoryProvider.hashCode.toString() +
    //         product.id! + PsConst.HERO_TAG__TITLE);
    Navigator.pushNamed(context, RoutePaths.productDetail, arguments: holder);
  }
}
