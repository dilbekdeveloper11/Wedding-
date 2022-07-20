import 'dart:developer';
import 'package:dio/dio.dart';
import '../utils/constants.dart';
import '../data/service.dart';

class ServiceService {
  Dio dio = Dio();
  final String path = Constants.BASE_URL;

  Future<List<Service>> getServices() async {
    final url = '$path/service/services/';
    try {
      final response = await dio.get(url);
      final data = response.data as List;
      return data.map((e) => Service.fromJson(e)).toList();
    } catch (e) {
      log('ERROR: $e');
      throw Exception(e);
    }
  }
}
