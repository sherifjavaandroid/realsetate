import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/db/common/ps_data_source_manager.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/provider/product/related_product_provider.dart';
import '../../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../custom_ui/item/list_item/product_horizontal_list_widget.dart';
import '../../../../common/ps_list_header_widget.dart';

class RelatedProductListWidget extends StatefulWidget {
  @override
  State<RelatedProductListWidget> createState() =>
      _RelatedProductListWidgetState();
}

class _RelatedProductListWidgetState extends State<RelatedProductListWidget> {
  bool isFirstTime = false;
ProductRepository? productRepository;
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  productRepository = Provider.of<ProductRepository>(context);
    final Product product = itemDetailProvider.product;

    return SliverToBoxAdapter(
        child: itemDetailProvider.hasData
           ? ChangeNotifierProvider<RelatedProductProvider>(
              lazy: false,
               create: (BuildContext context) {
        final RelatedProductProvider provider =
            RelatedProductProvider(repo:productRepository!,psValueHolder:valueHolder );
       provider.loadRelatedProductList(
                          dataConfiguration: DataConfiguration(
                              dataSourceType: DataSourceType.SERVER_DIRECT),
                          productId: product.id,
                          categoryId: product.catId!,
                          loginUserId: Utils.checkUserLoginId(valueHolder),
                          languageCode: valueHolder.languageCode);
                          return provider;
      },
        child:Consumer<RelatedProductProvider>(
                  builder: (BuildContext context,
                      RelatedProductProvider relatedProductProvider,
                      Widget? child) {
                    // if (!isFirstTime) {
                    //   relatedProductProvider.loadRelatedProductList(
                    //       dataConfiguration: DataConfiguration(
                    //           dataSourceType: DataSourceType.SERVER_DIRECT),
                    //       productId: product.id,
                    //       categoryId: product.catId!,
                    //       loginUserId: Utils.checkUserLoginId(valueHolder),
                    //       languageCode: valueHolder.languageCode);
                    //   isFirstTime = true;
                    // }
                    return relatedProductProvider.hasData
                        ? Column(
                            children: <Widget>[
                              PsListHeaderWidget(
                                headerName:
                                    'related_product_tile__related_product'.tr,
                                headerDescription: '',
                                viewAllClicked: () {
                                  viewAllRelatedItemsClicked(context);
                                },
                              ),
                              CustomProductHorizontalListWidget(
                                tagKey:
                                    relatedProductProvider.hashCode.toString(),
                                productList: relatedProductProvider
                                    .relatedProductList.data?.toSet().toList(),
                                isLoading: relatedProductProvider.currentStatus ==
                                    PsStatus.BLOCK_LOADING,
                              ),
                              const SizedBox(height: PsDimens.space8,)
                            ],
                          )
                        : const SizedBox();
                  },
                ),
          ) : const SizedBox());

  }
    void viewAllRelatedItemsClicked(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context, listen: false);
    Navigator.pushNamed(context, RoutePaths.relatedProductList,
        arguments: RequestPathHolder(
            categoryId: itemDetailProvider.product.catId,
            productId: itemDetailProvider.product.id));
  }
}


