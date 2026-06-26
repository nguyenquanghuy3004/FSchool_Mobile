import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import 'signin.dart';
import 'profile.dart';
import 'grades.dart';
import '../../../../bindings/signin_binding.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const fptOrange = Color(0xFFF26F21);

    Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeTabIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: fptOrange,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.how_to_reg), label: 'Điểm danh'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus_outlined), label: 'Đưa đón'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Tôi'),
        ],
      )),
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: [
          // ── Tab 0: Trang chủ hoặc Bảng điểm ───────────────────────────
          Obx(() => controller.currentHomeView.value == 1 
              ? const GradesView() 
              : _buildHomeTab(fptOrange)),

          // ── Tab 1: Điểm danh (placeholder) ───────────────────────────
          const Center(child: Text('Điểm danh', style: TextStyle(fontSize: 20))),

          // ── Tab 2: Đưa đón (placeholder) ─────────────────────────────
          const Center(child: Text('Đưa đón', style: TextStyle(fontSize: 20))),

          // ── Tab 3: Tôi ───────────────────────────────────────────────
          const ProfileView(),
        ],
      )),
    );
  }

  // ── Trang chủ ─────────────────────────────────────────────────────────────
  Widget _buildHomeTab(Color fptOrange) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top bar
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.black87, size: 28),
                      onPressed: () =>
                          Get.offAll(() => const SigninView(), binding: SigninBinding()),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.black87, size: 28),
                      onPressed: () {},
                    ),
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none, color: Colors.black87, size: 28),
                          onPressed: () {},
                        ),
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Stack chứa cả card cam và card trắng. Cả 2 đều non-positioned
          // nên Stack sẽ tự mở rộng bounds để bao trọn cả 2, giải quyết lỗi hit-testing.
          Stack(
            children: [
              // ── Orange profile card ─────────────────────────────────
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 220,
                decoration: BoxDecoration(
                  color: fptOrange,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.person, size: 40, color: Colors.grey),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Nguyễn Quang Wuy',
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text('He182121', style: TextStyle(color: Colors.white70, fontSize: 14)),
                                  const SizedBox(width: 12),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 6, height: 6,
                                          decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                        ),
                                        const SizedBox(width: 4),
                                        const Text('Có mặt', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: const [
                        Icon(Icons.meeting_room_outlined, color: Colors.white, size: 20),
                        SizedBox(width: 6),
                        Text('Se1912', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                        SizedBox(width: 24),
                        Icon(Icons.business_outlined, color: Colors.white, size: 20),
                        SizedBox(width: 6),
                        Text('FSCHOOL Hòa Lạc', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),

              // ── White functions card ─────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(top: 150), // Đẩy card trắng xuống 150px
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Chức năng',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 20),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.75,
                        children: [
                          _buildFunctionItem(Icons.description,      Colors.purple[300]!,   'Đơn từ'),
                          _buildFunctionItem(Icons.phone,            Colors.blue[400]!,     'Liên lạc'),
                          _buildFunctionItem(Icons.menu_book,        Colors.red[400]!,      'BTVN'),
                          _buildFunctionItem(
                            Icons.assessment,
                            Colors.lightBlue[400]!,
                            'Bảng điểm',
                            onTap: () => controller.currentHomeView.value = 1,
                          ),
                          _buildFunctionItem(Icons.rice_bowl,        Colors.green[400]!,    'Ăn bán trú'),
                          _buildFunctionItem(Icons.payments,         Colors.teal[400]!,     'Học phí'),
                          _buildFunctionItem(Icons.event,            Colors.orange[400]!,   'Sự kiện'),
                          _buildFunctionItem(Icons.people,           Colors.deepOrange[400]!,'Câu lạc bộ'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Pagination dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 16, height: 6,
                            decoration: BoxDecoration(color: const Color(0xFFF26F21), borderRadius: BorderRadius.circular(3)),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 6, height: 6,
                            decoration: const BoxDecoration(color: Color(0xFFE0E0E0), shape: BoxShape.circle),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Function item ──────────────────────────────────────────────────────────
  Widget _buildFunctionItem(IconData icon, Color color, String label,
      {VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
