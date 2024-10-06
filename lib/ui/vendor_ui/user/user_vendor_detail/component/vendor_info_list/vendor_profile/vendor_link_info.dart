import 'package:flutter/material.dart';
import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

class VendorLinkInfo extends StatelessWidget {
  const VendorLinkInfo({
    Key? key,
    this.icon,
    this.imageName,
    this.title,
    required this.link,
    this.onTap,
  }) : super(key: key);

  final IconData? icon;
  final String? imageName;
  final String? title;
  final String? link;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return (link != '')
        ? InkWell(
            onTap: onTap as void Function()?,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: PsDimens.space6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Utils.isLightMode(context)
                        ? PsColors.text500
                        : PsColors.achromatic400,
                    size: 16,
                  ),
                  const SizedBox(
                    width: PsDimens.space10,
                  ),
                  Text(
                    link ?? '',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Utils.isLightMode(context)
                            ? PsColors.achromatic600
                            : PsColors.achromatic50),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
