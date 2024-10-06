import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';

class AllSearchTextBoxWidget extends StatefulWidget {
  const AllSearchTextBoxWidget(
      {this.textEditingController,
      this.onFilterChanged,
      this.onSearch,
      this.onClick,
      this.onTextChanged,
      this.onFocusChange,
      this.dropdownKey,
      this.dropdownValue,
      this.autofocus = false,
      this.fromHomePage = false});

  final TextEditingController? textEditingController;
  final Function? onFilterChanged;
  final Function? onSearch;
  final Function? onClick;
  final Function? onTextChanged;
  final Function? onFocusChange;
  final String? dropdownKey;
  final String? dropdownValue;
  final bool autofocus;
  final bool fromHomePage;
  @override
  State<StatefulWidget> createState() => _AllSearchTextBoxWidgetState();
}

class _AllSearchTextBoxWidgetState extends State<AllSearchTextBoxWidget> {
  // Initial Selected Value
  String dropdownvalue = 'all_search__all'.tr;
  String dropdownkey = 'all';

  List<String> dropdownValueList = <String>[
    'all_search__all'.tr,
    'all_search__user'.tr,
    'all_search__category'.tr,
    'all_search__item'.tr,
  ];

  List<String> dropdownKeyList = <String>[
    PsConst.ALL,
    PsConst.USER,
    PsConst.CATEGORY,
    PsConst.ITEM,
  ];

  @override
  void initState() {
    dropdownkey = widget.dropdownKey ?? dropdownkey;
    dropdownvalue = widget.dropdownValue ?? dropdownvalue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget _productTextFieldWidget = Flexible(
      child: FocusScope(
        onFocusChange: (bool focus) {
          if (widget.onFocusChange != null) {
            widget.onFocusChange!(focus);
          }
        },
        child: Focus(
          child: Container(
            width: double.infinity,
            height: PsDimens.space52,
            decoration: BoxDecoration(
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic100
                  : PsColors.achromatic900,
              borderRadius: BorderRadius.circular(PsDimens.space20),
              // border: Border.all(
              //     color: Utils.isLightMode(context)
              //         ? Colors.grey[200]!
              //         : Colors.black87),
            ),
            child: TextField(
              readOnly:
                  widget.fromHomePage, //not to show keyboard in home dashboard
              autofocus: widget.autofocus,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              maxLines: null,
              controller: widget.textEditingController,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: PsDimens.space12,
                    top: PsDimens.space14,
                    right: PsDimens.space12),
                border: InputBorder.none,
                hintText: 'home__bottom_app_bar_search'.tr,
                prefixIcon: InkWell(
                    child: Icon(
                      Remix.search_line,
                      color: Theme.of(context).primaryColor,
                    ),
                    // child: Padding(
                    //   padding: const EdgeInsets.only(right: PsDimens.space8),
                    //   child: Icon(
                    //     Icons.search,
                    //     color: PsColors.secondary600,
                    //   ),
                    // ),
                    onTap: () {
                      if (widget.onSearch != null) {
                        widget.onSearch!(
                            widget.textEditingController?.text ?? '',
                            dropdownkey,
                            dropdownvalue);
                      }
                    }),
              ),
              onSubmitted: (String value) {
                if (widget.onSearch != null) {
                  widget.onSearch!(widget.textEditingController?.text ?? '',
                      dropdownkey, dropdownvalue);
                }
              },
              onChanged: (String value) {
                if (widget.onTextChanged != null) {
                  widget.onTextChanged!(value);
                }
              },
              onTap: () {
                if (widget.onClick != null) {
                  widget.onClick!(widget.textEditingController?.text ?? '',
                      dropdownkey, dropdownvalue);
                }
              },
            ),
          ),
        ),
      ),
    );

    return Row(
      children: <Widget>[
        _productTextFieldWidget,
        const SizedBox(width: PsDimens.space16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).primaryColor,
          ),
          width: MediaQuery.of(context).size.width / 6.5 * 1.1,
          child: Center(
            child: DropdownButton<String>(
              isExpanded: true,
              value: dropdownvalue,
              underline: const SizedBox(),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: PsColors.achromatic50,
              ),
              selectedItemBuilder: (BuildContext context) {
                return dropdownValueList.map((String e) {
                  return Center(
                      child: Text(
                    dropdownvalue,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: PsColors.achromatic50),
                  ));
                }).toList();
              },
              items: dropdownValueList.map((String items) {
                return DropdownMenuItem<String>(
                  value: items,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 4.0, right: PsDimens.space4),
                    child: Text(
                      items,
                      maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
                final int index = dropdownValueList
                    .indexWhere((String element) => element == dropdownvalue);
                dropdownkey = dropdownKeyList[index];
                if (widget.onFilterChanged != null) {
                  widget.onFilterChanged!(
                      widget.textEditingController?.text ?? '',
                      dropdownkey,
                      dropdownvalue);
                }
              },
            ),
          ),
        ),
      ],
      //     ),
      //   ),
      // ],
    );
  }
}
