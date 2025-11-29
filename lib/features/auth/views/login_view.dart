import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huungry/core/theme/app_colors.dart';
import 'package:huungry/core/network/api_error.dart';
import 'package:huungry/features/auth/data/auth_repo.dart';
import 'package:huungry/features/auth/views/forgot_password_view.dart';
import 'package:huungry/features/auth/views/signup_view.dart';
import 'package:huungry/features/auth/widgets/custom_buttons.dart';
import 'package:huungry/features/auth/widgets/custom_text_field.dart';
import 'package:huungry/root.dart';
import 'package:huungry/shared/custom_snack.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;

  final AuthRepo _authRepo = AuthRepo();

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final user = await _authRepo.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        if (user != null) {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (c) => Root()),
          );
        }
        if (mounted) {
          setState(() => _isLoading = false);
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
        }
        String errorMsg = 'Login failed. Please try again.';
        if (e is ApiError) {
          errorMsg = e.message;
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
        }
      }
    }
  }

  void _handleGuestLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (c) => Root()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),

                // Logo/Icon
                Center(
                      child: Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryOrange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Icon(
                          Icons.restaurant_menu_rounded,
                          size: 40.sp,
                          color: AppColors.primaryOrange,
                        ),
                      ),
                    )
                    .animate()
                    .scale(duration: 600.ms, curve: Curves.easeOutBack)
                    .fadeIn(duration: 500.ms),

                SizedBox(height: 32.h),

                // Welcome text
                Text(
                      'Welcome back!',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryLight,
                      ),
                    )
                    .animate()
                    .slideX(
                      begin: -0.2,
                      end: 0,
                      duration: 500.ms,
                      curve: Curves.easeOut,
                    )
                    .fadeIn(),

                SizedBox(height: 8.h),

                Text(
                      'Sign in to your account to continue',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textSecondaryLight,
                      ),
                    )
                    .animate()
                    .slideX(
                      begin: -0.2,
                      end: 0,
                      duration: 500.ms,
                      delay: 100.ms,
                      curve: Curves.easeOut,
                    )
                    .fadeIn(),

                SizedBox(height: 32.h),

                // Email field
                CustomTextField(
                  labelText: 'Email Address',
                  hintText: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: AppColors.textSecondaryLight,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

                SizedBox(height: 16.h),

                // Password field
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppColors.textSecondaryLight,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textSecondaryLight,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),

                SizedBox(height: 16.h),

                // Remember me & Forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                            activeColor: AppColors.primaryOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Remember me',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const ForgotPasswordView(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primaryOrange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 400.ms),

                SizedBox(height: 24.h),

                // Sign In Button
                PrimaryButton(
                  text: 'Sign In',
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                ).animate().fadeIn(delay: 500.ms).scale(),

                SizedBox(height: 16.h),

                // OR Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.borderLight,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.borderLight,
                        thickness: 1,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 600.ms),

                SizedBox(height: 16.h),

                // Social Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(
                      icon:
                          'assets/icon/google.png', // Ensure asset exists or use Icon
                      onTap: () {},
                    ),
                    SizedBox(width: 16.w),
                    _buildSocialButton(
                      icon:
                          'assets/icon/apple.png', // Ensure asset exists or use Icon
                      onTap: () {},
                    ),
                  ],
                ).animate().fadeIn(delay: 650.ms),

                SizedBox(height: 24.h),

                // Continue as Guest
                SecondaryButton(
                  text: 'Continue as Guest',
                  onPressed: _handleGuestLogin,
                ).animate().fadeIn(delay: 700.ms),

                SizedBox(height: 24.h),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (c) => SignupView()),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primaryOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 800.ms),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.inputBackgroundLight,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderLight),
        ),
        padding: EdgeInsets.all(12.w),
        child: Image.asset(
          icon,
          errorBuilder: (c, e, s) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
