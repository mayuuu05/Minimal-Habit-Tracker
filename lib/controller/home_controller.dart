

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;
  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
