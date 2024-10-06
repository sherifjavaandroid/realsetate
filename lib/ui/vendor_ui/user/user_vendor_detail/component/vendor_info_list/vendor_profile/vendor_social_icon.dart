import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class VendorSocialIcon extends StatelessWidget {
  const VendorSocialIcon({
    Key? key,
    this.imageName,
    this.onTap,
  }) : super(key: key);

  final String? imageName;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: PsDimens.space6),
        child: Container(
          width: PsDimens.space40,
          height: PsDimens.space24,
          child: SvgPicture.asset(
            imageName!,
          ),
        ),
      ),
    );
  }
}
