import 'common/ps_object.dart';
import 'theme_component.dart';

class ThemeScreen extends PsObject<ThemeScreen> {
  ThemeScreen({this.id, this.components});

  String? id;
  List<ThemeComponent>? components;

  @override
  ThemeScreen fromMap(dynamic dynamicData) {
    return ThemeScreen(
        id: dynamicData['id'],
        components: ThemeComponent().fromMapList(dynamicData['components']));
  }

  @override
  List<ThemeScreen> fromMapList(List<dynamic>? dynamicDataList) {
    final List<ThemeScreen> list = <ThemeScreen>[];
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
  Map<String, dynamic>? toMap(ThemeScreen? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['components'] = ThemeComponent().toMapList(object.components!);
      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ThemeScreen> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (ThemeScreen? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
