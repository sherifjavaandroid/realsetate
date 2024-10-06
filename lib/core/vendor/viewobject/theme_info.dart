import 'common/ps_object.dart';
import 'theme_screen.dart';

class ThemeInfo extends PsObject<ThemeInfo> {
  ThemeInfo(
      {this.themeId,
      this.themeName,
      this.screens});

  String? themeId;
  String? themeName;
  List<ThemeScreen>? screens;

  @override
  ThemeInfo fromMap(dynamic dynamicData) {
    return ThemeInfo(
        themeId: dynamicData['theme_id'],
        themeName: dynamicData['theme_name'],
        screens: ThemeScreen().fromMapList(dynamicData['screens']));
  }

  @override
  List<ThemeInfo> fromMapList(List<dynamic>? dynamicDataList) {
    final List<ThemeInfo> list = <ThemeInfo>[];
    if (dynamicDataList != null) {
      for (dynamic element in dynamicDataList) {
        list.add(fromMap(element));
      }
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return '';
  }

  @override
  Map<String, dynamic>? toMap(ThemeInfo? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['theme_id'] = object.themeId;
      data['theme_name'] = object.themeName;
      data['screens'] = ThemeScreen().toMapList(object.screens!);
      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ThemeInfo> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (ThemeInfo? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
