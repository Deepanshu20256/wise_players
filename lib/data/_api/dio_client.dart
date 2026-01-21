import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;
  factory DioClient() => _instance;
  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.example.com',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    //  dio.interceptors.add(AppInterceptor()); } }
  }
}
