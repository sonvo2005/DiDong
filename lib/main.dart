
// =============================================================================
// FILE: main.dart  (bản có chú thích để đối chiếu với Figma)
// -----------------------------------------------------------------------------
// CÁCH ĐỌC CHÚ THÍCH:
//   [KHU VỰC]   : phần giao diện tương ứng trên màn hình
//   [KÍCH THƯỚC]: width / height / size
//   [KHOẢNG CÁCH]: padding / margin / SizedBox / spacing
//   [BO GÓC]    : borderRadius
//   [MÀU]       : Color(0xFFRRGGBB)  (FF = độ đục 100%, 6 số sau là mã HEX)
//   [VIỀN]      : border
//   [ĐỔ BÓNG]   : boxShadow (alpha = độ đục, blurRadius = độ mờ, offset = lệch x,y)
//   [CHỮ]       : fontSize / fontWeight / color / letterSpacing / height
//
// THỨ TỰ TỪ TRÊN XUỐNG DƯỚI CỦA MÀN HÌNH:
//   1. Thanh điều hướng (Back - Title - Share)
//   2. Avatar viền gradient + huy hiệu xác minh
//   3. Tên, chức danh, vị trí
//   4. Thẻ thống kê (Projects / Experience / Rating)
//   5. About Me
//   6. Skills & Expertise (các chip kỹ năng)
//   7. Featured Projects (2 thẻ dự án)
//   8. Thẻ Contact Information
//   + Hàm _buildSkillChip ở cuối file (dùng chung cho mọi chip kỹ năng)
// =============================================================================
import 'package:flutter/material.dart';
 
void main() {
  runApp(const MyApp());
}
 
// =============================================================================
// APP GỐC: cấu hình theme chung cho toàn ứng dụng
// =============================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Screen',
      debugShowCheckedModeBanner: false, // ẩn nhãn "DEBUG" góc phải
      theme: ThemeData(
        // [MÀU] Màu nền mặc định của mọi màn hình
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        // [MÀU] Màu chủ đạo (xanh dương) dùng để sinh bảng màu Material 3
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}
 
// =============================================================================
// MÀN HÌNH PROFILE
// =============================================================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // [MÀU] Nền của màn hình (Figma: màu nền của frame)
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 390,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // =========================================================
                  // 1. THANH ĐIỀU HƯỚNG: nút Back - tiêu đề "Profile" - nút Share
                  // =========================================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ---- Nút Back (bên trái) ----
                      Container(
                        width: 20, // [KÍCH THƯỚC] rộng nút
                        height: 42,//KÍCH THƯỚC] cao nút
                        decoration: BoxDecoration(
                          color: Colors.white, // [MÀU] nền nút
                          borderRadius: BorderRadius.circular(12), // [BO GÓC]
                          // [VIỀN] màu viền nút
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            // [ĐỔ BÓNG] nút Back
                            BoxShadow(
                              color: const Color(0xFF0F172A)
                                  .withValues(alpha: 0.03), // màu + độ đục
                              blurRadius: 6, // độ mờ
                              offset: const Offset(0, 2), // lệch (x, y)
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.chevron_left_rounded, // icon mũi tên quay lại
                          size: 18, // [KÍCH THƯỚC] icon
                          color: Color(0xFF1E293B), // [MÀU] icon
                        ),
                      ),
                      // ---- Tiêu đề giữa ----
                      const Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 18, // [CHỮ] cỡ chữ tiêu đề
                          fontWeight: FontWeight.w700, // [CHỮ] độ đậm (Bold)
                          color: Color(0xFF0F172A), // [MÀU] chữ
                        ),
                      ),
                      // ---- Nút Share (bên phải) ----
                      Container(
                        width: 20, // [KÍCH THƯỚC]
                        height: 42, // [KÍCH THƯỚC]
                        decoration: BoxDecoration(
                          color: Colors.white, // [MÀU] nền
                          borderRadius: BorderRadius.circular(12), // [BO GÓC]
                          border: Border.all(color: const Color(0xFFE2E8F0)), // [VIỀN]
                          boxShadow: [
                            // [ĐỔ BÓNG] nút Share (giống nút Back)
                            BoxShadow(
                              color: const Color(0xFF0F172A)
                                  .withValues(alpha: 0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.share_outlined, // icon chia sẻ
                          size: 18, // [KÍCH THƯỚC] icon
                          color: Color(0xFF1E293B), // [MÀU] icon
                        ),
                      ),
                    ],
                  ),
                  // [KHOẢNG CÁCH] Thanh điều hướng -> Avatar
                  const SizedBox(height: 24),
 
                  // =========================================================
                  // 2. AVATAR: viền gradient + viền trắng + huy hiệu xác minh
                  // =========================================================
                  Stack(
                    clipBehavior: Clip.none, // cho phép huy hiệu tràn ra ngoài
                    alignment: Alignment.center,
                    children: [
                      // ---- Vòng ngoài: viền gradient cam/đỏ ----
                      Container(
                        width: 140, // [KÍCH THƯỚC] đường kính avatar (gồm cả viền)
                        height: 140,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            // [MÀU] 3 màu gradient: cam -> đỏ -> vàng cam
                            colors: [
                              Color(0xFFFF7A59),
                              Color(0xFFFF5252),
                              Color(0xFFFFB259),
                            ],
                            begin: Alignment.bottomLeft, // hướng bắt đầu gradient
                            end: Alignment.topRight, // hướng kết thúc gradient
                          ),
                        ),
                        // [KHOẢNG CÁCH] Độ dày viền gradient = 3.5
                        padding: const EdgeInsets.all(3.5),
                        // ---- Vòng trong: viền trắng ----
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white, // [MÀU] viền trắng
                          ),
                          // [KHOẢNG CÁCH] Độ dày viền trắng = 3
                          padding: const EdgeInsets.all(3),
                          // ---- Ảnh avatar ----
                          child: ClipOval(
                            child: Image.asset(
                              'images/Do.jpg', // [ẢNH] đường dẫn ảnh avatar
                              fit: BoxFit.cover,
                              // Nếu không tải được ảnh -> hiện icon người
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  size: 60, // [KÍCH THƯỚC] icon dự phòng
                                  color: Color(0xFF94A3B8), // [MÀU]
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      // ---- Huy hiệu xác minh (dấu tích xanh) ở góc dưới phải ----
                      Positioned(
                        bottom: 4, // [KHOẢNG CÁCH] cách đáy avatar
                        right: 4, // [KHOẢNG CÁCH] cách phải avatar
                        child: Container(
                          width: 22, // [KÍCH THƯỚC] huy hiệu
                          height: 22,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0284C7), // [MÀU] nền huy hiệu
                            shape: BoxShape.circle,
                            // [VIỀN] viền trắng dày 2
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              // [ĐỔ BÓNG] huy hiệu
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.check_rounded, // dấu tích
                            size: 13, // [KÍCH THƯỚC] dấu tích
                            color: Colors.white, // [MÀU]
                          ),
                        ),
                      ),
                    ],
                  ),
                  // [KHOẢNG CÁCH] Avatar -> Tên
                  const SizedBox(height: 14),
 
                  // =========================================================
                  // 3. TÊN, CHỨC DANH & VỊ TRÍ
                  // =========================================================
                  // ---- Tên ----
                  const Text(
                    'Alex Rivers',
                    style: TextStyle(
                      fontSize: 24, // [CHỮ] cỡ chữ tên
                      fontWeight: FontWeight.bold, // [CHỮ] đậm
                      color: Color(0xFF0F172A), // [MÀU]
                      letterSpacing: -0.3, // [CHỮ] khoảng cách giữa các ký tự
                    ),
                  ),
                  // [KHOẢNG CÁCH] Tên -> Chức danh
                  const SizedBox(height: 4),
                  // ---- Chức danh ----
                  const Text(
                    'Lead Mobile Engineer',
                    style: TextStyle(
                      fontSize: 15, // [CHỮ]
                      fontWeight: FontWeight.w500, // [CHỮ] Medium
                      color: Color(0xFF64748B), // [MÀU] xám xanh
                    ),
                  ),
                  // [KHOẢNG CÁCH] Chức danh -> Vị trí
                  const SizedBox(height: 10),
                  // ---- Nhãn vị trí (Tokyo, Japan) ----
                  Container(
                    // [KHOẢNG CÁCH] đệm trong nhãn: ngang 14, dọc 6
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      // [MÀU] nền nhãn (alpha 0.9 = đục 90%)
                      color: const Color(0xFFF1F5F9).withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20), // [BO GÓC]
                      border: Border.all(color: const Color(0xFFE2E8F0)), // [VIỀN]
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on_outlined, // icon ghim vị trí
                          size: 14, // [KÍCH THƯỚC] icon
                          color: Color(0xFF64748B), // [MÀU] icon
                        ),
                        // [KHOẢNG CÁCH] icon -> chữ
                        SizedBox(width: 4),
                        Text(
                          'Tokyo, Japan',
                          style: TextStyle(
                            fontSize: 13, // [CHỮ]
                            fontWeight: FontWeight.w500, // [CHỮ]
                            color: Color(0xFF475569), // [MÀU]
                          ),
                        ),
                      ],
                    ),
                  ),
                  // [KHOẢNG CÁCH] Nhãn vị trí -> Thẻ thống kê
                  const SizedBox(height: 22),
 
                  // =========================================================
                  // 4. THẺ THỐNG KÊ: Projects | Experience | Rating
                  // =========================================================
                  Container(
                    // [KHOẢNG CÁCH] đệm trong thẻ: dọc 18, ngang 12
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white, // [MÀU] nền thẻ
                      borderRadius: BorderRadius.circular(20), // [BO GÓC]
                      border: Border.all(color: const Color(0xFFF1F5F9)), // [VIỀN]
                      boxShadow: [
                        // [ĐỔ BÓNG] thẻ thống kê
                        BoxShadow(
                          color: const Color(0xFF0F172A)
                              .withValues(alpha: 0.04),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // ---- Cột 1: Projects ----
                        const Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '148', // giá trị
                                style: TextStyle(
                                  fontSize: 20, // [CHỮ] cỡ số liệu
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              // [KHOẢNG CÁCH] số -> nhãn
                              SizedBox(height: 3),
                              Text(
                                'Projects', // nhãn
                                style: TextStyle(
                                  fontSize: 12, // [CHỮ] cỡ nhãn
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF94A3B8), // [MÀU] nhãn
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ---- Đường kẻ dọc phân cách 1 ----
                        Container(
                          height: 34, // [KÍCH THƯỚC] chiều cao đường kẻ
                          width: 1, // [KÍCH THƯỚC] độ dày đường kẻ
                          color: const Color(0xFFF1F5F9), // [MÀU]
                        ),
                        // ---- Cột 2: Experience ----
                        const Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '9 Yrs',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Experience',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ---- Đường kẻ dọc phân cách 2 ----
                        Container(
                          height: 34,
                          width: 1,
                          color: const Color(0xFFF1F5F9),
                        ),
                        // ---- Cột 3: Rating (có icon ngôi sao) ----
                        const Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '4.9',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                  // [KHOẢNG CÁCH] số -> ngôi sao
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.star_rounded,
                                    color: Color(0xFFF59E0B), // [MÀU] sao vàng
                                    size: 20, // [KÍCH THƯỚC] sao
                                  ),
                                ],
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Rating',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // [KHOẢNG CÁCH] Thẻ thống kê -> About Me
                  const SizedBox(height: 24),
 
                  // =========================================================
                  // 5. ABOUT ME
                  // =========================================================
                  // ---- Tiêu đề mục (dùng chung style cho các mục 5, 6, 7) ----
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'About Me',
                      style: TextStyle(
                        fontSize: 17, // [CHỮ] cỡ tiêu đề mục
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  // [KHOẢNG CÁCH] Tiêu đề -> Đoạn mô tả
                  const SizedBox(height: 8),
                  // ---- Đoạn mô tả ----
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Passionate Lead Mobile Engineer specialized in Flutter, Dart, and building high-performance cross-platform applications. Focused on elegant',
                      style: TextStyle(
                        fontSize: 13.5, // [CHỮ] cỡ chữ mô tả
                        height: 1.55, // [CHỮ] giãn dòng (line-height = 1.55 x cỡ chữ)
                        color: Color(0xFF64748B), // [MÀU]
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  // [KHOẢNG CÁCH] About Me -> Skills
                  const SizedBox(height: 24),
 
                  // =========================================================
                  // 6. SKILLS & EXPERTISE (các chip kỹ năng)
                  // =========================================================
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Skills & Expertise',
                      style: TextStyle(
                        fontSize: 17, // [CHỮ] (giống tiêu đề About Me)
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  // [KHOẢNG CÁCH] Tiêu đề -> Các chip
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8, // [KHOẢNG CÁCH] giữa các chip theo chiều ngang
                      runSpacing: 10, // [KHOẢNG CÁCH] giữa các hàng chip
                      children: [
                        // Cú pháp: _buildSkillChip(tên, icon, màu nền, màu chữ/icon)
                        // Chip 1: Flutter (xanh dương)
                        _buildSkillChip(
                          'Flutter',
                          Icons.flutter_dash,
                          const Color(0xFFE0F2FE), // [MÀU] nền chip
                          const Color(0xFF0284C7), // [MÀU] chữ + icon
                        ),
                        // Chip 2: Dart (xanh lá)
                        _buildSkillChip(
                          'Dart',
                          Icons.code_rounded,
                          const Color(0xFFDCFCE7),
                          const Color(0xFF16A34A),
                        ),
                        // Chip 3: Clean Arch (hồng đỏ)
                        _buildSkillChip(
                          'Clean Arch',
                          Icons.layers_rounded,
                          const Color(0xFFFFE4E6),
                          const Color(0xFFE11D48),
                        ),
                        // Chip 4: UI/UX (tím)
                        _buildSkillChip(
                          'UI/UX',
                          Icons.local_offer_outlined,
                          const Color(0xFFF3E8FF),
                          const Color(0xFF9333EA),
                        ),
                        // Chip 5: Firebase (cam vàng)
                        _buildSkillChip(
                          'Firebase',
                          Icons.local_fire_department_rounded,
                          const Color(0xFFFEF3C7),
                          const Color(0xFFD97706),
                        ),
                      ],
                    ),
                  ),
                  // [KHOẢNG CÁCH] Skills -> Featured Projects
                  const SizedBox(height: 24),
 
                  // =========================================================
                  // 7. FEATURED PROJECTS (2 thẻ dự án nằm ngang)
                  // =========================================================
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Featured Projects',
                      style: TextStyle(
                        fontSize: 17, // [CHỮ]
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  // [KHOẢNG CÁCH] Tiêu đề -> 2 thẻ
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      // -----------------------------------------------------
                      // THẺ DỰ ÁN 1: E-Shop Flutter
                      // -----------------------------------------------------
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white, // [MÀU] nền thẻ
                            borderRadius: BorderRadius.circular(16), // [BO GÓC]
                            border: Border.all(color: const Color(0xFFF1F5F9)), // [VIỀN]
                            boxShadow: [
                              // [ĐỔ BÓNG] thẻ dự án
                              BoxShadow(
                                color: const Color(0xFF0F172A)
                                    .withValues(alpha: 0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ---- Ảnh bìa (bo góc trên) ----
                              ClipRRect(
                                // [BO GÓC] phải khớp với bo góc thẻ (16)
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: SizedBox(
                                  height: 92, // [KÍCH THƯỚC] chiều cao ảnh bìa
                                  width: double.infinity, // full chiều rộng thẻ
                                  child: Image.network(
                                    // [ẢNH] link ảnh bìa dự án 1
                                    'https://images.unsplash.com/photo-1557821552-17105176677c?w=500&auto=format&fit=crop&q=80',
                                    fit: BoxFit.cover,
                                    // Lỗi tải ảnh -> dùng ảnh cục bộ thay thế
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'images/Test.jpg',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // ---- Phần chữ dưới ảnh ----
                              const Padding(
                                // [KHOẢNG CÁCH] trái 10, trên 10, phải 10, dưới 12
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'E-Shop Flutter', // tên dự án
                                      style: TextStyle(
                                        fontSize: 13, // [CHỮ] cỡ tên dự án
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0F172A),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // [KHOẢNG CÁCH] tên -> mô tả
                                    SizedBox(height: 3),
                                    Text(
                                      'Mobile App • 2026', // mô tả ngắn
                                      style: TextStyle(
                                        fontSize: 11, // [CHỮ] cỡ mô tả
                                        color: Color(0xFF64748B),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // [KHOẢNG CÁCH] giữa thẻ 1 và thẻ 2
                      const SizedBox(width: 12),
                      // -----------------------------------------------------
                      // THẺ DỰ ÁN 2: Crypto Vault
                      // (cấu trúc và thông số giống hệt thẻ 1)
                      // -----------------------------------------------------
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white, // [MÀU]
                            borderRadius: BorderRadius.circular(16), // [BO GÓC]
                            border: Border.all(color: const Color(0xFFF1F5F9)), // [VIỀN]
                            boxShadow: [
                              // [ĐỔ BÓNG]
                              BoxShadow(
                                color: const Color(0xFF0F172A)
                                    .withValues(alpha: 0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ---- Ảnh bìa ----
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16), // [BO GÓC]
                                ),
                                child: SizedBox(
                                  height: 92, // [KÍCH THƯỚC] chiều cao ảnh bìa
                                  width: double.infinity,
                                  child: Image.network(
                                    // [ẢNH] link ảnh bìa dự án 2
                                    'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=500&auto=format&fit=crop&q=80',
                                    fit: BoxFit.cover,
                                    // Lỗi tải ảnh -> hiện nền gradient tím/hồng
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            // [MÀU] gradient dự phòng
                                            colors: [
                                              Color(0xFF6366F1),
                                              Color(0xFFA855F7),
                                              Color(0xFFEC4899),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // ---- Phần chữ dưới ảnh ----
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Crypto Vault', // tên dự án
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0F172A),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Finance • Clean Arch', // mô tả ngắn
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF64748B),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // [KHOẢNG CÁCH] Featured Projects -> Contact
                  const SizedBox(height: 24),
 
                  // =========================================================
                  // 8. THẺ CONTACT INFORMATION (3 dòng, ngăn cách bằng Divider)
                  // =========================================================
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // [MÀU] nền thẻ
                      borderRadius: BorderRadius.circular(18), // [BO GÓC]
                      border: Border.all(color: const Color(0xFFF1F5F9)), // [VIỀN]
                      boxShadow: [
                        // [ĐỔ BÓNG] thẻ liên hệ
                        BoxShadow(
                          color: const Color(0xFF0F172A)
                              .withValues(alpha: 0.03),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        // ---- Dòng 1: Tiêu đề "Contact Information" ----
                        Padding(
                          // [KHOẢNG CÁCH] đệm mỗi dòng: ngang 16, dọc 14
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.alternate_email_rounded, // icon @
                                size: 20, // [KÍCH THƯỚC] icon
                                color: Color(0xFF0F172A), // [MÀU] icon đậm
                              ),
                              // [KHOẢNG CÁCH] icon -> chữ
                              SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  'Contact Information',
                                  style: TextStyle(
                                    fontSize: 13.5, // [CHỮ]
                                    fontWeight: FontWeight.w700, // [CHỮ] đậm
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded, // mũi tên phải
                                size: 20,
                                color: Color(0xFFCBD5E1), // [MÀU] mũi tên nhạt
                              ),
                            ],
                          ),
                        ),
                        // ---- Đường kẻ ngang 1 ----
                        Divider(
                          height: 1, // [KÍCH THƯỚC] chiều cao vùng chứa
                          thickness: 1, // [KÍCH THƯỚC] độ dày đường kẻ
                          color: Color(0xFFF1F5F9), // [MÀU]
                          indent: 16, // [KHOẢNG CÁCH] lùi lề trái
                          endIndent: 16, // [KHOẢNG CÁCH] lùi lề phải
                        ),
                        // ---- Dòng 2: Email ----
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.mail_outline_rounded, // icon thư
                                size: 20,
                                color: Color(0xFF64748B), // [MÀU] icon xám
                              ),
                              SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  'alex.rivers@email.com',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500, // [CHỮ] Medium
                                    color: Color(0xFF334155), // [MÀU]
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 20,
                                color: Color(0xFFCBD5E1),
                              ),
                            ],
                          ),
                        ),
                        // ---- Đường kẻ ngang 2 ----
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFF1F5F9),
                          indent: 16,
                          endIndent: 16,
                        ),
                        // ---- Dòng 3: Số điện thoại ----
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone_outlined, // icon điện thoại
                                size: 20,
                                color: Color(0xFF64748B),
                              ),
                              SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  '+81 (90) 1234-5678',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF334155),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 20,
                                color: Color(0xFFCBD5E1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // [KHOẢNG CÁCH] Đệm dưới cùng của màn hình
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 
  // ===========================================================================
  // HÀM DÙNG CHUNG: tạo 1 chip kỹ năng (dùng ở mục 6 - Skills & Expertise)
  // Sửa thông số ở đây sẽ ảnh hưởng đến TẤT CẢ chip.
  // ===========================================================================
  static Widget _buildSkillChip(
    String label, // tên kỹ năng
    IconData icon, // icon bên trái
    Color bgColor, // màu nền chip
    Color fgColor, // màu chữ + icon
  ) {
    return Container(
      // [KHOẢNG CÁCH] đệm trong chip: ngang 12, dọc 7
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20), // [BO GÓC] chip dạng viên thuốc
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fgColor), // [KÍCH THƯỚC] icon chip
          // [KHOẢNG CÁCH] icon -> chữ
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5, // [CHỮ] cỡ chữ chip
              fontWeight: FontWeight.w600, // [CHỮ] SemiBold
              color: fgColor,
            ),
          ),
        ],
      ),
    );
  }
}
 