import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:wedding_app/data/galery.dart';
import '../utils/constants.dart';

class GaleryService {
  Dio dio = Dio();
  final String path = Constants.BASE_URL;

  Future<List<Galery>> getGalery() async {
    final url = '$path/service/system/';

    try {
      final response = await dio.get(url);
      final data = response.data as List;
      return data.map((e) => Galery.fromJson(e)).toList();
    } catch (e) {
      log('ERROR: $e');
      throw Exception(e);
    }
  }
}
