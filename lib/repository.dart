import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class Repository {

  final EncryptedSharedPreferences prefs =
  EncryptedSharedPreferences();

  String username = "";

  String password = "";

  String firstName = "";

  String lastName = "";

  String phone = "";

  String email = "";

  Future<void> loadData() async {
    username = await prefs.getString("username");

    password = await prefs.getString("password");

    firstName = await prefs.getString("firstName");

    lastName = await prefs.getString("lastName");

    phone = await prefs.getString("phone");

    email = await prefs.getString("email");
  }

  Future<void> saveData() async {
    await prefs.setString("username", username);

    await prefs.setString("password", password);

    await prefs.setString("firstName", firstName);

    await prefs.setString("lastName", lastName);

    await prefs.setString("phone", phone);

    await prefs.setString("email", email);
  }

  Future<void> clearlogin() async {
    username = "";
    password = "";

    await prefs.setString("username", "");
    await prefs.setString("password", "");
  }
}