import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../../../../custom_ui/user/user_vendor_detail/component/vendor_info_list/vendor_profile/vendor_link_info.dart';

class VendorBranchItem extends StatelessWidget {
  const VendorBranchItem({
    Key? key,
    required this.vendorBranch,
    this.onTap,
  }) : super(key: key);

  final VendorUser vendorBranch;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(PsDimens.space12),
      padding: const EdgeInsets.symmetric(
          horizontal: PsDimens.space10, vertical: PsDimens.space12),
      decoration: BoxDecoration(
          color: Utils.isLightMode(context)
              ? PsColors.achromatic50
              : PsColors.achromatic700,
          border: Border.all(
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic100
                  : PsColors.achromatic700)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Widget>[
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: <Widget>[
          // Stack(children: <Widget>[
          //   Container(
          //     child: SizedBox(
          //       width: PsDimens.space80,
          //       height: PsDimens.space80,
          //       child: PsNetworkCircleImageForUser(
          //         photoKey: '',
          //         imagePath: vendorBranch.logo!.imgPath,
          //         boxfit: BoxFit.cover,
          //         onTap: () {
          //           //onDetailClick(context);
          //         },
          //       ),
          //     ),
          //   ),
          //   if (vendorBranch.isVendorUser)
          //     Positioned(
          //       right: -1,
          //       bottom: -1,
          //       child: Icon(
          //         Icons.verified_user,
          //         color: PsColors.info500,
          //         size: 20,
          //       ),
          //     ),
          // ]),
          // const SizedBox(width: PsDimens.space8),
          Text(
            vendorBranch.name ?? '',
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          //   ],
          // ),
          //           MaterialButton(
          //   height: 40,
          //   minWidth: 40,
          //  color: PsColors.achromatic50,
          //   child: Text(
          //     'View Store'.tr,
          //     style: Theme.of(context).textTheme.labelLarge?.copyWith(
          //         color: Utils.isLightMode(context) ? PsColors.text800 : PsColors.achromatic800, fontWeight: FontWeight.normal),
          //   ),
          //   shape: RoundedRectangleBorder(side: BorderSide(color: PsColors.text100),borderRadius: BorderRadius.circular(5.0)),
          //   onPressed: onTap as void Function(),
          // ),
          // ],
          // ),
          Padding(
            padding: const EdgeInsets.only(top: PsDimens.space6),
            child: Text(vendorBranch.description ?? '',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    // color: Utils.isLightMode(context)
                    //     ? PsColors.primary500
                    //     : PsColors.text400,
                    fontSize: 12)),
          ),

          CustomVendorLinkInfo(
            icon: Icons.phone_outlined,
            link: vendorBranch.phone,
            onTap: () async {
              if (await canLaunchUrl(
                  Uri.parse('tel://${vendorBranch.phone}'))) {
                await launchUrl(Uri.parse('tel://${vendorBranch.phone}'));
              } else {
                throw 'Could not Call Phone Number 1';
              }
            },
          ),
          CustomVendorLinkInfo(
              icon: Icons.location_on_outlined,
              title: 'shop_info__visit_our_website'.tr,
              link: vendorBranch.address),
        ],
        // ),
      ),
    );
  }
}
