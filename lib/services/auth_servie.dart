import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:wedding_app/data/user.dart';
import 'package:wedding_app/utils/constants.dart';

class AuthService {
  Dio dio = Dio();
  final String path = Constants.BASE_URL;

  Future<User> registerUser({
    required String username,
    required String phone,
    required String cite,
    required String weddingDate,
  }) async {
    final url = '$path/accounts/register/';

    final parameters = {
      "username": username,
      "phone": phone,
      "cite": cite,
      "wedding_date": weddingDate
    };
    try {
      final response = await dio.post(url, data: parameters);
      final data = response.data;
      return User.fromJson(data);
    } catch (e) {
      log('ERROR: $e');
      throw Exception();
    }
  }

  Future<String> makeToken({required String phone}) async {
    final url = '$path/accounts/api/token/';
    final parameters = {"phone": phone, "password": "yusuf123"};

    try {
      final response = await dio.post(url, data: parameters);
      final data = response.data;

      return data['access'];

      // final token = Token(
      //   access: data['access'],
      //   refresh: data['refresh'],
      // );
      // return token;
    } catch (e) {
      log('ERROR: $e');
      throw Exception();
    }
  }
}
