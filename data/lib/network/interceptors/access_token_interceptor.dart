

import 'package:data/datasource/local/db/app_shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AccessTokenInterceptor extends InterceptorsWrapper {
  final AppSharedPreferences _sharedPreferences;

  AccessTokenInterceptor(this._sharedPreferences);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _sharedPreferences.getString(TokenKeys.accessToken);
    if (token != null) {
        options.headers[HeaderRequestConstants.basicAuthorization] = '${HeaderRequestConstants.bearer} $token';
    }
    super.onRequest(options, handler);
  }
}