import 'common/ps_object.dart';
import 'theme_info.dart';

class MobileTheme extends PsObject<MobileTheme> {
  MobileTheme(
      {this.themeInfo});

  ThemeInfo? themeInfo;

  @override
  MobileTheme fromMap(dynamic dynamicData) {
    return MobileTheme(
        themeInfo: ThemeInfo().fromMap(dynamicData['theme_info']));
  }

  @override
  List<MobileTheme> fromMapList(List<dynamic>? dynamicDataList) {
    final List<MobileTheme> list = <MobileTheme>[];
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
  Map<String, dynamic>? toMap(MobileTheme? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['theme_info'] = ThemeInfo().toMap(object.themeInfo);
      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<MobileTheme> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (MobileTheme? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
