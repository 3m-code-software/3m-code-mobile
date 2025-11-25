import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huungry/core/theme/app_colors.dart';
import 'package:huungry/core/network/api_error.dart';
import 'package:huungry/features/auth/data/auth_repo.dart';
import 'package:huungry/features/auth/data/user_model.dart';
import 'package:huungry/features/auth/views/login_view.dart';
import 'package:huungry/features/auth/widgets/custom_text_field.dart';
import 'package:huungry/shared/custom_snack.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isGuest = false;
  UserModel? _userModel;
  String? _selectedImage;
  bool _isLoadingUpdate = false;
  bool _isLoadingLogout = false;
  final AuthRepo _authRepo = AuthRepo();

  Future<void> _autoLogin() async {
    final user = await _authRepo.autoLogin();
    setState(() => _isGuest = _authRepo.isGuest);
    if (user != null) setState(() => _userModel = user);
  }

  Future<void> _getProfileData() async {
    try {
      final user = await _authRepo.getProfileData();
      setState(() {
        _userModel = user;
        _nameController.text = user?.name ?? '';
        _emailController.text = user?.email ?? '';
        _addressController.text = user?.address ?? '';
      });
    } catch (e) {
      String errorMsg = 'Error loading profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
      }
    }
  }

  Future<void> _updateProfile() async {
    try {
      setState(() => _isLoadingUpdate = true);
      final user = await _authRepo.updateProfileData(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        address: _addressController.text.trim(),
        imagePath: _selectedImage,
      );
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(customSnack('Profile updated successfully'));
      }
      setState(() {
        _isLoadingUpdate = false;
        _userModel = user;
      });
      await _getProfileData();
    } catch (e) {
      setState(() => _isLoadingUpdate = false);
      String errorMsg = 'Failed to update profile';
      if (e is ApiError) errorMsg = e.message;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
      }
    }
  }

  Future<void> _logout() async {
    try {
      setState(() => _isLoadingLogout = true);
      await _authRepo.logout();
      if (mounted) {
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => const LoginView()),
        );
      }
      setState(() => _isLoadingLogout = false);
    } catch (e) {
      setState(() => _isLoadingLogout = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(customSnack('Logout failed'));
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _autoLogin();
    _getProfileData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isGuest) {
      return _buildGuestView();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox.shrink(),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            color: AppColors.textPrimary,
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _getProfileData,
        child: Skeletonizer(
          enabled: _userModel == null,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Profile Picture
                _buildProfilePicture(),

                SizedBox(height: 24.h),

                // User Name
                Text(
                  _userModel?.name ?? 'Loading...',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  _userModel?.email ?? 'email@example.com',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),

                SizedBox(height: 32.h),

                // Profile Form
                _buildProfileForm(),

                SizedBox(height: 24.h),

                // Action Buttons
                _buildActionButtons(),

                SizedBox(height: 16.h),

                // Logout Button
                _buildLogoutButton(),

                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Stack(
      children: [
        Container(
          width: 120.w,
          height: 120.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryBlue, width: 3),
          ),
          child: ClipOval(
            child:
                _selectedImage != null
                    ? Image.file(File(_selectedImage!), fit: BoxFit.cover)
                    : (_userModel?.image != null &&
                        _userModel!.image!.isNotEmpty)
                    ? Image.network(
                      _userModel!.image!,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, err, builder) => Icon(
                            Icons.person,
                            size: 60.sp,
                            color: AppColors.textSecondary,
                          ),
                    )
                    : Icon(
                      Icons.person,
                      size: 60.sp,
                      color: AppColors.textSecondary,
                    ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: Icon(Icons.camera_alt, color: Colors.white, size: 20.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileForm() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            labelText: 'Full Name',
            hintText: 'Enter your name',
            controller: _nameController,
            prefixIcon: Icon(
              Icons.person_outline,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            labelText: 'Email',
            hintText: 'Enter your email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            labelText: 'Address',
            hintText: 'Enter your address',
            controller: _addressController,
            maxLines: 2,
            prefixIcon: Icon(
              Icons.location_on_outlined,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoadingUpdate ? null : _updateProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child:
                _isLoadingUpdate
                    ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return OutlinedButton(
      onPressed: _isLoadingLogout ? null : _logout,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.red,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
        side: const BorderSide(color: Colors.red, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child:
          _isLoadingLogout
              ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              )
              : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.logout),
                  SizedBox(width: 8.w),
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildGuestView() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_off_outlined,
              size: 100.sp,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 16.h),
            Text(
              'Guest Mode',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Sign in to access your profile',
              style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (c) => const LoginView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
              ),
              child: Text('Sign In', style: TextStyle(fontSize: 16.sp)),
            ),
          ],
        ),
      ),
    );
  }
}
