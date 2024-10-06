import 'package:sembast/sembast.dart';
import '../viewobject/order_history.dart';
import 'common/ps_dao.dart';

class OrderDao extends PsDao<OrderHistory> {
  OrderDao._() {
    init(OrderHistory());
  }
  static const String STORE_NAME = 'Order';
  final String _primaryKey = 'id';

  // Singleton instance
  static final OrderDao _singleton = OrderDao._();

  // Singleton accessor
  static OrderDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(OrderHistory object) {
    return object.id.toString();
  }

  @override
  Filter getFilter(OrderHistory object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
