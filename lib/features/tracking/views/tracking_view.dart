import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:huungry/core/theme/app_colors.dart';

class TrackingView extends StatefulWidget {
  const TrackingView({super.key});

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  late GoogleMapController _mapController;
  final LatLng _center = const LatLng(37.7749, -122.4194); // San Francisco
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: const MarkerId('driver'),
        position: _center,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Your Order'),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    // Set map style here if JSON is available
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14.0,
            ),
            markers: _markers,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
          ),

          // Back Button
          Positioned(
            top: 50.h,
            left: 16.w,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ).animate().fadeIn(duration: 500.ms),

          // Driver Info Card
          Positioned(
            bottom: 30.h,
            left: 16.w,
            right: 16.w,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Driver Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundImage: const AssetImage('assets/test/test.png'), // Placeholder
                        backgroundColor: AppColors.inputBackgroundLight,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimaryLight,
                              ),
                            ),
                            Text(
                              'Your Delivery Partner',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.textSecondaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryOrange.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.phone,
                          color: AppColors.primaryOrange,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Divider(color: AppColors.borderLight),
                  SizedBox(height: 16.h),
                  
                  // Status Timeline
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTimelineItem('Picked Up', true),
                      _buildTimelineLine(true),
                      _buildTimelineItem('On Way', true),
                      _buildTimelineLine(false),
                      _buildTimelineItem('Delivered', false),
                    ],
                  ),
                  
                  SizedBox(height: 20.h),
                  
                  // ETA
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        'Estimated Arrival: 15 mins',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().slideY(begin: 1, end: 0, duration: 600.ms, curve: Curves.easeOutBack),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String label, bool isActive) {
    return Column(
      children: [
        Icon(
          Icons.check_circle,
          color: isActive ? AppColors.primaryOrange : AppColors.borderLight,
          size: 20.sp,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: isActive ? AppColors.textPrimaryLight : AppColors.textSecondaryLight,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2.h,
        color: isActive ? AppColors.primaryOrange : AppColors.borderLight,
      ),
    );
  }
}
