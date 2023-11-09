import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserData {
  String email;
  String password;
  String username;

  UserData()
      : email = '',
        password = '',
        username = '';

  void show() {
    print(username);
    print(email);
    print(password);
  }
}

final userDataProvider = StateProvider<UserData>((ref) => UserData());
