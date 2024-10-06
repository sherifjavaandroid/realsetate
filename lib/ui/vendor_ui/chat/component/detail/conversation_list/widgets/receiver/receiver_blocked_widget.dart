import 'package:flutter/material.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';

class ReceiverBlockedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
            width: double.infinity,
            height: PsDimens.space68,
            child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                padding: const EdgeInsets.all(PsDimens.space12),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 22,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: PsDimens.space4, right: PsDimens.space6),
                        child: Text(
                          'chat_view__receiver_block_user'.tr,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: PsColors.achromatic50),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
