import 'package:flutter/material.dart';
import '../../../../../../config/ps_config.dart';
import '../../common/ps_app_bar_widget.dart';
import '../component/list/noti_list_view.dart';

class NotiListMenuContainerView extends StatefulWidget {
  const NotiListMenuContainerView({
    Key? key,
    required this.scaffoldKey,
    required this.title,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;
  @override
  _NotiListMenuContainerViewState createState() => _NotiListMenuContainerViewState();
}

class _NotiListMenuContainerViewState extends State<NotiListMenuContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    print(
        '............................Build Noti List  UI Again ............................');
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(widget.scaffoldKey.currentContext ?? context)
              .viewPadding
              .top),
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) {
            return;
          }
          return Future<void>.value(false);
        },
        child: Scaffold(
            appBar: PsAppbarWidget(
              appBarTitle: widget.title,
              leading: Center(
                  child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
              )),
            ),
            body: NotiListView()),
      ),
    );
  }
}
