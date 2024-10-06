// import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../config/ps_config.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/holder/widget_provider_dyanmic.dart';
import '../../../custom_ui/category/component/menu_vertical/widgets/category_sort_widget.dart';
import '../../../vendor_ui/common/ps_back_button_with_circle_bg_widget.dart';
import '../../../vendor_ui/sort_widget/ps_dynamic_provider.dart';
import '../../../vendor_ui/sort_widget/ps_dynamic_widget.dart';
import '../../common/ps_admob_banner_widget.dart';
import '../../common/ps_app_bar_widget.dart';
import '../../common/search_bar_view.dart';

class CategorySortingListViewContainer extends StatefulWidget {
  const CategorySortingListViewContainer({this.keyword = ''});
  final String keyword;
  @override
  _CategorySortingListViewState createState() {
    return _CategorySortingListViewState();
  }
}

class _CategorySortingListViewState
    extends State<CategorySortingListViewContainer>
    with SingleTickerProviderStateMixin {
  CategoryProvider? _categoryProvider;
  late SearchBarView searchBar;
  late TextEditingController searchTextController = TextEditingController();
  AnimationController? animationController;
  PsValueHolder? psValueHolder;
  bool isConnectedToInternet = false;
  bool isSuccessfullyLoaded = true;
  late AppLocalization langProvider;
  final ScrollController scrollController = ScrollController();

  void resetCategoryListByKeyword(String value) {
    if (_categoryProvider != null) {
      _categoryProvider!.categoryParameterHolder.keyword = value.trim();
      _categoryProvider!.loadDataList(
        reset: true,
      );
    }
  }

  PsAppbarWidget buildAppBar(BuildContext context) {
    searchTextController.clear();
    return PsAppbarWidget(
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: PsBackButtonWithCircleBgWidget(
            leftColor: (psValueHolder!.languageCode == 'ar')
                ? PsColors.achromatic50.withAlpha(50)
                : PsColors.achromatic50,
            rightColor: (psValueHolder!.languageCode == 'ar')
                ? PsColors.achromatic50
                : PsColors.achromatic50.withAlpha(50)),
      ),
      appBarTitle: 'category_property_types'.tr,
      actionWidgets: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: PsDimens.space10),
          child: IconButton(
            icon: const Icon(
              Remix.search_line,
            ),
            onPressed: () async {
              final dynamic result = await Navigator.pushNamed(
                  context, RoutePaths.serachCategoryHistoryList,
                  arguments: _categoryProvider!.categoryParameterHolder);

              if (result != null) {
                _categoryProvider!.categoryParameterHolder = result;
                _categoryProvider!.loadDataList(
                    reset: true,
                    requestBodyHolder:
                        _categoryProvider!.categoryParameterHolder,
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(psValueHolder!),
                        languageCode: langProvider.currentLocale.languageCode));

                // searchBar.beginSearch(context);
              }
            },
          ),
        ),
        // Padding(
        //   padding:const EdgeInsets.only(right: PsDimens.space8),
        //   child: IconButton(
        //     icon: Icon(Icons.notification_add, color: PsColors.cBlueColor),
        //     onPressed: () {},
        //   ),
        // )
      ],
    );
  }

  void checkConnection() {
    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
      if (isConnectedToInternet && psValueHolder!.isShowAdmob!) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    searchBar = SearchBarView(
        inBar: true,
        controller: searchTextController,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted:
            resetCategoryListByKeyword, //search categories after keyword is submitted
        closeOnSubmit: false,
        onCleared: () {
          print('cleared');
        },
        onClosed: () {
          resetCategoryListByKeyword('');
        });
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print("category vertical");
    timeDilation = 1.0;
    langProvider = Provider.of<AppLocalization>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    if (!isConnectedToInternet && psValueHolder!.isShowAdmob!) {
      print('loading ads....');
      checkConnection();
    }

    final WidgetProviderDynamic widgetProviderDynamic =
        Utils.psWidgetToProvider(PsConfig.categoryVerticalList);

    return MultiProvider(
        providers: psDynamicProvider(context, (Function fn) {},
            providerList: widgetProviderDynamic.providerList!,
            mounted: mounted, categoryProvider: (CategoryProvider pro) {
          _categoryProvider = pro;
        }, keyword: widget.keyword),
        child: Scaffold(
          appBar: searchBar.build(context),
          body: Column(
            children: <Widget>[
              const PsAdMobBannerWidget(),
              CustomCategorySortWidget(),
              Expanded(
                child: PsDynamicWidget(
                  animationController: animationController!,
                  scrollController: scrollController,
                  widgetList: widgetProviderDynamic.widgetList,
                ),
              ),
            ],
          ),
        ));
  }
}

// class MyArc extends StatelessWidget {
//   final double diameter;

//   const MyArc({this.diameter = 200});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: MyPainter(),
//       size: Size(diameter, diameter),
//     );
//   }
// }

// // This is the Painter class
// class MyPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Colors.blue;
//     canvas.drawArc(
//       Rect.fromCenter(
//         center: Offset(size.height / 2, size.width / 2),
//         height: size.height,
//         width: size.width,
//       ),
//       math.pi,
//       math.pi,
//       false,
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
