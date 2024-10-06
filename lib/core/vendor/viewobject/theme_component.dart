import 'common/ps_object.dart';
import 'theme_attribute.dart';

class ThemeComponent extends PsObject<ThemeComponent> {
  ThemeComponent({this.id, this.attributes});

  String? id;
  ThemeAttribute? attributes;

  @override
  ThemeComponent fromMap(dynamic dynamicData) {
    return ThemeComponent(
        id: dynamicData['id'],
        attributes: ThemeAttribute().fromMap(dynamicData['attribute']));
  }

  @override
  List<ThemeComponent> fromMapList(List<dynamic>? dynamicDataList) {
    final List<ThemeComponent> list = <ThemeComponent>[];
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
  Map<String, dynamic>? toMap(ThemeComponent? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['attribute'] = ThemeAttribute().toMap(object.attributes);
      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ThemeComponent> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (ThemeComponent? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
