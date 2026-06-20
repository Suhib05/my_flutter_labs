import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'repository.dart';
import 'login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Repository repository = Repository();
  await repository.loadData();

  runApp(MyApp(repository));
}

class MyApp extends StatelessWidget {
  final Repository repository;

  const MyApp(this.repository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Week 5 Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: LoginPage(repository),
    );
  }
}

