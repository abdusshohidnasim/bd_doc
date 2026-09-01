import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../endpoints.dart';
import 'log.dart';
import '../../helpers/di.dart';
import '../../constants/app_constants.dart';

final class DioSingleton {
  static final DioSingleton _singleton = DioSingleton._internal();
  static CancelToken cancelToken = CancelToken();
  DioSingleton._internal();

  static DioSingleton get instance => _singleton;

  late Dio dio;
  Future<bool>? _refreshFuture;

  void create() {
    BaseOptions options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
      headers: {
        NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        NetworkConstants.CONTENT_TYPE: NetworkConstants.ACCEPT_TYPE,
      },
    );

    dio = Dio(options)
      ..interceptors.add(Logger())
      ..interceptors.add(_getInterceptor());
  }

  void update(String auth) {
    if (kDebugMode) {
      print("Dio update with auth token");
    }
    final Map<String, dynamic> headers = {
      NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
      NetworkConstants.CONTENT_TYPE: NetworkConstants.ACCEPT_TYPE,
    };
    if (auth.isNotEmpty) {
      headers[NetworkConstants.AUTHORIZATION] = "Bearer $auth";
    }
    BaseOptions options = BaseOptions(
      baseUrl: url,
      responseType: ResponseType.json,
      headers: headers,
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
    );

    dio = Dio(options)
      ..interceptors.add(Logger())
      ..interceptors.add(_getInterceptor());
  }

  Interceptor _getInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Prevent infinite retry recursion loop
          if (error.requestOptions.extra['isRetry'] == true) {
            _handleGlobalError(error);
            return handler.reject(error);
          }

          final isRefreshed = await _refreshToken();
          if (isRefreshed) {
            final newAccessToken = appData.read(kKeyAccessToken);
            final RequestOptions options = error.requestOptions;
            options.headers[NetworkConstants.AUTHORIZATION] =
                "Bearer $newAccessToken";
            options.extra['isRetry'] = true;

            try {
              // Re-executing request with new token
              final response = await dio.request(
                options.path,
                data: options.data,
                queryParameters: options.queryParameters,
                options: Options(
                  method: options.method,
                  headers: options.headers,
                  extra: options.extra,
                ),
              );
              return handler.resolve(response);
            } catch (retryError) {
              if (retryError is DioException) {
                return handler.reject(retryError);
              }
              return handler.reject(error);
            }
          } else {
            _handleGlobalError(error);
            return handler.reject(error);
          }
        }

        if (_isGlobalError(error)) {
          _handleGlobalError(error);
          return handler.reject(error);
        }
        return handler.next(error);
      },
    );
  }

  Future<bool> _refreshToken() async {
    if (_refreshFuture != null) {
      return _refreshFuture!;
    }

    final String? refreshToken = appData.read(kkeyrefreshToken);
    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    _refreshFuture = _performTokenRefresh(refreshToken);
    final result = await _refreshFuture!;
    _refreshFuture = null;
    return result;
  }

  Future<bool> _performTokenRefresh(String refreshToken) async {
    // List of common endpoints to try dynamically
    final List<String> endpoints = [
      "account/refresh/",
      "account/refresh-token/",
      "account/refresh_token/",
      "account/refresh_access/",
      "account/refresh-access/",
      "account/token/refresh/",
      "account/token/refresh-token/",
      "account/token/refresh_token/",
      "account/token-refresh/",
      "account/token_refresh/",
      "token/refresh/",
      "token/refresh-token/",
      "token/refresh_token/",
      "auth/refresh-token/",
      "auth/refresh_token/",
      "auth/refresh/",
      "auth/token/refresh/",
    ];

    if (kDebugMode) {
      print("[Token Refresh] Starting token refresh process...");
      print("[Token Refresh] Current Refresh Token: $refreshToken");
    }

    // Using a separate Dio instance to perform the refresh call
    // to avoid interception by the current interceptor (causing recursion)
    final Dio refreshDio = Dio(BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    for (final endpoint in endpoints) {
      if (kDebugMode) {
        print("[Token Refresh] Trying endpoint: $url$endpoint");
      }
      try {
        final Response response = await refreshDio.post(
          endpoint,
          data: {
            "refresh": refreshToken,
            "refresh_token": refreshToken,
          },
        );

        if (kDebugMode) {
          print("[Token Refresh] Response Status Code: ${response.statusCode}");
          print("[Token Refresh] Response Data: ${response.data}");
        }

        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = response.data;
          final dynamic dataObj =
              (data is Map && data.containsKey('data')) ? data['data'] : data;

          final newAccessToken = dataObj['access']?.toString() ??
              dataObj['access_token']?.toString() ??
              dataObj['token']?.toString();
          final newRefreshToken = dataObj['refresh']?.toString() ??
              dataObj['refresh_token']?.toString();

          if (newAccessToken != null && newAccessToken.isNotEmpty) {
            await appData.write(kKeyAccessToken, newAccessToken);
            if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
              await appData.write(kkeyrefreshToken, newRefreshToken);
            }
            update(newAccessToken);
            if (kDebugMode) {
              print(
                  "[Token Refresh] Successfully refreshed token! New access token: $newAccessToken");
              if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
                print(
                    "[Token Refresh] New refresh token saved: $newRefreshToken");
              }
            }
            return true;
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(
              "[Token Refresh] Failed to refresh token for endpoint: $endpoint");
          if (e is DioException) {
            print("[Token Refresh] Status code: ${e.response?.statusCode}");
            print("[Token Refresh] Response data: ${e.response?.data}");
            print("[Token Refresh] Error: ${e.message}");
          } else {
            print("[Token Refresh] Exception: $e");
          }
        }
        if (e is DioException) {
          if (e.response?.statusCode == 404) {
            continue;
          }
          if (e.response?.statusCode == 401 || e.response?.statusCode == 400) {
            return false;
          }
        }
      }
    }
    return false;
  }

  bool _isGlobalError(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.response?.statusCode == 401 ||
        error.response?.statusCode == 403 ||
        error.response?.statusCode == 500 ||
        error.response?.statusCode == 502 ||
        error.response?.statusCode == 503;
  }

  void _handleGlobalError(DioException error) {
    // if (error.type == DioExceptionType.connectionError) {
    //   _navigateToScreen('/network-error');
    // }
    // else if (error.response?.statusCode == 401) {
    //   _navigateToScreen('/login');
    // }
    // else if (error.response?.statusCode == 500) {
    //   _navigateToScreen('/server-error');
    // }

    if (error.response?.statusCode == 401) {
      appData.write(kKeyIsLoggedIn, false);
      appData.remove(kKeyAccessToken);
      appData.remove(kkeyrefreshToken);
      update("");
      // NavigationService.navigateToUntilReplacement(Routes.loginScreen);
    }
  }

  // void _navigateToScreen(String route) {
  //   if (getx.Get.currentRoute != route) {
  //     getx.Get.offAllNamed(route);
  //   }
  // }
}

// Simplified HTTP methods - global errors are already handled by interceptor
Future<Response> postHttp(String path, [dynamic data]) async {
  return DioSingleton.instance.dio.post(
    path,
    data: data,
    cancelToken: DioSingleton.cancelToken,
  );
}

Future<Response> putHttp(String path, [dynamic data]) async {
  return DioSingleton.instance.dio.put(
    path,
    data: data,
    cancelToken: DioSingleton.cancelToken,
  );
}

Future<Response> getHttp(String path,
    [dynamic data, Map<String, dynamic>? queryParameters]) async {
  return DioSingleton.instance.dio.get(
    path,
    data: data,
    queryParameters: queryParameters,
    cancelToken: DioSingleton.cancelToken,
  );
}

Future<Response> deleteHttp(String path, [dynamic data]) async {
  return DioSingleton.instance.dio.delete(
    path,
    data: data,
    cancelToken: DioSingleton.cancelToken,
  );
}
