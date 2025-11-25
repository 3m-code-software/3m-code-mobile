import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huungry/core/theme/app_colors.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_chip.dart';
import '../widgets/product_card.dart';
import '../widgets/banner_carousel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedCategoryIndex = 0;

  // Use actual categories data with proper typing
  final List<Map<String, dynamic>> categories = [
    {'title': 'All', 'icon': Icons.grid_view},
    {'title': 'Electronics', 'icon': Icons.devices},
    {'title': 'Fashion', 'icon': Icons.checkroom},
    {'title': 'Home & Kitchen', 'icon': Icons.home},
    {'title': 'Sports', 'icon': Icons.sports_basketball},
    {'title': 'Beauty', 'icon': Icons.spa},
    {'title': 'Books', 'icon': Icons.book},
    {'title': 'Toys', 'icon': Icons.toys},
    {'title': 'Automotive', 'icon': Icons.directions_car},
  ];

  // Use actual banner images
  final List<String> banners = [
    'assets/banner/banner_electronics_sale_1764031138976.png',
    'assets/banner/banner_fashion_new_1764031790621.png',
    'assets/banner/banner_home_deals_1764031756289.png',
    'assets/banner/banner_sports_fitness_1764031805518.png',
  ];

  // Featured products (will show products with discounts)
  final List<Map<String, dynamic>> products = [
    {
      'image': 'assets/products/product_smartphone_pro_1764031825153.png',
      'title': 'iPhone 15 Pro Max',
      'price': '1199.99',
      'oldPrice': '1299.99',
      'rating': 4.8,
    },
    {
      'image': 'assets/products/product_laptop_silver_1764031839984.png',
      'title': 'MacBook Air M3',
      'price': '1099.99',
      'rating': 4.9,
    },
    {
      'image': 'assets/test/test.png',
      'title': 'Sony WH-1000XM5',
      'price': '349.99',
      'oldPrice': '399.99',
      'rating': 4.7,
    },
    {
      'image': 'assets/test/test.png',
      'title': 'Nike Air Max 270',
      'price': '149.99',
      'rating': 4.7,
    },
    {
      'image': 'assets/test/test.png',
      'title': 'Ninja Air Fryer',
      'price': '119.99',
      'rating': 4.7,
    },
    {
      'image': 'assets/test/test.png',
      'title': 'Adjustable Dumbbell Set',
      'price': '299.99',
      'oldPrice': '349.99',
      'rating': 4.7,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 20.sp,
              color: AppColors.primaryBlue,
            ),
            SizedBox(width: 4.w),
            Text(
              'Delivery to',
              style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
            ),
            SizedBox(width: 4.w),
            Text(
              'New York',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 20.sp,
              color: AppColors.textPrimary,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),

            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SearchBarWidget(
                onTap: () {
                  // Navigate to search screen
                },
              ),
            ),

            SizedBox(height: 24.h),

            // Banner Carousel
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: BannerCarousel(imageUrls: banners),
            ),

            SizedBox(height: 24.h),

            // Section Header - Categories
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Categories Horizontal List
            SizedBox(
              height: 50.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryChip(
                    title: categories[index]['title'] as String,
                    icon: categories[index]['icon'] as IconData,
                    isSelected: _selectedCategoryIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 24.h),

            // Section Header - Featured Products
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Products',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Products Grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    imageUrl: product['image'],
                    title: product['title'],
                    price: product['price'],
                    oldPrice: product['oldPrice'],
                    rating: product['rating'],
                    onTap: () {
                      // Navigate to product details
                    },
                    onFavorite: () {
                      // Add to favorites
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
