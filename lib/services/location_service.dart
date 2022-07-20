import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:wedding_app/data/event_location.dart';
import 'package:wedding_app/providers/token_provider.dart';
import '../utils/constants.dart';

class LocationService {
  Dio dio = Dio();
  final String path = Constants.BASE_URL;
  TokenDataProvider _tokenProvider = TokenDataProvider();

  Future<List<EventLocation>> getLocations({required int id}) async {
    final url = '$path/service/wedding_hall/?id=$id';

    final token = await _tokenProvider.box.read('tokenID');
    print(token);

    final parameters = <String, dynamic>{
      'Authorization': 'Bearer $token',
    };


    try {
      final response = await dio.get(url,options: Options(headers: parameters));
      final data = response.data as List;
      return data.map((e) => EventLocation.fromJson(e)).toList();
    } catch (e) {
      log('ERROR: $e');
      throw Exception(e);
    }
  }
}
