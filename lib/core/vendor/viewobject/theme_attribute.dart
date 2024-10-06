import 'common/ps_object.dart';

class ThemeAttribute extends PsObject<ThemeAttribute> {
  ThemeAttribute({this.isShow});

  String? isShow;

  @override
  ThemeAttribute fromMap(dynamic dynamicData) {
    return ThemeAttribute(
        isShow: dynamicData['is_show']);
  }

  @override
  List<ThemeAttribute> fromMapList(List<dynamic>? dynamicDataList) {
    final List<ThemeAttribute> list = <ThemeAttribute>[];
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
  Map<String, dynamic>? toMap(ThemeAttribute? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['is_show'] = object.isShow;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ThemeAttribute> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (ThemeAttribute? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
