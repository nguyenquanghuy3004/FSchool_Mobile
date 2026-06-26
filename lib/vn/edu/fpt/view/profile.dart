import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _isDarkMode = false;
  bool _showNotification = true;
  bool _showStudentId = false;
  bool _showEmail = false;

  static const fptOrange = Color(0xFFF26F21);

  Color get _bgColor =>
      _isDarkMode ? const Color(0xFF1A1A2E) : const Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    // Dùng Scaffold để fill đúng không gian trong IndexedStack
    // và tránh màn hình tối do AnimatedContainer không expand được
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: _bgColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ── Avatar header ──────────────────────────────────────────
                _buildAvatarHeader(),
                const SizedBox(height: 16),

                // ── Thông tin học sinh ─────────────────────────────────────
                _buildSection(
                  title: 'Thông tin học sinh',
                  children: [
                    _buildInfoTile(
                      icon: Icons.badge_outlined,
                      iconBg: const Color(0xFF5C6BC0),
                      label: 'Mã học sinh',
                      value: 'HE123456',
                      isHidden: _showStudentId,
                      onToggle: () =>
                          setState(() => _showStudentId = !_showStudentId),
                      showDivider: true,
                    ),
                    _buildInfoTile(
                      icon: Icons.email_outlined,
                      iconBg: const Color(0xFF42A5F5),
                      label: 'Email',
                      value: 'huy@gmail.com',
                      isHidden: _showEmail,
                      onToggle: () => setState(() => _showEmail = !_showEmail),
                      showDivider: true,
                    ),
                    _buildInfoTile(
                      icon: Icons.location_on_outlined,
                      iconBg: const Color(0xFF66BB6A),
                      label: 'Cơ sở',
                      value: 'APLH',
                      showDivider: false,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ── Vẻ bề ngoài ───────────────────────────────────────────
                _buildSection(
                  title: 'Vẻ bề ngoài',
                  children: [
                    _buildToggleTile(
                      icon: Icons.dark_mode_outlined,
                      iconBg: const Color(0xFFCE93D8),
                      label: 'Chế độ tối',
                      value: _isDarkMode,
                      onChanged: (v) => setState(() => _isDarkMode = v),
                      showDivider: false,
                      isGreen: false,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ── Thông báo ─────────────────────────────────────────────
                _buildSection(
                  title: 'Thông báo',
                  children: [
                    _buildToggleTile(
                      icon: Icons.notifications_outlined,
                      iconBg: const Color(0xFF66BB6A),
                      label: 'Hiển thị thông báo',
                      value: _showNotification,
                      onChanged: (v) => setState(() => _showNotification = v),
                      showDivider: false,
                      isGreen: true,
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Avatar header ─────────────────────────────────────────────────────────
  Widget _buildAvatarHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      height: 130,
      decoration: BoxDecoration(
        color: fptOrange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative circles
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -10,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Avatar circle
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFBDBDBD),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.person, size: 48, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // ── Section card ──────────────────────────────────────────────────────────
  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    final textColor =
        _isDarkMode ? Colors.white : Colors.black87;
    final cardColor =
        _isDarkMode ? const Color(0xFF16213E) : Colors.white;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(_isDarkMode ? 0.3 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with left orange border
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, bottom: 12, right: 16),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: fptOrange,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          ...children,
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  // ── Info tile (with optional hide/show toggle) ────────────────────────────
  Widget _buildInfoTile({
    required IconData icon,
    required Color iconBg,
    required String label,
    required String value,
    bool isHidden = false,
    VoidCallback? onToggle,
    required bool showDivider,
  }) {
    final textColor = _isDarkMode ? Colors.white : Colors.black87;
    final subtitleColor =
        _isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;
    final dividerColor =
        _isDarkMode ? Colors.white12 : Colors.grey[200]!;

    final displayValue =
        isHidden ? '•' * value.length : value;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconBg.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconBg, size: 20),
              ),
              const SizedBox(width: 14),
              // Label + value
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        color: subtitleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      displayValue,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Eye toggle button (if applicable)
              if (onToggle != null)
                GestureDetector(
                  onTap: onToggle,
                  child: Icon(
                    isHidden
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 20,
                    color: subtitleColor,
                  ),
                ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 68,
            endIndent: 16,
            color: dividerColor,
          ),
      ],
    );
  }

  // ── Toggle tile ───────────────────────────────────────────────────────────
  Widget _buildToggleTile({
    required IconData icon,
    required Color iconBg,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool showDivider,
    required bool isGreen,
  }) {
    final textColor = _isDarkMode ? Colors.white : Colors.black87;
    final dividerColor =
        _isDarkMode ? Colors.white12 : Colors.grey[200]!;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconBg.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconBg, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              // Custom styled switch
              Transform.scale(
                scale: 0.85,
                child: Switch(
                  value: value,
                  onChanged: onChanged,
                  activeColor: Colors.white,
                  activeTrackColor:
                      isGreen ? const Color(0xFF4CAF50) : fptOrange,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 68,
            endIndent: 16,
            color: dividerColor,
          ),
      ],
    );
  }
}
