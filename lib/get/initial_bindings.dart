import 'package:flutter_e_commerce/get/shop_get.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShopController());
  }
}
