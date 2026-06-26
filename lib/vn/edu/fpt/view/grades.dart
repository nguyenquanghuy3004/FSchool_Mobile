import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../model/grade.dart';
import '../service/grade_api_service.dart';

class GradesView extends StatefulWidget {
  const GradesView({super.key});

  @override
  State<GradesView> createState() => _GradesViewState();
}

class _GradesViewState extends State<GradesView> {
  static const fptOrange = Color(0xFFF26F21);

  int _selectedSemester = 0;
  bool _isLoading = true;
  String _errorMessage = '';

  List<String> _semesters = [];
  Map<String, List<_SubjectGrade>> _gradesBySemester = {};

  @override
  void initState() {
    super.initState();
    _fetchGrades();
  }

  Future<void> _fetchGrades() async {
    try {
      final apiService = GradeApiService();
      final List<Grade> grades = await apiService.getAllGrades();

      Map<String, List<_SubjectGrade>> grouped = {};

      for (var grade in grades) {
        // Group name based on semester and academic year
        String semName = 'Kỳ ${grade.semester} (${grade.academicYear})';
        if (!grouped.containsKey(semName)) {
          grouped[semName] = [];
        }

        // Generate icon based on subject
        IconData icon = Icons.menu_book;
        Color color = const Color(0xFF66BB6A); // Default green

        String lowerSubject = grade.subjectName.toLowerCase();
        if (lowerSubject.contains('toán')) {
          icon = Icons.calculate;
          color = const Color(0xFFF9A825);
        } else if (lowerSubject.contains('lý')) {
          icon = Icons.science;
          color = const Color(0xFF42A5F5);
        } else if (lowerSubject.contains('hóa')) {
          icon = Icons.biotech;
          color = const Color(0xFFEC407A);
        } else if (lowerSubject.contains('anh')) {
          icon = Icons.language;
          color = const Color(0xFFAB47BC);
        } else if (lowerSubject.contains('tin')) {
          icon = Icons.computer;
          color = const Color(0xFF29B6F6);
        } else if (lowerSubject.contains('thể dục')) {
          icon = Icons.sports_soccer;
          color = const Color(0xFFFF7043);
        }

        grouped[semName]!.add(_SubjectGrade(
          name: grade.subjectName,
          icon: icon,
          iconBg: color,
          score: grade.score,
        ));
      }

      setState(() {
        _semesters = grouped.keys.toList();
        _gradesBySemester = grouped;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.black87, size: 20),
          onPressed: () {
            try {
              final HomeController controller = Get.find();
              controller.currentHomeView.value = 0;
            } catch (e) {
              Navigator.pop(context); // Fallback
            }
          },
        ),
        title: const Text(
          'Bảng điểm',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: fptOrange),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          'Lỗi: $_errorMessage',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (_semesters.isEmpty) {
      return const Center(
        child: Text(
          'Chưa có dữ liệu điểm.',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }

    final currentSemesterKey = _semesters[_selectedSemester];
    final grades = _gradesBySemester[currentSemesterKey] ?? [];

    return Column(
      children: [
        // ── Semester tab bar ────────────────────────────────────────
        _buildSemesterTabs(),
        const SizedBox(height: 16),

        // ── Grade list ──────────────────────────────────────────────
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: grades.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _buildGradeCard(grades[index]),
          ),
        ),
      ],
    );
  }

  // ── Semester tabs ─────────────────────────────────────────────────────────
  Widget _buildSemesterTabs() {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _semesters.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedSemester == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedSemester = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? fptOrange : const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                _semesters[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black54,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Grade card ────────────────────────────────────────────────────────────
  Widget _buildGradeCard(_SubjectGrade subject) {
    // Color based on score
    Color scoreColor;
    if (subject.score >= 8.5) {
      scoreColor = const Color(0xFF66BB6A); // green - giỏi
    } else if (subject.score >= 7.0) {
      scoreColor = const Color(0xFF8BC34A); // light green - khá
    } else if (subject.score >= 5.0) {
      scoreColor = const Color(0xFFFFA726); // orange - TB
    } else {
      scoreColor = const Color(0xFFEF5350); // red - yếu
    }

    final scoreText = subject.score == subject.score.roundToDouble()
        ? subject.score.toInt().toString()
        : subject.score.toString();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
      ),
      child: Row(
        children: [
          // Subject icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: subject.iconBg.withOpacity(0.18),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(subject.icon, color: subject.iconBg, size: 26),
          ),
          const SizedBox(width: 16),
          // Subject name
          Expanded(
            child: Text(
              subject.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          // Score badge
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: scoreColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              scoreText,
              style: TextStyle(
                color: scoreColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────────
class _SubjectGrade {
  final String name;
  final IconData icon;
  final Color iconBg;
  final double score;

  const _SubjectGrade({
    required this.name,
    required this.icon,
    required this.iconBg,
    required this.score,
  });
}
