import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class PaymentRoleWidget extends StatelessWidget {
  const PaymentRoleWidget(
      {Key? key,
      required this.image,
      required this.paymentName,
      this.groupValue,
      required this.isSelected,
      this.onChanged,
      required this.value})
      : super(key: key);
  final Image image;
  final String paymentName;
  final int value;
  final int? groupValue;
  final bool isSelected;
  final void Function(int?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: PsDimens.space10),
      decoration: BoxDecoration(
        color: Utils.isLightMode(context)
            ? PsColors.achromatic50
            : PsColors.achromatic700,
        border: Border.all(
            color: isSelected ? PsColors.primary500 : PsColors.achromatic100),
        borderRadius: BorderRadius.circular(PsDimens.space4),
      ),
      child: RadioListTile<int>(
          contentPadding: const EdgeInsets.only(
              right: PsDimens.space6, left: PsDimens.space16),
          activeColor: PsColors.primary500,
          controlAffinity: ListTileControlAffinity.trailing,
          selected: isSelected,
          title: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(
                      right: PsDimens.space14,
                      left: Directionality.of(context) == TextDirection.ltr
                          ? 0
                          : PsDimens.space14),
                  padding: EdgeInsets.only(
                      right: (Directionality.of(context) == TextDirection.ltr)
                          ? 0
                          : PsDimens.space8),
                  width: PsDimens.space40,
                  height: PsDimens.space40,
                  child: image),
              Text(
                paymentName,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic900
                        : PsColors.achromatic50,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          value: value,
          groupValue: groupValue,
          onChanged: onChanged),
    );
  }
}
