import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huungry/core/theme/app_colors.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(0, 1000);
  int _selectedRating = 0;
  final List<String> _categories = [
    'All',
    'Electronics',
    'Fashion',
    'Home',
    'Beauty',
    'Sports',
  ];
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Search',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryLight,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
                color: AppColors.textSecondaryLight,
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Price Range
          Text(
            'Price Range',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryLight,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${_priceRange.start.round()}',
                style: TextStyle(color: AppColors.primaryOrange),
              ),
              Text(
                '\$${_priceRange.end.round()}',
                style: TextStyle(color: AppColors.primaryOrange),
              ),
            ],
          ),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 2000,
            divisions: 20,
            activeColor: AppColors.primaryOrange,
            inactiveColor: AppColors.borderLight,
            onChanged: (values) {
              setState(() {
                _priceRange = values;
              });
            },
          ),
          SizedBox(height: 24.h),

          // Categories
          Text(
            'Category',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryLight,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children:
                _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    backgroundColor: AppColors.inputBackgroundLight,
                    selectedColor: AppColors.primaryOrange.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color:
                          isSelected
                              ? AppColors.primaryOrange
                              : AppColors.textSecondaryLight,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: BorderSide(
                        color:
                            isSelected
                                ? AppColors.primaryOrange
                                : AppColors.borderLight,
                      ),
                    ),
                    showCheckmark: false,
                  );
                }).toList(),
          ),
          SizedBox(height: 24.h),

          // Rating
          Text(
            'Rating',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryLight,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              final star = index + 1;
              final isSelected = _selectedRating == star;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedRating = star;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? AppColors.primaryOrange
                            : AppColors.inputBackgroundLight,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color:
                          isSelected
                              ? AppColors.primaryOrange
                              : AppColors.borderLight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16.sp,
                        color: isSelected ? Colors.white : Colors.amber,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '$star',
                        style: TextStyle(
                          color:
                              isSelected
                                  ? Colors.white
                                  : AppColors.textPrimaryLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 32.h),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _priceRange = const RangeValues(0, 1000);
                      _selectedCategory = 'All';
                      _selectedRating = 0;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    side: BorderSide(color: AppColors.borderLight),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: AppColors.textSecondaryLight,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Apply filters logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Apply Filters',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
