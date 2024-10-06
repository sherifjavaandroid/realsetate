import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/gallery/gallery_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/repository/gallery_repository.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../custom_ui/item/detail/component/appbar/widgets/discount_widget.dart';
import '../../../../../../custom_ui/item/detail/component/appbar/widgets/featured_widget.dart';
import '../../../../../../custom_ui/item/detail/component/appbar/widgets/paid_ad_status_widget.dart';
import '../../../../../../custom_ui/item/detail/component/appbar/widgets/sold_out_widget.dart';
import '../../../../../common/base/ps_widget_with_appbar_no_app_bar_title.dart';
import '../../../../../common/ps_ui_widget.dart';
import '../../../../../common/shimmer_item.dart';

class ProductDetailGalleryView extends StatefulWidget {
  const ProductDetailGalleryView({
    Key? key,
  }) : super(key: key);

  @override
  ProductDetailGalleryViewState<ProductDetailGalleryView> createState() =>
      ProductDetailGalleryViewState<ProductDetailGalleryView>();
}

class ProductDetailGalleryViewState<T extends ProductDetailGalleryView>
    extends State<ProductDetailGalleryView> {
  bool bindDataOneTime = true;
  String? selectedId;
  int selectedIndex = 0;
  bool isHaveVideo = false;
  DefaultPhoto? selectedDefaultImage;
  late ItemDetailProvider itemDetailProvider;
  late GalleryProvider provider;

  @override
  Widget build(BuildContext context) {
    itemDetailProvider = Provider.of<ItemDetailProvider>(context);
    final Product product = itemDetailProvider.product;
    selectedDefaultImage =
        product.defaultPhoto; //to show first image as default photo
    if (product.videoThumbnail!.imgPath != '') {
      isHaveVideo = true;
    } else {
      isHaveVideo = false;
    }
    final GalleryRepository galleryRepo =
        Provider.of<GalleryRepository>(context);
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    print(
        '............................Build UI Again ............................');
    return PsWidgetWithAppBarNoAppBarTitle<GalleryProvider>(
      initProvider: () {
        return GalleryProvider(repo: galleryRepo);
      },
      onProviderReady: (GalleryProvider provider) {
        provider.loadDataList(
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(valueHolder),
                languageCode: langProvider.currentLocale.languageCode,
                parentImgId: selectedDefaultImage?.imgParentId,
                imageType: PsConst.ITEM_IMAGE_TYPE));
      },
      builder: (BuildContext context, GalleryProvider provider, Widget? child) {
        if (
            //provider.galleryList != null &&
            provider.galleryList.data != null &&
                provider.galleryList.data!.isNotEmpty) {
          if (bindDataOneTime) {
            if (valueHolder.showItemVideo! && isHaveVideo) {
              provider.tempGalleryList.data!.add(product.videoThumbnail!);
              for (int i = 0;
                  i < valueHolder.maxImageCount &&
                      i < provider.galleryList.data!.length;
                  i++) {
                provider.tempGalleryList.data!
                    .add(provider.galleryList.data![i]);
              }
            } else {
              for (int i = 0;
                  i < valueHolder.maxImageCount &&
                      i < provider.galleryList.data!.length;
                  i++) {
                provider.tempGalleryList.data!
                    .add(provider.galleryList.data![i]);
              }
            }

            for (int i = 0; i < provider.tempGalleryList.data!.length; i++) {
              if (selectedDefaultImage!.imgId ==
                  provider.tempGalleryList.data![i].imgId) {
                selectedIndex = i;
                selectedId = selectedDefaultImage!.imgId;
                break;
              }
            }
            bindDataOneTime = false;
          }
          /**UI Section is here */
          return Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: PsNetworkImageWithUrl(
                      photoKey: '',
                      width: double.infinity,
                      height: 300,
                      imageAspectRation: PsConst.Aspect_Ratio_1x,
                      imagePath:
                          provider.tempGalleryList.data![selectedIndex].imgPath,
                      boxfit: BoxFit.cover,
                      onTap: goToGalleryList,
                    ),
                  ),
                  if (valueHolder.showItemVideo! &&
                      isHaveVideo &&
                      selectedIndex == 0)
                    Positioned(
                      left: 1,
                      right: 1,
                      bottom: 1,
                      top: 1,
                      child: GestureDetector(
                        onTap: goToGalleryList,
                        child: Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            child: const Icon(
                              Icons.play_circle,
                              color: Colors.black38,
                              size: 80,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (Utils.isOwnerItem(valueHolder, product))
                          CustomPaidAdStatusWidget()
                        else if (!Utils.isOwnerItem(valueHolder, product) &&
                            product.isPaidAdInProgress)
                          CustomFeaturedWidget(),
                        if (product.isDiscountedItem) CustomDiscountWidget()
                      ],
                    ),
                  ),
                  if (product.isSoldOutItem)
                    Positioned(
                        right: 10, bottom: 10, child: CustomSoldOutWidget()),
                ],
              ),
              const SizedBox(
                height: PsDimens.space8,
              ),
              Flexible(
                child: SizedBox(
                  height: 92,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.tempGalleryList.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(
                            right:
                                Directionality.of(context) == TextDirection.ltr
                                    ? PsDimens.space19
                                    : 0,
                            left:
                                Directionality.of(context) != TextDirection.ltr
                                    ? PsDimens.space19
                                    : 0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                // border: Border.all(
                                //     color: (index == selectedIndex)
                                //         ? PsColors.transparent
                                //         : Colors.transparent,
                                //     width: 2)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: PsNetworkImageWithUrl(
                                  photoKey: '',
                                  width: 92,
                                  imageAspectRation: PsConst.Aspect_Ratio_1x,
                                  imagePath: provider
                                      .tempGalleryList.data![index].imgPath,
                                  onTap: () {
                                    onImageTap(index);
                                  },
                                  boxfit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (valueHolder.showItemVideo! &&
                                isHaveVideo &&
                                index == 0 &&
                                provider.tempGalleryList.data![index].imgType !=
                                    PsConst.ITEM_IMAGE_TYPE)
                              Positioned(
                                bottom: 1,
                                left: 1,
                                right: 1,
                                top: 1,
                                child: InkWell(
                                  onTap: () {
                                    onImageTap(index);
                                  },
                                  child: const Icon(
                                    Icons.play_circle_outline,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return const ShimmerItem();
        }
      },
    );
  }

  void onImageTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void goToGalleryList() {
    Navigator.pushNamed(context, RoutePaths.galleryGrid,
        arguments: itemDetailProvider.product);
  }
}
