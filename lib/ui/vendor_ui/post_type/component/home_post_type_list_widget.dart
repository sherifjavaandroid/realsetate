import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/product/customize_ui_detail_provider.dart';
import '../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../core/vendor/viewobject/entry_product_relation.dart';
import '../../../../core/vendor/viewobject/holder/intent_holder/product_list_intent_holder.dart';
import '../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';

class HomePostTypeHorizontalListWidget extends StatefulWidget {
  const HomePostTypeHorizontalListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  State<StatefulWidget> createState() =>
      _HomePostTypeHorizontalListWidgetState();
}

class _HomePostTypeHorizontalListWidgetState
    extends State<HomePostTypeHorizontalListWidget> {
  List<CustomField> customFieldList = <CustomField>[];
  String postTypeId = 'ps-itm00002';
  String postTypeValue = '';
  CustomField postTypeCustomField = CustomField(visible: '0');
  late CustomizeUiDetailProvider provider;
  @override
  Widget build(BuildContext context) {
    final ItemEntryFieldProvider itemEntryFieldProvider =
        Provider.of<ItemEntryFieldProvider>(context);
    return SliverToBoxAdapter(
      child: Consumer<CustomizeUiDetailProvider>(builder: (BuildContext context,
          CustomizeUiDetailProvider customizeUiDetailProvider, Widget? child) {
        provider = customizeUiDetailProvider;
        final int count = provider.customizeUiDetails.data?.length ?? 0;

        if (provider.hasData &&
            itemEntryFieldProvider.hasData &&
            itemEntryFieldProvider
                .itemEntryField.data!.customField![15].isVisible) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: PsDimens.space16,
                    right: PsDimens.space16,
                    top: PsDimens.space8),
                child: Text('post_type_title'.tr,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 24,
                        color: Utils.isLightMode(context)
                            ? PsColors.accent500
                            : PsColors.primary300,
                        fontWeight: FontWeight.w600)),
              ),
              Container(
                height: PsDimens.space104,
                margin: Directionality.of(context) == TextDirection.ltr
                    ? const EdgeInsets.only(
                        left: PsDimens.space16,
                      )
                    : const EdgeInsets.only(
                        right: PsDimens.space16,
                      ),
                child: ListView.builder(
                    shrinkWrap: false,
                    padding: const EdgeInsets.only(top: PsDimens.space8),
                    scrollDirection: Axis.horizontal,
                    itemCount: count,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            final ProductParameterHolder parameterHolder =
                                ProductParameterHolder()
                                    .getLatestParameterHolder();

                            parameterHolder.productRelation?.add(
                                EntryProductRelation(
                                    coreKeyId: postTypeId,
                                    value: provider
                                        .customizeUiDetails.data![index].id));
                            Navigator.pushNamed(
                                context, RoutePaths.filterProductList,
                                arguments: ProductListIntentHolder(
                                    appBarTitle: provider
                                        .customizeUiDetails.data![index].name!,
                                    productParameterHolder: parameterHolder));
                          },
                          child: PostTypeWidgetItem(
                              data: provider
                                  .customizeUiDetails.data![index].name!));
                    }),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}

class PostTypeWidgetItem extends StatelessWidget {
  const PostTypeWidgetItem({required this.data});

  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: PsDimens.space160,
      //height: PsDimens.space50,
      margin: Directionality.of(context) == TextDirection.ltr
          ? const EdgeInsets.only(
              right: PsDimens.space12,
              top: PsDimens.space20,
              bottom: PsDimens.space20)
          : const EdgeInsets.only(
              left: PsDimens.space12,
              top: PsDimens.space20,
              bottom: PsDimens.space20),
      decoration: BoxDecoration(
        color: Utils.isLightMode(context)
            ? PsColors.achromatic50
            : PsColors.text800,
        borderRadius: const BorderRadius.all(Radius.circular(PsDimens.space28)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: PsColors.achromatic500.withOpacity(0.2),
            spreadRadius: 0.05,
            blurRadius: 0.05,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        left: 10.0,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(PsDimens.space20),
            child: Container(
              width: PsDimens.space40,
              height: PsDimens.space40,
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.only(
                left: PsDimens.space10,
                right: PsDimens.space10,
              ),
              child: SvgPicture.asset(
                'assets/images/fa-solid_laptop-house.svg',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 10),
            child: Text(data,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Utils.isLightMode(context)
                        ? PsColors.accent500
                        : PsColors.primary300,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
