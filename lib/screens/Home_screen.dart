import 'package:flutter/material.dart';

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
                    _buildSearchBar(),
                    _buildHeroSection(),
                    _buildCategoriesSection(),
                    _buildTopTrendingSection(),
                    _buildNewArrivalsSection(),
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
            child: _buildBottomNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: const [
            Icon(Icons.search, color: Color(0xFFABADAE)),
            SizedBox(width: 12),
            Text(
              'What are you looking for?',
              style: TextStyle(
                color: Color(0xFFABADAE),
                fontSize: 14,
              ),
            ),
          ],
        ),
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
                    child: const Text('NEW SEASON', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
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
                            if (isSelected) {
                              _selectedCategoryIndex = -1;
                            } else {
                              _selectedCategoryIndex = index;
                            }
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
                                : const RadialGradient(
                                    center: Alignment(-0.3, -0.4),
                                    radius: 0.8,
                                    colors: [Color(0xFFF9FAFB), Color(0xFFD1D5DB)],
                                  ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? const Color(0xFF2563EB).withOpacity(0.4)
                                    : Colors.black.withOpacity(0.1),
                                blurRadius: isSelected ? 15 : 10,
                                offset: const Offset(0, 6),
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            category['icon'] as IconData,
                            color: isSelected ? Colors.white : const Color(0xFF4B5563),
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
                          color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF4B5563),
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
                  fontSize: 28,
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
              crossAxisSpacing: 20,
              mainAxisSpacing: 24,
              childAspectRatio: 0.68,
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
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFABADAE).withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
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
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_border, size: 16, color: Color(0xFF2C2F30)),
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
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF2C2F30), height: 1.3),
        ),
        const SizedBox(height: 4),
        Text(
          product['price'] as String,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF2563EB)),
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
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF2C2F30), letterSpacing: -0.75),
          ),
          const SizedBox(height: 32),
          _buildArrivalItem(
            imageUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=800',
            tag: 'EXCLUSIVES',
            title: 'Elevated Basics',
            height: 400,
          ),
          const SizedBox(height: 20),
          _buildArrivalItem(
            imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
            tag: 'INTERIOR',
            title: 'Living Spaces',
            height: 280,
          ),
          const SizedBox(height: 20),
          _buildArrivalItem(
            imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800',
            tag: 'TECH STYLE',
            title: 'Minimal Gear',
            height: 280,
          ),
        ],
      ),
    );
  }

  Widget _buildArrivalItem({required String imageUrl, required String tag, required String title, required double height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, const Color(0xFF2C2F30).withOpacity(0.8)],
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

  Widget _buildBottomNavBar() {
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
            onTap: () => setState(() => _currentIndex = index),
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
                          color: const Color(0xFF2563EB).withOpacity(0.3),
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
                    color: isSelected ? Colors.white : const Color(0xFF2C2F30),
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