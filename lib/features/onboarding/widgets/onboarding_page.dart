import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/onboarding_model.dart';
import 'package:huungry/core/theme/app_colors.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;
  final bool isActive;

  const OnboardingPage({super.key, required this.model, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image with floating animation
          Expanded(
            flex: 3,
            child: Image.asset(model.imagePath, fit: BoxFit.contain)
                .animate(target: isActive ? 1 : 0)
                .scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1, 1),
                  duration: 600.ms,
                  curve: Curves.easeOutBack,
                )
                .fadeIn(duration: 500.ms),
          ),

          SizedBox(height: 40.h),

          // Text Content
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                      model.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryLight,
                        height: 1.2,
                      ),
                    )
                    .animate(target: isActive ? 1 : 0)
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    )
                    .fadeIn(duration: 600.ms),

                SizedBox(height: 16.h),

                Text(
                      model.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textSecondaryLight,
                        height: 1.5,
                      ),
                    )
                    .animate(target: isActive ? 1 : 0)
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      duration: 600.ms,
                      delay: 100.ms,
                      curve: Curves.easeOut,
                    )
                    .fadeIn(duration: 600.ms, delay: 100.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
