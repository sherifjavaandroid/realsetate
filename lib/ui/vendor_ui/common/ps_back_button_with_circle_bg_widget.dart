import 'package:flutter/material.dart';
import '../../../../../config/ps_colors.dart';
import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';
import 'piant_circle_border.dart';

class PsBackButtonWithCircleBgWidget extends StatelessWidget {
  const PsBackButtonWithCircleBgWidget({
    Key? key,
    this.leftColor,
    this.rightColor,
  }) : super(key: key);

  final Color? leftColor;
  final Color? rightColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(PsDimens.space10),
        child: CustomPaint(
          painter: PaintCircleBorder(
            borderThinckness: 3.5,
            leftColor: leftColor ??
                (Utils.isLightMode(context)
                    ? PsColors.achromatic800.withAlpha(30)
                    : PsColors.achromatic50),
            rightColor: rightColor ??
                (Utils.isLightMode(context)
                    ? PsColors.achromatic50
                    : PsColors.achromatic50.withAlpha(50)),
          ),
          child: Container(
            margin: const EdgeInsets.all(PsDimens.space6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: PsColors.achromatic50,
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                    left: PsDimens.space6, right: PsDimens.space6),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context, true);
      },
    );
  }
}
