import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/get/shop_get.dart';
import 'package:flutter_e_commerce/model/shop_item.dart';
import 'package:flutter_e_commerce/view/shop_item_detail.dart';
import 'package:flutter_e_commerce/widget/main_screen_dialogs.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ShopController shopGet = Get.put(ShopController());
  List<ShopItem> filteredList = [];
  String filterText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("E Commerce"),
      ),
      body: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(hintText: "Search", border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                        onChanged: (text) {
                          shopGet.filterText = text;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.filter_alt,
                              color: Colors.redAccent,
                            ),
                            Container(
                              width: 8,
                            ),
                            const Text("Filter")
                          ],
                        ),
                        onTap: () => MainScreenDialogs().filterDialog()),
                    const VerticalDivider(),
                    InkWell(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.category,
                              color: Colors.orange,
                            ),
                            Container(
                              width: 8,
                            ),
                            const Text("Category")
                          ],
                        ),
                        onTap: () => MainScreenDialogs().categoryDialog()),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 2,
                children: shopGet.shopList.map((element) {
                  return InkWell(
                    child: Card(
                        semanticContainer: true,
                        elevation: 12,
                        child: Hero(
                          tag: element.id,
                          child: Material(
                            type: MaterialType.transparency,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            element.itemName,
                                            key: ValueKey(element.itemName),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Text(element.itemDesc, key: ValueKey(element.itemDesc), overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.caption),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      element.price.toStringAsFixed(2) + "₺",
                                      key: ValueKey(element.price.toStringAsFixed(2) + "₺"),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                    onTap: () {
                      shopGet.selectedItem.value = element;
                      Get.to(() => ShopItemDetail());
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => MainScreenDialogs().addShopItem(addItem, false, null),
      ),
    );
  }

  void addItem(nameController, descController, priceController, selectedItem, shopController, shopItem) {
    ShopItem shopItem = ShopItem(id: const Uuid().v4(), itemName: nameController.text, itemDesc: descController.text, addedTime: DateTime.now().toUtc(), price: num.parse(priceController.text), shopItemCategory: selectedItem);
    shopController.addShopItem(shopItem);
  }
}
