import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Home', 'icon': Icons.home_outlined, 'selected': true},
    {'name': 'Fashion', 'icon': Icons.checkroom_outlined, 'selected': false},
    {'name': 'Tech', 'icon': Icons.devices_outlined, 'selected': false},
    {'name': 'Beauty', 'icon': Icons.face_outlined, 'selected': false},
    {'name': 'Watch', 'icon': Icons.watch_outlined, 'selected': false},
    {'name': 'Sport', 'icon': Icons.sports_soccer_outlined, 'selected': false},
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
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: false,
                floating: true,
                snap: true,
                backgroundColor: Colors.white.withOpacity(0.9),
                elevation: 0,
                title: const Text(
                  'MAJARA',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    letterSpacing: -1.2,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.menu, color: Color(0xFFABADAE)),
                  onPressed: () {},
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, color: Color(0xFFABADAE)),
                    onPressed: () {},
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildHeroSection(),
                    _buildCategoriesSection(),
                    _buildTopTrendingSection(),
                    _buildNewArrivalsSection(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          color: const Color(0xFFEFF1F2),
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
                opacity: const AlwaysStoppedAnimation(0.6),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFEFF1F2), Colors.transparent],
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
                      color: const Color(0xFFBFDBFE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('NEW SEASON', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'The Autumn\nSelection.',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
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

  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C2F30),
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
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: _categories.asMap().entries.map((entry) {
                final category = entry.value;
                final isSelected = category['selected'] as bool;
                return Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE0E3E4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          category['icon'] as IconData,
                          color: isSelected ? Colors.white : const Color(0xFF595C5D),
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        category['name'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF595C5D),
                          letterSpacing: 1.2,
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

  Widget _buildTopTrendingSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top Trending',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2C2F30),
                  letterSpacing: -0.75,
                ),
              ),
              Row(
                children: [
                  _buildArrowButton(Icons.arrow_back_ios_new, () {}),
                  const SizedBox(width: 8),
                  _buildArrowButton(Icons.arrow_forward_ios, () {}),
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
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 0.7,
            ),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              return _buildProductCard(_products[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildArrowButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFABADAE).withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 12, color: const Color(0xFF2C2F30)),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product['image'] as String,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2)],
                  ),
                  child: const Icon(Icons.favorite_border, size: 18, color: Color(0xFF2C2F30)),
                ),
              ),
              if (product['badge'] != null)
                Positioned(
                  bottom: 14,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C0F10),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      product['badge'] as String,
                      style: const TextStyle(
                        color: Color(0xFF9B9D9E),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          product['name'] as String,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF2C2F30), height: 1.5),
        ),
        const SizedBox(height: 4),
        Text(
          product['price'] as String,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2563EB)),
        ),
      ],
    );
  }

  Widget _buildNewArrivalsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'New Arrivals',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Color(0xFF2C2F30), letterSpacing: -0.75),
          ),
          const SizedBox(height: 32),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=800',
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, const Color(0xFF2C2F30).withOpacity(0.8)],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 32,
                  left: 32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('EXCLUSIVES', style: TextStyle(color: Color(0xFFBFDBFE), fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.2)),
                      const SizedBox(height: 8),
                      const Text('Elevated Basics', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w700, height: 1.1)),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 9),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        child: const Text('Explore Now', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildNewArrivalCard('https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800', 'Living Spaces'),
          const SizedBox(height: 24),
          _buildNewArrivalCard('https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=800', 'Wellness Edit'),
        ],
      ),
    );
  }

  Widget _buildNewArrivalCard(String imageUrl, String title) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image.network(imageUrl, height: 288, width: double.infinity, fit: BoxFit.cover),
          Container(height: 288, color: const Color(0xFF2C2F30).withOpacity(0.2)),
          Positioned(bottom: 24, left: 24, child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700))),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'HOME'},
      {'icon': Icons.search, 'label': 'SEARCH'},
      {'icon': Icons.shopping_bag_outlined, 'label': 'CART'},
      {'icon': Icons.person_outline, 'label': 'PROFILE'},
    ];
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(color: const Color(0xFF2C2F30).withOpacity(0.04), blurRadius: 24, offset: const Offset(0, -4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = _currentIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _currentIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: isSelected ? const Color(0xFF2563EB) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item['icon'] as IconData, color: isSelected ? Colors.white : const Color(0xFF2C2F30), size: 20),
                  const SizedBox(height: 4),
                  Text(item['label'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: isSelected ? Colors.white : const Color(0xFF2C2F30))),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}