import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:huungry/core/constants/api_endpoints.dart';
import 'package:huungry/core/network/api_error.dart';
import 'package:huungry/core/network/api_exceptions.dart';
import 'package:huungry/core/network/api_service.dart';
import 'package:huungry/core/utils/pref_helper.dart';
import 'package:huungry/features/auth/data/user_model.dart';
import 'package:logger/logger.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  bool isGuest = false;
  UserModel? _currentUser;
  final Logger _logger = Logger();

  /// Login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post(ApiEndpoints.login, {
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final rawCode = response['code'];
        final int code =
            int.tryParse(rawCode?.toString() ?? '') ??
            (rawCode is int ? rawCode : 0);
        final data = response['data'];

        if (code != 200 && code != 201) {
          throw ApiError(message: msg ?? 'Unknown error', statusCode: code);
        }

        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }

        isGuest = false;
        _currentUser = user;
        return user;
      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Signup
  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiService.post(ApiEndpoints.register, {
        'name': name,
        'password': password,
        'email': email,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final rawCode = response['code'];
        final coder =
            int.tryParse(rawCode?.toString() ?? '') ??
            (rawCode is int ? rawCode : 0);
        final data = response['data'];

        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }

        /// condtion assement
        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        isGuest = false;
        _currentUser = user;
        return user;
      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Get Profile data
  Future<UserModel?> getProfileData() async {
    try {
      final token = await PrefHelper.getToken();
      if (token == null || token == 'guest') {
        return null;
      }

      final response = await apiService.get(ApiEndpoints.profile);
      final user = UserModel.fromJson(response['data']);
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// update profile data
  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'address': address,
        if (visa != null && visa.isNotEmpty) 'Visa': visa,
        if (imagePath != null && imagePath.isNotEmpty)
          'image': await MultipartFile.fromFile(
            imagePath,
            filename: 'profile.jpg',
          ),
      });
      final response = await apiService.post(
        ApiEndpoints.updateProfile,
        formData,
      );
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];
        final coder = int.tryParse(code);

        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }

        final updatedUser = UserModel.fromJson(data);
        _currentUser = updatedUser;
        return updatedUser;
      } else {
        throw ApiError(message: 'Invalid  Error from here');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Logout
  Future<void> logout() async {
    final response = await apiService.post(ApiEndpoints.logout, {});
    if (response is Map<String, dynamic>) {
      final rawCode = response['code'];
      final int code =
          int.tryParse(rawCode?.toString() ?? '') ??
          (rawCode is int ? rawCode : 0);
      if (code == 200 || code == 201) {
        await PrefHelper.clearToken();
        _currentUser = null;
        isGuest = true;
        return;
      } else {
        throw ApiError(
          message: response['message'] ?? 'Logout failed',
          statusCode: code,
        );
      }
    }
    // if response not map, still clear token locally
    await PrefHelper.clearToken();
    _currentUser = null;
    isGuest = true;
  }

  /// auto login
  Future<UserModel?> autoLogin() async {
    final token = await PrefHelper.getToken();

    if (token == null || token == 'guest') {
      _logger.i('❌ No valid token found - setting as guest');
      isGuest = true;
      _currentUser = null;
      return null;
    }
    _logger.i('✅ Valid token found - attempting to fetch profile');
    isGuest = false;

    try {
      final user = await getProfileData();
      _logger.i('✅ Profile data fetched successfully');
      _currentUser = user;
      return user;
    } catch (e) {
      _logger.e('❌ Profile fetch failed: $e');
      _logger.w('🧹 Clearing invalid token and setting as guest');
      await PrefHelper.clearToken();
      isGuest = true;
      _currentUser = null;
      return null;
    }
  }

  /// continue as guest
  Future<void> continueAsGuest() async {
    isGuest = true;
    _currentUser = null;
    await PrefHelper.saveToken('guest');
  }

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => !isGuest && _currentUser != null;
}
