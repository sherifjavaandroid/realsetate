import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/common/ps_resource.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import '../../db/product_dao.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/holder/product_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class VendorItemProvider extends PsProvider<Product> {
  VendorItemProvider({
    required BuildContext context,
  }) : super(initRepo(context), 0,
            subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);
  static ProductRepository initRepo(BuildContext context) {
    return ProductRepository(
        psApiService: Provider.of<PsApiService>(context, listen: false),
        productDao: ProductDao.instance);
  }

  final ProductParameterHolder getVendorItemParameterHolder =
      ProductParameterHolder().getVendorItemParameterHolder();
  PsResource<List<Product>> get vendorItemList => super.dataList;
}
