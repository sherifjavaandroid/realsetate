import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../../../../custom_ui/user/profile/component/my_vendor/widget/my_vendor_approve_info.dart';
import '../../../../../../vendor_ui/common/ps_ui_widget.dart';

class MyVendorListGridItem extends StatefulWidget {
  const MyVendorListGridItem(
      {Key? key,
      required this.vendorUser,
      this.animation,
      this.animationController,
      this.isLoading = false,
      this.width})
      : super(key: key);

  final VendorUser vendorUser;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final double? width;

  @override
  State<MyVendorListGridItem> createState() => _MyVendorListGridItemState();
}

class _MyVendorListGridItemState extends State<MyVendorListGridItem> {
  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);

    widget.animationController!.forward();
    return AnimatedBuilder(
        animation: widget.animationController!,
        child: widget.isLoading
            ? const SizedBox()
            : Container(
                padding: const EdgeInsets.only(
                    left: PsDimens.space8,
                    top: PsDimens.space12,
                    bottom: PsDimens.space12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: Utils.isLightMode(context)
                          ? PsColors.text100
                          : PsColors.text50),
                ),
                width: widget.width ?? MediaQuery.of(context).size.width,
                height: 90,
                margin: const EdgeInsets.only(
                    bottom: PsDimens.space16,
                    left: PsDimens.space8,
                    right: PsDimens.space8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Stack(children: <Widget>[
                          Container(
                            child: SizedBox(
                              width: PsDimens.space60,
                              height: PsDimens.space60,
                              child: PsNetworkCircleImageForUser(
                                photoKey: '',
                                imagePath: widget.vendorUser.logo!.imgPath,
                                boxfit: BoxFit.cover,
                                onTap: () {
                                  //onDetailClick(context);
                                },
                              ),
                            ),
                          ),
                          if (widget.vendorUser.expiredStatus ==
                              PsConst.EXPIRED_NOTI)
                            Container(
                              width: PsDimens.space60,
                              height: PsDimens.space60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: PsColors.achromatic900.withOpacity(0.75),
                              ),

                              //),
                              alignment: Alignment.center,
                              child: Text('Closed',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: PsColors.text50)),
                            )
                          else
                            const SizedBox(),
                          if (widget.vendorUser.isVendorUser)
                            Positioned(
                              right: -1,
                              bottom: -1,
                              child: Icon(
                                Icons.verified_user,
                                color: PsColors.info500,
                                size: 20,
                              ),
                            ),
                        ]),
                        const SizedBox(width: PsDimens.space16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            //     Flexible(
                            //       child:

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: PsDimens.space100,
                                  child: Text(
                                      widget.vendorUser.name == ''
                                          ? 'default__user_name'.tr
                                          : '${widget.vendorUser.name}',
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ),
                                if (widget.vendorUser.expiredStatus ==
                                        PsConst.EXPIRED_NOTI &&
                                    widget.vendorUser.ownerUserId ==
                                        provider.user.data?.userId &&
                                    !Utils.isLoginUserEmpty(valueHolder))
                                  Text('subscription_expired'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontSize: 10,
                                            color: PsColors.error500,
                                          ))
                                else
                                  const SizedBox(),
                              ],
                            ),

                            //),
                            const SizedBox(width: PsDimens.space4),
                            Image.asset(
                              'assets/images/storefont.png',
                              width: 25,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: PsDimens.space8),
                        width: PsDimens.space120,
                        child: CustomMyVendorApproveInfoWidget(
                          vendorUser: widget.vendorUser,
                        ))
                  ],
                ),
              ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: widget.animation!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 100 * (1.0 - widget.animation!.value), 0.0),
                  child: child));
        });
  }
}
