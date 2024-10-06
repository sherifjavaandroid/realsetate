import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/db/common/ps_data_source_manager.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/blocked_user_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/user/blocked_user/component/widgets/blocked_user_list_data.dart';
import '../../../common/base/ps_widget_with_multi_provider.dart';
import '../../../common/custom_ui/ps_no_list_data.dart';
import '../../../common/ps_ui_widget.dart';

class BlockedUserListView extends StatefulWidget {
  const BlockedUserListView({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  _BlockedUserListViewState createState() {
    return _BlockedUserListViewState();
  }
}

class _BlockedUserListViewState extends State<BlockedUserListView>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late BlockedUserProvider _blockUserListProvider;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _blockUserListProvider.loadNextDataList();
      }
    });
  }

  late PsValueHolder psValueHolder;
  UserProvider? userProvider;
  UserRepository? userRepo;
  late AppLocalization langProvider;
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    psValueHolder = Provider.of<PsValueHolder>(context);
    userRepo = Provider.of<UserRepository>(context);
    langProvider = Provider.of<AppLocalization>(context);

    return PsWidgetWithMultiProvider(
        child: MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<UserProvider?>(
          lazy: false,
          create: (BuildContext context) {
            userProvider =
                UserProvider(repo: userRepo, psValueHolder: psValueHolder);
            return userProvider;
          },
        ),
        ChangeNotifierProvider<BlockedUserProvider>(
            lazy: false,
            create: (BuildContext context) {
              final BlockedUserProvider provider = BlockedUserProvider(
                  context: context, valueHolder: psValueHolder);
              provider.loadDataList(
                  dataConfig: DataConfiguration(
                      dataSourceType: DataSourceType.SERVER_DIRECT),
                  requestPathHolder: RequestPathHolder(
                      loginUserId: psValueHolder.loginUserId,
                      headerToken: psValueHolder.headerToken,
                      languageCode: langProvider.currentLocale.languageCode));
              return provider;
            })
      ],
      child: Consumer<BlockedUserProvider>(builder:
          (BuildContext context, BlockedUserProvider provider, Widget? child) {
        return Stack(children: <Widget>[
          if (provider.hasData ||
              provider.currentStatus == PsStatus.BLOCK_LOADING ||
              provider.currentStatus == PsStatus.NOACTION)
            Container(
                margin: const EdgeInsets.only(
                    top: PsDimens.space8, bottom: PsDimens.space8),
                child: RefreshIndicator(
                  child: CustomScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      slivers: <Widget>[
                        CustomBlockUserListData(
                            animationController: widget.animationController!),
                      ]),
                  onRefresh: () async {
                    return _blockUserListProvider.loadDataList(
                        requestPathHolder: RequestPathHolder(
                            loginUserId: psValueHolder.loginUserId));
                  },
                ))
          else
            const NoListData(
              assetName: 'assets/images/no_notification.svg',
              emptyText: 'You currently have no blocked users.',
            ),
          PSProgressIndicator(provider.currentStatus)
        ]);
      }),
    ));
  }
}
