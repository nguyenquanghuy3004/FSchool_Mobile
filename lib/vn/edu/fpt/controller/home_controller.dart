import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;
  final currentHomeView = 0.obs; // 0: Trang chủ, 1: Bảng điểm

  void changeTabIndex(int index) {
    currentIndex.value = index;
    // Tự động reset về trang chủ nếu bấm lại vào tab Trang chủ
    if (index == 0) {
      currentHomeView.value = 0;
    }
  }
}
