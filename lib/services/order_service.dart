import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:wedding_app/data/order.dart';

import '../providers/token_provider.dart';
import '../utils/constants.dart';

class OrderService {
  Dio dio = Dio();
  final String path = Constants.BASE_URL;
  final TokenDataProvider _tokenProvider = TokenDataProvider();

  Future<Order> sendOrder(int id, List serives) async {
    final url = '$path/service/order/';

    final token = await _tokenProvider.box.read('tokenID');

    final parameters = {"menu": 1, "wedding_hall": id, "service": serives};

    try {
      final response = await dio.post(
        url,
        data: parameters,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 500) {
        throw Exception('already exists');
      }
      final data = response.data;
      return Order.fromJson(data);
    } catch (e) {
      log('ERROR: $e');
      throw Exception(e);
    }
  }
}
