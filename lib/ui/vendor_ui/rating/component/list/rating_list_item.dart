import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/rating/rating_list_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/rating_list_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../core/vendor/viewobject/rating.dart';
import '../../../../custom_ui/rating/component/dialog/rating_input_dialog.dart';
import '../../../common/smooth_star_rating_widget.dart';

class RatingListItem extends StatelessWidget {
  const RatingListItem({
    Key? key,
    required this.rating,
    required this.itemUserId,
  }) : super(key: key);

  final Rating rating;
  final String itemUserId;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Utils.isLightMode(context)
          ? PsColors.achromatic50
          : PsColors.achromatic900,
      // margin: const EdgeInsets.only(top: PsDimens.space4),
      child: Ink(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _RatingListDataWidget(
              rating: rating,
              itemUserId: itemUserId,
            ),
            // const Divider(
            //   height: PsDimens.space1,
            // ),
          ],
        ),
      ),
    );
  }
}

class _RatingListDataWidget extends StatefulWidget {
  const _RatingListDataWidget({
    Key? key,
    required this.rating,
    required this.itemUserId,
  }) : super(key: key);

  final Rating rating;
  final String itemUserId;

  @override
  __RatingListDataWidgetState createState() => __RatingListDataWidgetState();
}

class __RatingListDataWidgetState extends State<_RatingListDataWidget> {
  late PsValueHolder psValueHolder;
  RatingListHolder? ratingListHolder;
  RatingListProvider? ratingListProvider;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    ratingListProvider = Provider.of<RatingListProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final AppLocalization langProvider = Provider.of<AppLocalization>(context);

    final Widget _ratingStarsWidget = SmoothStarRating(
        key: Key(widget.rating.rating!),
        rating: double.parse(widget.rating.rating!),
        allowHalfRating: true,
        isReadOnly: true,
        starCount: 5,
        size: PsDimens.space16,
        color: PsColors.warning500,
        borderColor: PsColors.achromatic500.withAlpha(100),
        spacing: 0.0);

    const Widget _spacingWidget = SizedBox(
      height: PsDimens.space8,
    );
    final Widget _titleTextWidget = Text(
      widget.rating.title!,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(fontWeight: FontWeight.bold),
    );
    final Widget _descriptionTextWidget = Text(
      widget.rating.description!,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
    );
    final Widget _dateTextWidget = Text(
      widget.rating.addedDateStr!,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: PsColors.achromatic500),
    );
    final Widget _userNameTextWidget = Text(
      widget.rating.fromUser!.name!,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(),
    );
    return Padding(
      padding: const EdgeInsets.all(PsDimens.space12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (psValueHolder.loginUserId != '' &&
              psValueHolder.loginUserId == widget.rating.fromUser!.userId)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _userNameTextWidget,
                InkWell(
                  child: Container(
                    child: Text('Edit',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Theme.of(context).primaryColor)),
                  ),
                  onTap: () async {
                    final dynamic data = await showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomRatingInputDialog(
                              buyerUserId: widget.rating.fromUser!.userId,
                              sellerUserId: widget.rating.toUser!.userId,
                              rating: widget.rating);
                        });
                    if (data == '1') {
                      ratingListHolder = RatingListHolder(
                          userId: widget.itemUserId,
                          type: PsConst.RATING_TYPE_USER);
                      await ratingListProvider?.loadDataList(
                          requestBodyHolder: ratingListHolder,
                          requestPathHolder: RequestPathHolder(
                              loginUserId:
                                  Utils.checkUserLoginId(psValueHolder),
                              headerToken: psValueHolder.headerToken,
                              languageCode:
                                  langProvider.currentLocale.languageCode));
                      userProvider.userParameterHolder.loginUserId =
                          userProvider.psValueHolder!.loginUserId;
                      userProvider.userParameterHolder.id = widget.itemUserId;
                      userProvider.getOtherUserData(
                          userProvider.userParameterHolder.toMap(),
                          widget.itemUserId,
                          langProvider.currentLocale.languageCode);
                    }
                  },
                ),
              ],
            )
          else
            _userNameTextWidget,
          _ratingStarsWidget,
          _spacingWidget,
          _titleTextWidget,
          _spacingWidget,
          _descriptionTextWidget,
          _spacingWidget,
          _dateTextWidget
        ],
      ),
    );
  }
}
