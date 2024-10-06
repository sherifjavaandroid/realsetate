import 'package:flutter/material.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../config/route/route_paths.dart';
import '../../../core/vendor/utils/utils.dart';
import '../../../core/vendor/viewobject/user.dart';
import '../../vendor_ui/common/smooth_star_rating_widget.dart';

class UserRatingWidget extends StatelessWidget {
  const UserRatingWidget({
    Key? key,
    required this.user,
    this.starCount = 1,
  }) : super(key: key);

  final User? user;
  final int starCount;
  @override
  Widget build(BuildContext context) {
    final String? rating =
        user!.overallRating != '' ? user!.overallRating : '0';
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RoutePaths.ratingList,
                arguments: user!.userId);
          },
          child: SmoothStarRating(
              key: Key(rating ?? '0'),
              rating: double.parse(rating ?? '0'),
              allowHalfRating: true,
              isReadOnly: true,
              starCount: 5,
              color: PsColors.warning500,
              size: 22,
              borderColor: PsColors.warning500,
              onRated: (double? v) async {},
              spacing: 0.0),
        ),
        Text(
          '($rating ' + 'product_detail__reviews'.tr + ')',
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Utils.isLightMode(context)
                  ? PsColors.text500
                  : PsColors.text200,
              fontSize: 14),
        ),
      ],
    );
  }
}
