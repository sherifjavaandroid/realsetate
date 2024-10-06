import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:psxmpc/core/vendor/constant/ps_dimens.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../core/vendor/utils/utils.dart';

class LinkInfo extends StatelessWidget {
  const LinkInfo({
    Key? key,
    this.icon,
    this.imageName,
    required this.title,
    required this.link,
  }) : super(key: key);

  final IconData? icon;
  final String? imageName;
  final String title;
  final String? link;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: PsDimens.space12),
      child: InkWell(
        onTap: () async {
          if (link != null && await canLaunchUrl(Uri.parse(link!))) {
            await launchUrl(Uri.parse(link ?? ''));
          } else {
            throw 'Could not launch $link';
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: PsDimens.space10, vertical: PsDimens.space8),
          height: PsDimens.space40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PsDimens.space4),
            border: Border.all(
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic300
                    : PsColors.achromatic50),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (icon != null)
                Icon(
                  icon,
                  size: PsDimens.space20,
                )
              else if (imageName != null)
                SizedBox(
                  width: PsDimens.space20,
                  height: PsDimens.space19,
                  child: SvgPicture.asset(imageName!,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor, BlendMode.srcIn)),
                ),
              const SizedBox(
                width: PsDimens.space10,
              ),
              Flexible(
                child: Text(
                  link ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Utils.isLightMode(context)
                          ? PsColors.text800
                          : PsColors.text50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
