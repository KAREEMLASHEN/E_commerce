import 'package:ecommerce_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/theme.dart';
import 'profile.dart';
import '../widgets/floating_stars.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int _selectedCategoryIndex = -1;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Tech', 'icon': Icons.devices_outlined},
    {'name': 'Fashion', 'icon': Icons.checkroom_outlined},
    {'name': 'Beauty', 'icon': Icons.face_outlined},
    {'name': 'Watch', 'icon': Icons.watch_outlined},
    {'name': 'Sport', 'icon': Icons.sports_soccer_outlined},
  ];

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Linear Ceramic\nWatch',
      'price': '\$249.00',
      'image': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
      'badge': 'Bestseller',
    },
    {
      'name': 'Studio Audio One',
      'price': '\$399.00',
      'image': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
      'badge': null,
    },
    {
      'name': 'Crimson Runner II',
      'price': '\$120.00',
      'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
      'badge': null,
    },
    {
      'name': 'Heritage Low Suede',
      'price': '\$85.00',
      'image': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400',
      'badge': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.themeMode == ThemeMode.dark ||
        (themeProvider.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF5F6F7),
      drawer: _buildDrawer(context, isDark),
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: false,
                floating: true,
                snap: true,
                backgroundColor: isDark ? const Color(0xFF1E293B).withValues(alpha: 0.9) : Colors.white.withValues(alpha: 0.9),
                elevation: 0,
                title: Text(
                  'MAJARA',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : Colors.black,
                    letterSpacing: -1.2,
                  ),
                ),
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.menu, color: isDark ? Colors.white70 : const Color(0xFFABADAE)),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.notifications_outlined, color: isDark ? Colors.white70 : const Color(0xFFABADAE)),
                    onPressed: () {},
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildSearchBar(isDark),
                    _buildHeroSection(isDark),
                    _buildCategoriesSection(isDark),
                    _buildTopTrendingSection(isDark),
                    _buildNewArrivalsSection(isDark),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: _buildBottomNavBar(isDark),
          ),
        const FloatingStars(),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, bool isDark) {
    final User? user = FirebaseAuth.instance.currentUser;
    String displayName = "Guest User";
    if (user != null) {
      if (user.displayName != null && user.displayName!.isNotEmpty) {
        displayName = user.displayName!;
      } else if (user.email != null) {
        displayName = user.email!.split('@')[0];
      }
    }

    return Drawer(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF2563EB),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                displayName.isNotEmpty ? displayName[0].toUpperCase() : "U",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
            accountName: Text(
              displayName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              user?.email ?? "No email found",
              style: const TextStyle(color: Colors.white70),
            ),
          ),

          _buildDrawerItem(
  icon: Icons.person_outline_rounded,
  title: 'Profile',
  isDark: isDark,
  onTap: () {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfileScreen()),
    );
  },
),
          _buildDrawerItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            isDark: isDark,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const Spacer(), 
          
          Divider(color: isDark ? Colors.white12 : Colors.grey[300]),

          _buildDrawerItem(
  icon: Icons.logout_rounded,
  title: 'Logout',
  isDark: isDark,
  textColor: Colors.red,
  onTap: () async {
    try {
      Navigator.pop(context); 

      await FirebaseAuth.instance.signOut();

      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      }
    } catch (e) {
      debugPrint("Error during logout: $e");
    }
  },
),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isDark,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(
        icon, 
        color: textColor ?? (isDark ? Colors.white70 : Colors.black87),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? (isDark ? Colors.white : Colors.black87),
          fontSize: 16,
          fontWeight: textColor != null ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 55,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: isDark ? Colors.white60 : const Color(0xFFABADAE)),
            const SizedBox(width: 12),
            Text(
              'What are you looking for?',
              style: TextStyle(
                color: isDark ? Colors.white60 : const Color(0xFFABADAE),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : const Color(0xFFEFF1F2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                opacity: AlwaysStoppedAnimation(isDark ? 0.9 : 1.0),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    isDark ? const Color(0xFF0F172A).withValues(alpha: 0.6) : const Color(0xFFEFF1F2),
                    Colors.transparent
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 32,
              left: 32,
              right: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('NEW SEASON',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'The Autumn\nSelection.',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF2C2F30),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2563EB),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: _categories.asMap().entries.map((entry) {
                final index = entry.key;
                final category = entry.value;
                final isSelected = _selectedCategoryIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(right: 28),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = isSelected ? -1 : index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: isSelected
                                ? const RadialGradient(
                                    center: Alignment(-0.3, -0.4),
                                    radius: 0.8,
                                    colors: [
                                      Color(0xFF7DD3FC),
                                      Color(0xFF2563EB),
                                      Color(0xFF0F172A),
                                    ],
                                    stops: [0.0, 0.5, 1.0],
                                  )
                                : RadialGradient(
                                    center: const Alignment(-0.3, -0.4),
                                    radius: 0.8,
                                    colors: isDark
                                        ? [const Color(0xFF334155), const Color(0xFF1E293B)]
                                        : [const Color(0xFFF9FAFB), const Color(0xFFD1D5DB)],
                                  ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? const Color(0xFF2563EB).withValues(alpha: 0.4)
                                    : Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
                                blurRadius: isSelected ? 15 : 10,
                                offset: const Offset(0, 6),
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            category['icon'] as IconData,
                            color: isSelected ? Colors.white : (isDark ? Colors.white70 : const Color(0xFF4B5563)),
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        category['name'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? (isDark ? Colors.blue : const Color(0xFF0F172A)) : (isDark ? Colors.white60 : const Color(0xFF4B5563)),
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopTrendingSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Trending',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF2C2F30),
                  letterSpacing: -0.75,
                ),
              ),
              Row(
                children: [
                  _buildArrowButton(Icons.arrow_back_ios_new, () {}, isDark),
                  const SizedBox(width: 8),
                  _buildArrowButton(Icons.arrow_forward_ios, () {}, isDark),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 24,
              childAspectRatio: 0.68,
            ),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              return _buildProductCard(_products[index], isDark);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildArrowButton(IconData icon, VoidCallback onTap, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          border: Border.all(color: isDark ? Colors.white24 : const Color(0xFFABADAE).withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 12, color: isDark ? Colors.white : const Color(0xFF2C2F30)),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product['image'] as String,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B).withValues(alpha: 0.9) : Colors.white.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite_border, size: 16, color: isDark ? Colors.white : const Color(0xFF2C2F30)),
                ),
              ),
              if (product['badge'] != null)
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C0F10),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      product['badge'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          product['name'] as String,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: isDark ? Colors.white : const Color(0xFF2C2F30), height: 1.3),
        ),
        const SizedBox(height: 4),
        Text(
          product['price'] as String,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF2563EB)),
        ),
      ],
    );
  }

  Widget _buildNewArrivalsSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Arrivals',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: isDark ? Colors.white : const Color(0xFF2C2F30), letterSpacing: -0.75),
          ),
          const SizedBox(height: 32),
          _buildArrivalItem(
            imageUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=800',
            tag: 'EXCLUSIVES',
            title: 'Elevated Basics',
            height: 400,
            isDark: isDark,
          ),
          const SizedBox(height: 20),
          _buildArrivalItem(
            imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
            tag: 'INTERIOR',
            title: 'Living Spaces',
            height: 280,
            isDark: isDark,
          ),
          const SizedBox(height: 20),
          _buildArrivalItem(
            imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800',
            tag: 'TECH STYLE',
            title: 'Minimal Gear',
            height: 280,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildArrivalItem({required String imageUrl, required String tag, required String title, required double height, required bool isDark}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            opacity: AlwaysStoppedAnimation(isDark ? 0.9 : 1.0),
          ),
          Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, (isDark ? Colors.black : const Color(0xFF2C2F30)).withValues(alpha: 0.5)],
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tag, style: const TextStyle(color: Color(0xFFBFDBFE), fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.2)),
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700, height: 1.1)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(bool isDark) {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'HOME'},
      {'icon': Icons.search, 'label': 'SEARCH'},
      {'icon': Icons.favorite_border_rounded, 'label': 'FAVORITE'},
      {'icon': Icons.shopping_bag_outlined, 'label': 'CART'},
      {'icon': Icons.person_outline, 'label': 'PROFILE'},
    ];
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = _currentIndex == index;

          return GestureDetector(
            onTap: (){
              setState(() => _currentIndex = index);
              if(index == 4){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_)=> const ProfileScreen())
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isSelected
                    ? const RadialGradient(
                        center: Alignment(-0.3, -0.4),
                        radius: 0.8,
                        colors: [
                          Color(0xFF7DD3FC),
                          Color(0xFF2563EB),
                          Color(0xFF0F172A),
                        ],
                        stops: [0.0, 0.5, 1.0],
                      )
                    : null,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item['icon'] as IconData,
                    color: isSelected ? Colors.white : (isDark ? Colors.white70 : const Color(0xFF2C2F30)),
                    size: 20,
                  ),
                  if (isSelected) const SizedBox(height: 2),
                  if (isSelected)
                    Text(
                      item['label'] as String,
                      style: const TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}