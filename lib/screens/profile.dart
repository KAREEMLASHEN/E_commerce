import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import '../widgets/floating_stars.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLogoutHovered = false;

  bool get _isDarkMode => Theme.of(context).brightness == Brightness.dark;

  String get _userName {
    final user = FirebaseAuth.instance.currentUser;
    if (user?.displayName != null && user!.displayName!.isNotEmpty) {
      return user.displayName!;
    }
    final email = user?.email ?? '';
    if (email.contains('@')) return email.split('@')[0];
    return 'User';
  }

  String get _userEmail {
    return FirebaseAuth.instance.currentUser?.email ?? '';
  }

  String get _userInitials {
    final name = _userName;
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, min(2, name.length)).toUpperCase();
  }

  final List<Map<String, dynamic>> _menuItems = [
    {
      'icon': Icons.inventory_2_outlined,
      'title': 'Orders',
      'subtitle': 'View your order history',
    },
    {
      'icon': Icons.person_outline,
      'title': 'Account Settings',
      'subtitle': 'Edit profile, email, password & address',
    },
    {
      'icon': Icons.favorite_border,
      'title': 'Favorites',
      'subtitle': 'Your saved items',
    },
    {
      'icon': Icons.help_outline,
      'title': 'Need Help',
      'subtitle': 'Get support and assistance',
    },
    {
      'icon': Icons.work_outline,
      'title': 'Work with Us',
      'subtitle': 'Become a supplier',
    },
  ];

  Future<void> _handleLogout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _isDarkMode;

    final bgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFEFF6FF);
    final cardColor = isDark ? const Color(0xFF1E293B).withOpacity(0.5) : Colors.white;
    final cardBorder = isDark ? const Color(0xFF1E293B) : const Color(0xFFE5E7EB);
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final subtitleColor = const Color(0xFF6B7280);
    final iconColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);
    final chevronColor = isDark ? const Color(0xFF4B5563) : const Color(0xFF9CA3AF);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // النجوم من الـ widget المشترك
          const FloatingStars(),

          // المحتوى
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  // Profile Header
                  Column(
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E293B)
                              : const Color(0xFFE5E7EB),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            _userInitials,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: titleColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _userName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _userEmail,
                        style: TextStyle(fontSize: 14, color: subtitleColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),

                  // Menu Items
                  Column(
                    children: _menuItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: cardBorder),
                              boxShadow: isDark
                                  ? null
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                            ),
                            child: Row(
                              children: [
                                Icon(item['icon'] as IconData,
                                    color: iconColor, size: 22),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title'] as String,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: titleColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item['subtitle'] as String,
                                        style: TextStyle(
                                            fontSize: 13, color: subtitleColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right,
                                    color: chevronColor, size: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),

                  // Logout Button
                  MouseRegion(
                    onEnter: (_) => setState(() => _isLogoutHovered = true),
                    onExit: (_) => setState(() => _isLogoutHovered = false),
                    child: GestureDetector(
                      onTapDown: (_) => setState(() => _isLogoutHovered = true),
                      onTapUp: (_) => setState(() => _isLogoutHovered = false),
                      onTapCancel: () =>
                          setState(() => _isLogoutHovered = false),
                      onTap: _handleLogout,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        decoration: BoxDecoration(
                          color: _isLogoutHovered
                              ? (isDark
                                  ? const Color(0xFF450A0A).withOpacity(0.2)
                                  : const Color(0xFFFEF2F2))
                              : cardColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _isLogoutHovered
                                ? const Color(0xFFEF4444).withOpacity(0.5)
                                : (isDark
                                    ? const Color(0xFF374151)
                                    : const Color(0xFFD1D5DB)),
                            width: 2,
                          ),
                        ),
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: _isLogoutHovered
                                ? const Color(0xFFEF4444)
                                : titleColor,
                          ),
                          child: const Text('Logout'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}