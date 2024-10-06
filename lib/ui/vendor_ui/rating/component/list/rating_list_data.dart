import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/vendor/provider/rating/rating_list_provider.dart';
import '../../../../custom_ui/rating/component/list/rating_list_item.dart';

class RatingListData extends StatelessWidget {
  const RatingListData({Key? key, required this.itemUserId}) : super(key: key);
  final String itemUserId;

  @override
  Widget build(BuildContext context) {
    final RatingListProvider ratingProvider =
        Provider.of<RatingListProvider>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CustomRatingListItem(
              rating: ratingProvider.getListIndexOf(index),
              itemUserId: itemUserId);
        },
        childCount: ratingProvider.dataLength,
      ),
    );
  }
}
