import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:huungry/core/utils/pref_helper.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    // Read API base URL from env if available. Accessing dotenv.env can throw
    // NotInitializedError if dotenv.load() wasn't called or failed, so guard it.
    String baseUrl = 'https://sonic-zdi0.onrender.com/api';
    try {
      final envVal = dotenv.env['API_BASE_URL'];
      if (envVal != null && envVal.isNotEmpty) baseUrl = envVal;
    } catch (_) {
      // dotenv not initialized or failed to load; continue with fallback
    }
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {"Content-Type": 'application/json'},
      ),
    );
    // _dio.interceptors.add(
    //   LogInterceptor(requestBody: true, responseBody: true),
    // );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          // do not print tokens in logs; only attach if available
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
