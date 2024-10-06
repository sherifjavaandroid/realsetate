import 'package:flutter/material.dart';
import '../../../../../core/vendor/viewobject/rating.dart';
import '../../../../vendor_ui/rating/component/list/rating_list_item.dart';

class CustomRatingListItem extends StatelessWidget {
  const CustomRatingListItem({
    Key? key,
    required this.rating,
    required this.itemUserId,
  }) : super(key: key);

  final Rating rating;
  final String itemUserId;

  @override
  Widget build(BuildContext context) {
    return RatingListItem(rating: rating, itemUserId: itemUserId);
  }
}
