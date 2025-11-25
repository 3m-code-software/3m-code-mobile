import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:huungry/splash.dart';
import 'package:provider/provider.dart';
import 'package:huungry/features/product/providers/product_provider.dart';
import 'package:huungry/features/cart/providers/cart_provider.dart';
import 'package:huungry/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables before anything that may use them (DioClient reads dotenv.env)
  try {
    await dotenv.load();
  } catch (e) {
    // If .env is missing or fails to load, continue with defaults defined in code.
    // Use debugPrint to avoid leaking in release.
    // ignore: avoid_print
    print('dotenv load warning: $e');
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder:
          (context, child) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ProductProvider()),
              ChangeNotifierProvider(create: (_) => CartProvider()),
            ],
            child: const MyApp(),
          ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3M Code', // Updated Title
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashView(),
    );
  }
}
