import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_calendar/1_presentatation/login_page/login_page_view_model.dart';
import 'package:test_calendar/2_data/repos/rest_api.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository());

final dio = Dio();

class AuthRepository {
  Future<String> testConnect() async {
    var result = await Api(dio).connectTest();
    print('####auth_repos.dart: testConnect: result: $result');
    return result;
  }

  Future<String> testLogin(String email, String password) async {
    var temp =
        await Api(dio).postLogin(UserInfo(email: email, password: password));
    print('####auth_repos.dart: testLogin: temp: $temp');
    return 'testLoginOK';
  }
}
