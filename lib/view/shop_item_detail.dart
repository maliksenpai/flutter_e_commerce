import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/get/shop_get.dart';
import 'package:flutter_e_commerce/model/shop_item.dart';
import 'package:flutter_e_commerce/widget/main_screen_dialogs.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ShopItemDetail extends StatefulWidget {
  const ShopItemDetail({Key? key}) : super(key: key);

  @override
  _ShopItemDetailState createState() => _ShopItemDetailState();
}

class _ShopItemDetailState extends State<ShopItemDetail> {
  ShopController shopController = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Hero(
        tag: shopController.selectedItem.value!.id,
        child: Material(
          type: MaterialType.transparency,
          child: Scaffold(
            appBar: AppBar(
              title: Text(shopController.selectedItem.value!.itemName),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    Get.back();
                    shopController.deleteShopItem(shopController.selectedItem.value!);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => MainScreenDialogs().addShopItem(updateItem, true, shopController.selectedItem.value),
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Item Name: ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              shopController.selectedItem.value!.itemName,
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Item Description: ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Flexible(
                                child: Text(
                              shopController.selectedItem.value!.itemDesc,
                              style: const TextStyle(fontSize: 20),
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Item Price: ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              shopController.selectedItem.value!.price.toStringAsFixed(2) + "₺",
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Item Category: ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              shopController.selectedItem.value!.shopItemCategory.toString().split(".").last,
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Item Added Time: ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              DateFormat("yyyy-MM-dd HH:mm:ss").format(shopController.selectedItem.value!.addedTime),
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateItem(nameController, descController, priceController, selectedItem, shopController, currDetailItem) {
    ShopItem shopItem = ShopItem(
        id: currDetailItem == null ? const Uuid().v4() : currDetailItem.id,
        itemName: nameController.text,
        itemDesc: descController.text,
        addedTime: currDetailItem == null ? DateTime.now().toUtc() : currDetailItem.addedTime,
        price: num.parse(priceController.text),
        shopItemCategory: selectedItem);
    shopController.updateShopItem(shopItem);
  }
}
