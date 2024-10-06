import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../../config/ps_config.dart';
import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/vendor_application/vendor_branch_provider.dart';
import '../../../../../core/vendor/provider/vendor_application/vendor_item_provider.dart';
import '../../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';
import '../../../../../core/vendor/provider/vendor_application/vendor_user_provider.dart';
import '../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../core/vendor/repository/vendor_branch_repository.dart';
import '../../../../../core/vendor/repository/vendor_user_repository.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/user/user_vendor_detail/component/detail_info/other_user_store_detail_info_widget.dart';
import '../../../../custom_ui/user/user_vendor_detail/component/detail_info/widgets/other_user_vendor_item_card_widget.dart';
import '../../../../custom_ui/user/user_vendor_detail/component/detail_info/widgets/other_user_vendor_item_count.dart';
import '../../../../custom_ui/user/user_vendor_detail/component/detail_info/widgets/other_user_vendor_joined_datetime_widget.dart';
import '../../../../custom_ui/user/user_vendor_detail/component/detail_info/widgets/other_user_vendor_logo_photo.dart';
import '../../../../custom_ui/user/user_vendor_detail/component/vendor_info_list/vendor_profile_view.dart';
import '../../../common/ps_app_bar_widget.dart';

class UserVendorDetailView extends StatefulWidget {
  const UserVendorDetailView({
    required this.vendorId,
    required this.vendorUserId,
    required this.vendorUserName,
  });
  final String? vendorId;
  final String? vendorUserId;
  final String? vendorUserName;
  @override
  _UserShoreDetailViewState createState() => _UserShoreDetailViewState();
}

class _UserShoreDetailViewState extends State<UserVendorDetailView>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    tabController = TabController(length: 1, vsync: this);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        vendorItemProvider?.loadNextDataList();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    tabController.dispose();
    super.dispose();
  }

  PsValueHolder? psValueHolder;
  late AppLocalization langProvider;
  VendorUserProvider? vendorUserProvider;
  VendorUserRepository? vendorUserRepository;
  ProductRepository? productRepository;
  VendorBranchProvider? vendorBranchProvider;
  VendorBranchRepository? vendorBranchRepository;
  VendorUserDetailProvider? vendorUserDetailProvider;
  VendorItemProvider? vendorItemProvider;

  @override
  Widget build(BuildContext context) {
    vendorBranchRepository = Provider.of<VendorBranchRepository>(context);
    vendorUserRepository = Provider.of<VendorUserRepository>(context);
    productRepository = Provider.of<ProductRepository>(context);
    langProvider = Provider.of<AppLocalization>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    Future<bool> _requestPop() {
      animationController.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    print(
        '............................Build UI Again ............................');

    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<VendorUserDetailProvider?>(
              lazy: false,
              create: (BuildContext context) {
                vendorUserDetailProvider = VendorUserDetailProvider(
                    repo: vendorUserRepository, psValueHolder: psValueHolder);
                //  vendorUserProvider.getVendorById(psValueHolder!.loginUserId,'13',psValueHolder!.loginUserId!);
                vendorUserDetailProvider?.loadData(
                    requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder),
                  vendorId: widget.vendorId,
                  ownerUserId: Utils.checkUserLoginId(psValueHolder),
                ));
                return vendorUserDetailProvider;
              }),
          //
          ChangeNotifierProvider<VendorItemProvider?>(
              lazy: false,
              create: (BuildContext context) {
                vendorItemProvider = VendorItemProvider(
                  context: context,
                );
                vendorItemProvider?.getVendorItemParameterHolder.vendorId =
                    widget.vendorId;
                vendorItemProvider?.loadDataList(
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(psValueHolder),
                        languageCode: langProvider.currentLocale.languageCode),
                    requestBodyHolder:
                        vendorItemProvider?.getVendorItemParameterHolder);
                return vendorItemProvider;
              }),
          ChangeNotifierProvider<VendorBranchProvider>(
              lazy: false,
              create: (BuildContext context) {
                final VendorBranchProvider vendorUserProvider =
                    VendorBranchProvider(
                  repo: vendorBranchRepository,
                );
                vendorUserProvider.vendorBranchParameterHolder.vendorId =
                    widget.vendorId;
                vendorUserProvider.loadDataList(
                    requestBodyHolder:
                        vendorUserProvider.vendorBranchParameterHolder,
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(psValueHolder),
                        languageCode: langProvider.currentLocale.languageCode));
                //vendorUserProvider.user = widget.vendorUser;
                return vendorUserProvider;
              }),
        ],
        child: Consumer3<VendorUserDetailProvider, VendorBranchProvider,
                VendorItemProvider>(
            builder: (BuildContext context,
                VendorUserDetailProvider vendorUserDetailProvider,
                VendorBranchProvider vendorBranchProvider,
                VendorItemProvider vendorItemProvider,
                Widget? child) {
          /**
                   * UI SECTION
                   */
          return PopScope(
              canPop: true,
              onPopInvoked: (bool didPop) async {
                if (didPop) {
                  return;
                }
                _requestPop();
              },
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: PsAppbarWidget(
                    appBarTitle: widget.vendorUserName ?? '',
                  ),
                  body: NestedScrollView(
                    controller: scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          floating: true,
                          pinned: false,
                          expandedHeight:
                              MediaQuery.of(context).size.height / 2.43,
                          flexibleSpace: FlexibleSpaceBar(
                              background: Column(
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.9,
                                child: Stack(
                                  children: <Widget>[
                                    if (vendorUserDetailProvider.hasData)
                                      CustomOtherUserVendorDetailWidget(
                                        animationController:
                                            animationController,
                                      )
                                    else
                                      const SizedBox(),
                                    Positioned(
                                      right: PsDimens.space50,
                                      left: PsDimens.space50,
                                      bottom: 0,
                                      child: Card(
                                        elevation: PsDimens.space2,
                                        color: Utils.isLightMode(context)
                                            ? PsColors.achromatic50
                                            : PsColors.achromatic800,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                PsDimens.space8)),
                                        child: Container(
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6.1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical:
                                                            PsDimens.space8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      vendorUserDetailProvider
                                                              .vendorUserDetail
                                                              .data
                                                              ?.name ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16),
                                                      maxLines: 1,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: PsDimens
                                                                  .space4),
                                                      child: Image.asset(
                                                        'assets/images/storefont.png',
                                                        width: PsDimens.space16,
                                                        height:
                                                            PsDimens.space16,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  CustomOtherUserVendorItemCount(),
                                                  CustomOtherUserVendorJoinDateTimeWidget()
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Stack(children: <Widget>[
                                        CustomOtherUserVendorLogoPhoto(),
                                        Positioned(
                                          right: -1,
                                          bottom: -1,
                                          child: Icon(
                                            Icons.verified_user,
                                            color: PsColors.info500,
                                            size: PsDimens.space16,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              TabBar(
                                labelColor: PsColors.primary500,
                                indicatorColor: PsColors.primary500,
                                indicatorSize: TabBarIndicatorSize.tab,
                                tabs: <Widget>[
                                  Tab(
                                    text: 'vendor_home'.tr,
                                  ),
                                  Tab(
                                    text: 'vendor_profile'.tr,
                                  ),
                                ],
                              ),
                            ],
                          )),
                        ),
                      ];
                    },
                    body: TabBarView(children: <Widget>[
                      CustomOtherUserVendorItemCardWidget(
                        isLoading: vendorItemProvider.currentStatus ==
                            PsStatus.BLOCK_LOADING,
                      ),
                      CustomVendorProfileView(),
                    ]),
                  ),
                ),
              ));
        }));
  }
}
