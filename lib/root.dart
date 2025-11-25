import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:huungry/features/auth/views/profile_view.dart';
import 'package:huungry/features/cart/views/cart_view.dart';
import 'package:huungry/features/cart/providers/cart_provider.dart';
import 'package:huungry/features/home/views/home_view.dart';
import 'package:huungry/features/product/views/products_list_view.dart';
import 'package:huungry/features/orderHistory/views/order_history_view.dart';
import 'package:huungry/shared/custom_text.dart';
import 'package:huungry/shared/glass_nav.dart';

class Root extends StatefulWidget {
  Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin {
  late PageController controller;
  late List<Widget> screens;
  int currentScreen = 0;

  late List<AnimationController> iconControllers;

  @override
  void initState() {
    super.initState();

    screens = [
      HomeView(),
      const ProductsListView(),
      CartView(),
      OrderHistoryView(),
      ProfileView(),
    ];

    controller = PageController(initialPage: 0);
    iconControllers = List.generate(
      5,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    iconControllers[currentScreen].forward();
  }

  @override
  void dispose() {
    controller.dispose();
    for (var c in iconControllers) c.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() => currentScreen = index);
    controller.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutExpo,
    );

    // Animate selected icon
    iconControllers[index].forward();

    // Reverse others
    for (var i = 0; i < iconControllers.length; i++) {
      if (i != index) iconControllers[i].reverse();
    }
  }

  Widget _safeAnimatedIcon(
    AnimatedIconData data,
    int idx, {
    double? size,
    Widget? fallback,
  }) {
    if (iconControllers.length > idx) {
      return AnimatedIcon(icon: data, progress: iconControllers[idx]);
    }
    return fallback ?? Icon(CupertinoIcons.circle);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: true,
        body: PageView(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          children: screens,
        ),
        bottomNavigationBar: GlassBottomNavBar(
          currentIndex: currentScreen,
          onTap: _onTabTapped,
          items: [
            BottomNavItemData(
              label: 'Home',
              icon: Icon(CupertinoIcons.home),
              filledIcon: _safeAnimatedIcon(
                AnimatedIcons.menu_home,
                0,
                fallback: Icon(CupertinoIcons.home),
              ),
            ),
            BottomNavItemData(
              label: 'Products',
              icon: Icon(Icons.grid_view),
              filledIcon: _safeAnimatedIcon(
                AnimatedIcons.view_list,
                1,
                fallback: Icon(Icons.grid_view),
              ),
            ),
            BottomNavItemData(
              label: 'Cart',
              icon: Icon(CupertinoIcons.cart),
              filledIcon: Consumer<CartProvider>(
                builder:
                    (context, cart, _) =>
                        cart.itemCount > 0
                            ? Badge(
                              label: CustomText(
                                text: '${cart.itemCount}',
                                size: 10,
                              ),
                              child: _safeAnimatedIcon(
                                AnimatedIcons.view_list,
                                2,
                                fallback: Icon(CupertinoIcons.cart),
                              ),
                            )
                            : _safeAnimatedIcon(
                              AnimatedIcons.view_list,
                              2,
                              fallback: Icon(CupertinoIcons.cart),
                            ),
              ),
            ),
            BottomNavItemData(
              label: 'History',
              icon: Icon(Icons.table_bar_outlined),
              filledIcon: Icon(Icons.table_bar),
            ),
            BottomNavItemData(
              label: 'Profile',
              icon: Icon(CupertinoIcons.person_alt_circle),
              filledIcon: _safeAnimatedIcon(
                AnimatedIcons.arrow_menu,
                4,
                size: 20,
                fallback: Icon(CupertinoIcons.person_alt_circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
