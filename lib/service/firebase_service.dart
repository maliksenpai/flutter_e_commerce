import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_e_commerce/model/shop_item.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxService {
  late DatabaseReference databaseReference;

  @override
  void onInit() {
    databaseReference = FirebaseDatabase.instance.reference().child("items");
    super.onInit();
  }

  Future<DataSnapshot> getListItems() async {
    return databaseReference.once();
  }

  Future addItem(ShopItem shopItem) {
    return databaseReference.child(shopItem.id).set(shopItem.toJson());
  }

  Future updateItem(ShopItem shopItem) {
    return databaseReference.child(shopItem.id).set(shopItem.toJson());
  }

  Future getListItemsWithSort(String child, bool isDesc) {
    return isDesc ? databaseReference.orderByChild(child).limitToLast(100).once() : databaseReference.orderByChild(child).limitToFirst(100).once();
  }

  Future deleteItem(ShopItem shopItem) {
    return databaseReference.child(shopItem.id).remove();
  }
}
