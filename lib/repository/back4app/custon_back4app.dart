import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pesquisacep/repository/back4app/back4app_interceptors.dart';

class CustonBack4app {
  final _dio = Dio();
  Dio get dio => _dio;

  CustonBack4app() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
    _dio.interceptors.add(Back4appInterceptors());
  }
}
