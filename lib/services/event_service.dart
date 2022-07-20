import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:wedding_app/data/event.dart';
import '../utils/constants.dart';

class EventService {
  Dio dio = Dio();
  final String path = Constants.BASE_URL;

  Future<List<Event>> getEvents() async {
    final url = '$path/service/event';

    try {
      final response = await dio.get(url);
      final data = response.data as List;
      return data.map((e) => Event.fromJson(e)).toList();
    } catch (e) {
      log('ERROR: $e');
      throw Exception(e);
    }
  }
}
