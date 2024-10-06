import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/vendor/repository/add_to_cart_repository.dart';
import '../../../../core/vendor/viewobject/shopping_cart.dart';
import '../../../../core/vendor/viewobject/shopping_cart_item.dart';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import '../../viewobject/api_status.dart';
import '../common/ps_provider.dart';

class AddToCartProvider extends PsProvider<ShoppingCart> {
  AddToCartProvider({
    required BuildContext context,
    int limit = 0,
  }) : super(initRepo(context), getLimit(context, limit),
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);

  static AddToCartRepository initRepo(BuildContext context) {
    return AddToCartRepository(
        psApiService: Provider.of<PsApiService>(context, listen: false));
  }

  static int getLimit(BuildContext context, int limit) {
    if (limit > 0) {
      return limit;
    }
    return 0;
  }

  PsResource<ApiStatus> _addToCartStatus =
      PsResource<ApiStatus>(PsStatus.NOACTION, '', null);

  PsResource<ApiStatus> _deleteItemFromCartStatus =
      PsResource<ApiStatus>(PsStatus.NOACTION, '', null);

  List<int> _selectedAvaliableCartId = <int>[];
  final List<int> _getAllShoppingCartId = <int>[];

  List<ShoppingCartItem> _availableShoppingCartList = <ShoppingCartItem>[];
  List<ShoppingCartItem> _soldOutShoppingCartList = <ShoppingCartItem>[];

  ShoppingCartItem _singleItemCheckoutItem = ShoppingCartItem();

  PsResource<ShoppingCart> get shoppingCart => super.data;

  PsResource<ApiStatus> get addToCartStatus => _addToCartStatus;

  PsResource<ApiStatus> get deleteItemFromCartStatus =>
      _deleteItemFromCartStatus;

  List<ShoppingCartItem> get availableShoppingCartList =>
      _availableShoppingCartList;
  List<ShoppingCartItem> get soldOutShoppingCartList =>
      _soldOutShoppingCartList;
  ShoppingCartItem get singleItemCheckoutItem => _singleItemCheckoutItem;

  List<int> get selectedAvaliableCartId => _selectedAvaliableCartId;
  List<int> get getAllShoppingCartId => _getAllShoppingCartId;

  void addSelectedAvaliaveItemId(String selectedCartId) {
    _selectedAvaliableCartId.add(int.parse(selectedCartId));
    notifyListeners();
  }

  void addSelectedAvaliaveItemIdList(List<int> selectedCartIdList) {
    _selectedAvaliableCartId = selectedCartIdList;
  }

  void removeSelectedAvaliaveItemId(String selectedCartId) {
    _selectedAvaliableCartId.remove(int.parse(selectedCartId));
    notifyListeners();
  }

  void addAvaliavleShoppingCartList(List<ShoppingCartItem> list) {
    _availableShoppingCartList = list;
  }

  void addSoldOutShoppingCartList(List<ShoppingCartItem> list) {
    _soldOutShoppingCartList = list;
  }

  void addSingleItemCheckoutItem(ShoppingCartItem item) {
    _singleItemCheckoutItem = item;
    notifyListeners();
  }

  void addAllShoppingCartId(String id) {
    if (!_getAllShoppingCartId.contains(id)) {
      _getAllShoppingCartId.add(int.parse(id));
      notifyListeners();
    }
  }

  void increaseCount(int index) {
    int quantiy = int.parse(availableShoppingCartList[index].quantity ?? '0');
    quantiy++;
    availableShoppingCartList[index].quantity = quantiy.toString();
    notifyListeners();
  }

  void decreaseCount(int index) {
    int quantiy = int.parse(availableShoppingCartList[index].quantity ?? '0');
    quantiy--;
    availableShoppingCartList[index].quantity = quantiy.toString();
    notifyListeners();
  }

  void removeFromShoppingCart(int index, bool isAvailavleCart) {
    if (isAvailavleCart) {
      availableShoppingCartList.removeAt(index);
      notifyListeners();
    } else {
      soldOutShoppingCartList.removeAt(index);
      notifyListeners();
    }
  }

  void onChangeSelected(int index, bool isSelected) {
    if (isSelected) {
      availableShoppingCartList[index].isSelect = PsConst.ONE;
      notifyListeners();
    } else {
      availableShoppingCartList[index].isSelect = PsConst.ZERO;
      notifyListeners();
    }
  }

  Future<dynamic> submitAddToCart(
      BuildContext context,
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      String? languageCode) async {
    _addToCartStatus = await initRepo(context)
        .submitAddToCart(jsonMap, loginUserId, languageCode);

    return _addToCartStatus;
  }

  Future<dynamic> deleteItemFromCart(
      BuildContext context,
      List<int> deleteCartList,
      String? loginUserId,
      String? languageCode) async {
    // ignore: always_specify_types
    final Map jsonMap = <String, dynamic>{'cart_item_ids': deleteCartList};
    _deleteItemFromCartStatus = await initRepo(context)
        .deleteItemFromCart(jsonMap, loginUserId, languageCode);

    return _deleteItemFromCartStatus;
  }
}
