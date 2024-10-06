import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/selected_custom_value_intent_holder.dart';
import '../../../../../config/ps_config.dart';
import '../../../../../core/vendor/provider/product/customize_ui_detail_provider.dart';
import '../../../../../core/vendor/repository/customize_ui_detail_repository.dart';
import '../../../../../core/vendor/viewobject/customize_ui_detail.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../common/base/ps_widget_with_appbar.dart';
import '../components/multi_selection_list_item.dart';

class MultiDataSelectionContainer extends StatefulWidget {
  const MultiDataSelectionContainer({
    Key? key,
    required this.appBartitle,
    required this.coreKeyId,
    required this.selectedIds,
    required this.selectedValues,
  }) : super(key: key);
  final String appBartitle;
  final String coreKeyId;
  final List<String> selectedIds;
  final List<String> selectedValues;
  @override
  State<MultiDataSelectionContainer> createState() =>
      _MultiDataSelectionContainerState();
}

class _MultiDataSelectionContainerState
    extends State<MultiDataSelectionContainer>
    with SingleTickerProviderStateMixin {
       CustomizeUiDetailRepository? repo;
  late AnimationController animationController;
  List<String> selectedValues = <String>[];
  List<String> selectedIds = <String>[];
     late CustomizeUiDetailProvider _customizeUiDetailProvider;
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    selectedIds.addAll(widget.selectedIds);
    selectedValues.addAll(widget.selectedValues);
         _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _customizeUiDetailProvider.loadNextDataList();
      }
    });

  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void _onTap(CustomizeUiDetail obj) {
    setState(() {
      if (selectedIds.contains(obj.id.toString())) {
        selectedValues.remove(obj.name);
        selectedIds.remove(obj.id.toString());
      } else {
        selectedValues.add(obj.name!);
        selectedIds.add(obj.id.toString());
      }
    });
  }

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

  @override
  Widget build(BuildContext context) {
    repo = Provider.of<CustomizeUiDetailRepository>(context);
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
            return;
        }
        _requestPop();
      },
      child: PsWidgetWithAppBar<CustomizeUiDetailProvider>(
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
                SelectedCustomValuesIntentHolder(
                  idList: selectedIds.join(','),
                  nameList: selectedValues.join(','),
                ),
              );
            },
            child: Text(
              'Done',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          )
        ],
        builder: (BuildContext context, CustomizeUiDetailProvider provider,
            Widget? child) {
          if (provider.customizeUiDetails.data != null) {
            return ListView.builder(
                controller: _scrollController,
                itemCount: provider.customizeUiDetails.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  final CustomizeUiDetail obj =
                      provider.customizeUiDetails.data![index];

                  return MultiSelectionListItem(
                    animation: curveAnimation(animationController,
                        index: index,
                        count: provider.customizeUiDetails.data!.length),
                    controller: animationController,
                    isSelected: selectedIds.contains(obj.id.toString()),
                    value: obj.name!,
                    onTap: () {
                      _onTap(obj);
                    },
                  );
                });
          } else {
            return const SizedBox();
          }
        },
        initProvider: () {
          _customizeUiDetailProvider = CustomizeUiDetailProvider(repo: repo);
          return _customizeUiDetailProvider;
        },

        onProviderReady: (CustomizeUiDetailProvider provider) {
          provider.loadDataList(
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder),
                  languageCode: langProvider.currentLocale.languageCode,
                  coreKeyId: widget.coreKeyId.trim()));
        },
        appBarTitle: widget.appBartitle,
      ),
    );
  }
}
