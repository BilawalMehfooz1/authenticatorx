import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserData {
  String email;
  String password;
  String username;

  UserData()
      : email = '',
        password = '',
        username = '';

  void getUsername(String u) {
    username = u;
  }

  void getPassword(String p) {
    password = p;
  }

  void getEmail(String e) {
    email = e;
    print(username);
    print(email);
    print(password);
  }
}

final userDataProvider = StateProvider<UserData>((ref) => UserData());
