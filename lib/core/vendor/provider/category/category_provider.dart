import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/db/common/ps_data_source_manager.dart';

import '../../../../core/vendor/provider/common/ps_init_provider.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../api/common/ps_resource.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import '../../repository/category_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/category.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/category_parameter_holder.dart';
import '../common/ps_provider.dart';

class CategoryProvider extends PsProvider<Category> {
  CategoryProvider({
    required BuildContext context,
    int limit = 0,
  }) : super(initRepo(context), getLimit(context, limit),
            subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  static CategoryRepository initRepo(BuildContext context) {
    return CategoryRepository(
        psApiService: Provider.of<PsApiService>(context, listen: false));
  }

  static int getLimit(BuildContext context, int limit) {
    if (limit > 0) {
      return limit;
    }

    return Provider.of<PsValueHolder>(context, listen: false)
        .categoryLoadingLimit!;
  }

  CategoryParameterHolder categoryParameterHolder =
      CategoryParameterHolder().getLatestParameterHolder();

  CategoryParameterHolder trendingCategoryParameterHolder =
      CategoryParameterHolder().getTrendingParameterHolder();

  late String catId = '';

  PsResource<List<Category>> get categoryList => super.dataList;
}

SingleChildWidget initCategoryProvider(BuildContext context, Function function,
    {Widget? widget, String? keyword, String? languageCode}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  return psInitProvider<CategoryProvider>(
      widget: widget,
      initProvider: () {
        return CategoryProvider(context: context);
      },
      onProviderReady: (CategoryProvider provider) {
        if (keyword!.isNotEmpty)
          provider.categoryParameterHolder.keyword = keyword;
        provider.loadDataList(
            dataConfig:
                DataConfiguration(dataSourceType: DataSourceType.SERVER_DIRECT),
            requestBodyHolder: provider.categoryParameterHolder,
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(valueHolder),
                languageCode: languageCode));
        function(provider);
      });
}
