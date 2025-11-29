import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huungry/core/theme/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;
  final String hintText;

  const SearchBarWidget({
    super.key,
    this.onTap,
    this.onFilterTap,
    this.hintText = 'Search products...',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.inputBackgroundLight,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: AppColors.textSecondaryLight,
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                hintText,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ),
            GestureDetector(
              onTap: onFilterTap,
              child: Icon(
                Icons.tune,
                color: AppColors.primaryOrange,
                size: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
