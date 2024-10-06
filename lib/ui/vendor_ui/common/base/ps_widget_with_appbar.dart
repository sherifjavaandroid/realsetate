import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../../config/ps_colors.dart';

import '../../../../core/vendor/utils/utils.dart';

class PsWidgetWithAppBar<T extends ChangeNotifier> extends StatefulWidget {
  const PsWidgetWithAppBar(
      {Key? key,
      required this.builder,
      required this.initProvider,
      this.child,
      this.onProviderReady,
      required this.appBarTitle,
      this.actions = const <Widget>[]})
      : super(key: key);

  final Widget Function(BuildContext context, T provider, Widget? child)
      builder;
  final Function initProvider;
  final Widget? child;
  final Function(T)? onProviderReady;
  final String appBarTitle;
  final List<Widget> actions;

  @override
  _PsWidgetWithAppBarState<T> createState() => _PsWidgetWithAppBarState<T>();
}

class _PsWidgetWithAppBarState<T extends ChangeNotifier>
    extends State<PsWidgetWithAppBar<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final dynamic data = EasyLocalizationProvider.of(context).data;
    // return EasyLocalizationProvider(
    //     data: data,
    //     child:
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
          ),
          // iconTheme: IconThemeData(color: Utils.isLightMode(context )?  PsColors.primary500 : PsColors.primaryDarkWhite),
          iconTheme: Theme.of(context).iconTheme,
          title: Text(widget.appBarTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Utils.isLightMode(context)
                      ? PsColors.text900
                      : PsColors.text50,
                  fontWeight: FontWeight.bold)
              // .copyWith(
              //     color: Utils.isLightMode(context)
              //         ? PsColors.primary500
              //         : PsColors.primaryDarkWhite)
              ),
          actions: widget.actions,
          flexibleSpace: Container(
            height: 200,
          ),
          elevation: 0,
        ),
        body: ChangeNotifierProvider<T?>(
          lazy: false,
          create: (BuildContext context) {
            final T? providerObj = widget.initProvider();
            if (widget.onProviderReady != null) {
              widget.onProviderReady!(providerObj!);
            }

            return providerObj;
          },
          child: Consumer<T>(
            builder: widget.builder,
            child: widget.child,
          ),
        )
        // )
        );
  }
}
