import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/gallery/gallery_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/item_entry_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';

class EditWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  bool showEditButton = true; //to wait images loading
  late PsValueHolder psValueHolder;
  late ItemDetailProvider itemDetailProvider;
  late GalleryProvider galleryProvider;
  String? loginUserId = '';
  late Product product;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    itemDetailProvider = Provider.of<ItemDetailProvider>(context);
    galleryProvider = Provider.of<GalleryProvider>(context);
    loginUserId = Utils.checkUserLoginId(psValueHolder);
    product = itemDetailProvider.product;
    if (!showEditButton) {
      return const SizedBox();
    }
    return InkWell(
      onTap: onOwnerEditButtonClick,
      child: Container(
        padding: const EdgeInsets.all(PsDimens.space10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: PsColors.achromatic50,
        ),
        child: Icon(
          Remix.pencil_line,
          color: Theme.of(context).primaryColor,
          size: 18,
        ),
      ),
    );
  }

  Future<void> onOwnerEditButtonClick() async {
    final dynamic entryData = await Navigator.pushNamed(
        context, RoutePaths.itemEntry,
        arguments: ItemEntryIntentHolder(
          categoryId: product.catId,
          flag: PsConst.EDIT_ITEM, 
          item: itemDetailProvider.product));
    if (entryData != null && entryData is bool && entryData) {
      setState(() {
        showEditButton = false;
      });
      await galleryProvider.loadDataList(
          requestPathHolder: RequestPathHolder(
              parentImgId: itemDetailProvider.product.id,
              imageType: PsConst.ITEM_IMAGE_TYPE));
      itemDetailProvider.loadData(
          requestPathHolder: RequestPathHolder(
              itemId: itemDetailProvider.product.id, loginUserId: loginUserId));
    }
    setState(() {
      showEditButton = true;
    });
  }
}
