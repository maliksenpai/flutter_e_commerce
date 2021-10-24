import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_e_commerce/get/shop_get.dart';
import 'package:flutter_e_commerce/model/shop_item.dart';
import 'package:flutter_e_commerce/model/shop_item_category.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainScreenDialogs {
  filterDialog() {
    ShopController shopController = Get.put(ShopController());

    Map<int, String> sortMap = {1: "Price: Low to High", 2: "Price: High to Low", 3: "Time: New to Old", 4: "Time: Old to New"};
    int selectedValue = 1;
    Get.bottomSheet(Container(
      color: Colors.white,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Sort By",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Column(
                  children: sortMap
                      .map((key, value) => MapEntry(
                          key,
                          RadioListTile(
                            title: Text(sortMap[key]!),
                            value: key,
                            groupValue: selectedValue,
                            onChanged: (radioValue) {
                              setState(() {
                                selectedValue = key;
                              });
                            },
                          )))
                      .values
                      .toList()),
              TextButton(
                child: const Text("Save"),
                onPressed: () {
                  shopController.sortByValue(selectedValue);
                  Get.back();
                },
              )
            ],
          );
        },
      ),
    ));
  }

  void categoryDialog() {
    ShopController shopController = Get.put(ShopController());
    ShopItemCategory selectedCategory = ShopItemCategory.Clothes;
    Get.dialog(StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text("Select Category"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<ShopItemCategory>(
                value: ShopItemCategory.Clothes,
                groupValue: selectedCategory,
                title: Text(ShopItemCategory.Clothes.toString().split(".").last),
                onChanged: (object) {
                  setState(() {
                    selectedCategory = object!;
                  });
                },
              ),
              RadioListTile<ShopItemCategory>(
                value: ShopItemCategory.Jewelery,
                groupValue: selectedCategory,
                title: Text(ShopItemCategory.Jewelery.toString().split(".").last),
                onChanged: (object) {
                  setState(() {
                    selectedCategory = object!;
                  });
                },
              ),
              RadioListTile<ShopItemCategory>(
                value: ShopItemCategory.Electronic,
                groupValue: selectedCategory,
                title: Text(ShopItemCategory.Electronic.toString().split(".").last),
                onChanged: (object) {
                  setState(() {
                    selectedCategory = object!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text("Reset"),
              onPressed: () {
                shopController.filterCategory(null);
                Get.back();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                shopController.filterCategory(selectedCategory);
                Get.back();
              },
            )
          ],
        );
      },
    ));
  }

  void addShopItem(Function function, bool isDetail, ShopItem? shopItem) {
    ShopController shopController = Get.put(ShopController());
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    bool nameError = false;
    bool descError = false;
    bool priceError = false;
    List<ShopItemCategory> listDropDown = ShopItemCategory.values;
    ShopItemCategory selectedItem = ShopItemCategory.Clothes;

    if (isDetail) {
      nameController.text = shopItem!.itemName;
      descController.text = shopItem.itemDesc;
      priceController.text = shopItem.price.toStringAsFixed(2);
      dateController.text = DateFormat("yyyy-MM-dd HH:mm:ss").format(shopItem.addedTime);
    }

    Get.dialog(StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text("Add New Product"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name", errorText: nameError ? "Incorrect Input" : null),
              ),
              TextField(
                controller: descController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(labelText: "Description", errorText: descError ? "Incorrect Input" : null),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))],
                decoration: InputDecoration(labelText: "Price", errorText: priceError ? "Incorrect Input" : null),
              ),
              Container(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Product Type"),
                  DropdownButton<ShopItemCategory>(
                    value: selectedItem,
                    onChanged: (item) {
                      setState(() {
                        selectedItem = item!;
                      });
                    },
                    items: listDropDown.map<DropdownMenuItem<ShopItemCategory>>((e) {
                      return DropdownMenuItem(
                        child: Text(e.toString().split(".").last),
                        value: e,
                      );
                    }).toList(),
                  ),
                ],
              ),
              if (isDetail)
                TextField(
                  controller: dateController,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: "Added Time",
                  ),
                )
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Back"),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text(isDetail ? "Update" : "Add"),
            onPressed: () {
              if (nameController.text.trim().isEmpty) {
                setState(() {
                  nameError = true;
                  descError = false;
                  priceError = false;
                });
              } else if (descController.text.trim().isEmpty) {
                setState(() {
                  nameError = false;
                  descError = true;
                  priceError = false;
                });
              } else if (priceController.text.trim().isEmpty) {
                setState(() {
                  nameError = false;
                  descError = false;
                  priceError = true;
                });
              } else {
                function(nameController, descController, priceController, selectedItem, shopController, shopItem);
                Get.back();
              }
            },
          )
        ],
      ),
    ));
  }
}
