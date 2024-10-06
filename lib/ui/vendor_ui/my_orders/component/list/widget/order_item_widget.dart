import 'package:flutter/material.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/item_info.dart';
import '../../../../common/ps_ui_widget.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget(
      {Key? key,
      this.itemCount,
      this.orderCode,
      this.orderStatus,
      this.paymentDate,
      this.total,
      this.orderStatusColor,
      this.itemInfo})
      : super(key: key);
  final String? orderCode;
  final String? orderStatus;
  final String? paymentDate;
  final int? itemCount;
  final String? total;
  final String? orderStatusColor;
  final List<ItemInfo>? itemInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: PsDimens.space6),
        decoration: BoxDecoration(
            color: Utils.isLightMode(context)
                ? PsColors.achromatic50
                : PsColors.achromatic700,
            border: Border.all(
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic100
                  : PsColors.achromatic600,
            ),
            borderRadius:
                const BorderRadius.all(Radius.circular(PsDimens.space8))),
        padding: const EdgeInsets.all(PsDimens.space12),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'order_id'.tr,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Utils.isLightMode(context)
                            ? PsColors.text800
                            : PsColors.achromatic50,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Text(
                    ': $orderCode',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Utils.isLightMode(context)
                            ? PsColors.text800
                            : PsColors.achromatic50,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: PsDimens.space8),
                padding: const EdgeInsets.all(PsDimens.space2),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Utils.codeToColor(
                            orderStatusColor.toString(), Colors.black)),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(PsDimens.space4))),
                alignment: Alignment.center,
                child: Text('$orderStatus',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Utils.codeToColor(
                            orderStatusColor.toString(), Colors.black),
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
              )
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: PsDimens.space10),
              child: Row(
                children: <Widget>[
                  Text('$paymentDate',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Utils.isLightMode(context)
                              ? PsColors.text800
                              : PsColors.achromatic50,
                          fontWeight: FontWeight.w400,
                          fontSize: 12)),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: PsDimens.space2),
                    width: PsDimens.space2,
                    height: PsDimens.space10,
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic200
                        : PsColors.achromatic600,
                  ),
                  Row(
                    children: <Widget>[
                      Text('${itemCount.toString()} ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Utils.isLightMode(context)
                                      ? PsColors.text800
                                      : PsColors.achromatic50,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12)),
                      Text(
                          (itemCount ?? 0) < 2
                              ? 'order_item'.tr
                              : 'order_items'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Utils.isLightMode(context)
                                      ? PsColors.text800
                                      : PsColors.achromatic50,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12)),
                    ],
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: PsDimens.space2),
                    width: PsDimens.space2,
                    height: PsDimens.space10,
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic200
                        : PsColors.achromatic600,
                  ),
                  Text(' $total',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Utils.isLightMode(context)
                              ? PsColors.text800
                              : PsColors.achromatic50,
                          fontWeight: FontWeight.w400,
                          fontSize: 12)),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                for (int i = 0; i < (itemInfo?.length ?? 0); i++)
                  if (i < 4)
                    Container(
                      margin: const EdgeInsets.only(right: PsDimens.space6),
                      width: PsDimens.space56,
                      height: PsDimens.space56,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(PsDimens.space4),
                        child: PsNetworkImage(
                          key: Key(itemInfo![i].itemId.toString()),
                          photoKey: '',
                          defaultPhoto: itemInfo![i].defaultPhoto,
                          imageAspectRation: PsConst.Aspect_Ratio_2x,
                        ),
                      ),
                    ),
                if ((itemInfo?.length ?? 0) > 4)
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Utils.isLightMode(context)
                            ? PsColors.achromatic300
                            : PsColors.achromatic600,
                        borderRadius: BorderRadius.circular(PsDimens.space4),
                      ),
                      margin: const EdgeInsets.only(right: PsDimens.space6),
                      width: PsDimens.space56,
                      height: PsDimens.space56,
                      child: Text('+${itemInfo!.length - 4}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: PsColors.achromatic50,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ))),
              ],
            ),
          ],
        ));
  }
}
