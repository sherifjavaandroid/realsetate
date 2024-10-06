import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../custom_ui/category/component/menu_vertical/widgets/vertical_list/category_sorting_empty_data_box.dart';
import '../../../../../custom_ui/category/component/menu_vertical/widgets/vertical_list/category_vertical_list_item.dart';

class CategoryVerticalListWidget extends StatelessWidget {
  const CategoryVerticalListWidget({required this.animationController});

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(builder:
        (BuildContext context, CategoryProvider provider, Widget? child) {
      final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
      final int count = isLoading ? 5 : provider.dataLength;
      return (provider.hasData ||
              provider.currentStatus == PsStatus.BLOCK_LOADING)
          ? SliverPadding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: PsDimens.space16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return CustomCategoryVerticalListItem(
                      animationController: animationController,
                      animation: curveAnimation(animationController,
                          count: count, index: index),
                      category: isLoading
                          ? Category()
                          : provider.getListIndexOf(index),
                      isLoading: isLoading,
                    );
                  },
                  childCount: count,
                ),
              ),
            )
          : CustomCategorySortingEmptyBox();
    });
  }
}
