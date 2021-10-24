import 'dart:core';

import 'package:flutter_e_commerce/model/shop_item_category.dart';


class ShopItem {
  String id;
  String itemName;
  String itemDesc;
  DateTime addedTime;
  num price;
  ShopItemCategory shopItemCategory;

  ShopItem({
    required this.id,
    required this.itemName,
    required this.itemDesc,
    required this.addedTime,
    required this.price,
    required this.shopItemCategory,
  });

  static ShopItem getFromSnapShot(MapEntry dataSnapshot) {
    return ShopItem(
        id: dataSnapshot.value["id"],
        itemName: dataSnapshot.value["itemName"],
        itemDesc: dataSnapshot.value["itemDesc"],
        addedTime: DateTime.fromMillisecondsSinceEpoch(dataSnapshot.value["addedTime"]),
        price: dataSnapshot.value["price"],
        shopItemCategory: ShopItemCategory.values.firstWhere((element) => element.toString() == dataSnapshot.value["shopItemCategory"]));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemName": itemName,
        "itemDesc": itemDesc,
        "addedTime": addedTime.millisecondsSinceEpoch,
        "price": price,
        "shopItemCategory": shopItemCategory.toString(),
      };
}
