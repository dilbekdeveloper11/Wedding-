import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:wedding_app/data/base.dart';
import '../utils/constants.dart';

class BaseService {
  Dio dio = Dio();
  final String path = Constants.BASE_URL;

  Future<List<Base>> getBase() async {
    final url = '$path/service/base_image/';
    try {
      final response = await dio.get(url);
      final data = response.data as List;
      return data.map((e) => Base.fromJson(e)).toList();
    } catch (e) {
      log('ERROR: $e');
      throw Exception(e);
    }
  }
}
