import 'package:dio/dio.dart';

import 'result_data.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    bool isSuccessful = response.statusCode >= 200 && response.statusCode < 300;
    response.data = ResultData(
      body: response.data,
      isSuccessful: isSuccessful,
      statusCode: response.statusCode,
      headers: response.headers,
    );
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
