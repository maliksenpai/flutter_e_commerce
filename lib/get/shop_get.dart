import 'package:flutter_e_commerce/model/shop_item.dart';
import 'package:flutter_e_commerce/model/shop_item_category.dart';
import 'package:flutter_e_commerce/service/firebase_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ShopController extends GetxController {
  final RxList<ShopItem> _shopItems = RxList([]);
  final RxList<ShopItem> _filteredList = RxList([]);
  final Rx<ShopItem?> selectedItem = Rx(null);
  final FirebaseService firebaseService = Get.put(FirebaseService());
  ShopItemCategory? filteredCategory;
  int sortIndex = 0;
  String _filterText = "";

  @override
  void onInit() {
    firebaseService.getListItems().then((value) {
      value.value.entries.forEach((MapEntry e) {
        ShopItem item = ShopItem.getFromSnapShot(e);
        _shopItems.add(item);
      });
    });
    super.onInit();
  }

  void addShopItem(ShopItem shopItem) {
    firebaseService.addItem(shopItem).whenComplete(() {
      if (filteredCategory == null || shopItem.shopItemCategory == filteredCategory) {
        _shopItems.add(shopItem);
        _shopItems.refresh();
        sortByValue(sortIndex);
      }
    });
  }

  void updateShopItem(ShopItem shopItem) {
    firebaseService.updateItem(shopItem).whenComplete(() {
      _shopItems[_shopItems.indexWhere((element) => element.id == shopItem.id)] = shopItem;
      selectedItem.value = shopItem;
      selectedItem.refresh();
      _shopItems.refresh();
      sortByValue(sortIndex);
    });
  }

  void deleteShopItem(ShopItem shopItem) {
    firebaseService.deleteItem(shopItem).whenComplete(() {
      _shopItems.removeWhere((element) => element.id == shopItem.id);
      selectedItem.value = null;
      selectedItem.refresh();
      _shopItems.refresh();
    });
  }

  void sortByValue(int index) async {
    sortIndex = index;
    switch (index) {
      case 1:
        firebaseService.getListItemsWithSort("price", false).then((value) {
          _shopItems.clear();
          value.value.entries.forEach((MapEntry e) {
            ShopItem item = ShopItem.getFromSnapShot(e);
            _shopItems.add(item);
          });
          _shopItems.refresh();
        });
        break;
      case 2:
        firebaseService.getListItemsWithSort("price", true).then((value) {
          _shopItems.clear();
          value.value.entries.forEach((MapEntry e) {
            ShopItem item = ShopItem.getFromSnapShot(e);
            _shopItems.add(item);
          });
          _shopItems.value = _shopItems.reversed.toList();
          _shopItems.refresh();
        });
        break;
      case 3:
        firebaseService.getListItemsWithSort("addedTime", false).then((value) {
          _shopItems.clear();
          value.value.entries.forEach((MapEntry e) {
            ShopItem item = ShopItem.getFromSnapShot(e);
            _shopItems.add(item);
          });
          _shopItems.refresh();
        });
        break;
      case 4:
        firebaseService.getListItemsWithSort("addedTime", true).then((value) {
          _shopItems.clear();
          value.value.entries.forEach((MapEntry e) {
            ShopItem item = ShopItem.getFromSnapShot(e);
            _shopItems.add(item);
          });
          _shopItems.value = _shopItems.reversed.toList();
          _shopItems.refresh();
        });
        break;
    }
  }

  void filterCategory(ShopItemCategory? shopItemCategory) {
    filteredCategory = shopItemCategory;
    String filterType = sortIndex == 1 || sortIndex == 2 ? "price" : "addedTime";
    bool isDesc = sortIndex == 2 || sortIndex == 4;
    firebaseService.getListItemsWithSort(filterType, isDesc).then((value) {
      _shopItems.clear();
      filteredCategory = shopItemCategory;
      value.value.entries.forEach((MapEntry e) {
        ShopItem item = ShopItem.getFromSnapShot(e);
        if (shopItemCategory == null || item.shopItemCategory == shopItemCategory) {
          _shopItems.add(item);
        }
      });
    });
  }

  RxList<ShopItem> get shopList {
    if (_filterText.trim().isEmpty) {
      return _shopItems;
    } else {
      return _filteredList;
    }
  }

  set filterText(String text) {
    _filterText = text;
    _filteredList.value = _shopItems.where((p0) => p0.itemName.contains(text) || p0.itemDesc.contains(text)).toList();
    _filteredList.refresh();
    _shopItems.refresh();
  }
}
