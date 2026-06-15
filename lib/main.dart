import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Week 4 Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const MyHomePage(
        title: 'Week 4 Lab',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() =>
      _MyHomePageState();
}

class _MyHomePageState
    extends State<MyHomePage> {

  final TextEditingController
  loginController =
  TextEditingController();

  final TextEditingController
  passwordController =
  TextEditingController();

  final EncryptedSharedPreferences
  prefs =
  EncryptedSharedPreferences();

  String imageSource =
      "image/question-mark.png";

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  Future<void> loadSavedData() async {

    String? username =
    await prefs.getString(
        "username");

    String? password =
    await prefs.getString(
        "password");

    if (username != null &&
        password != null) {

      loginController.text =
          username;

      passwordController.text =
          password;

      Future.delayed(
        Duration.zero,
            () {

          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                "Previous login loaded",
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> saveLogin() async {

    await prefs.setString(
      "username",
      loginController.text,
    );

    await prefs.setString(
      "password",
      passwordController.text,
    );
  }

  Future<void> clearLogin() async {

    await prefs.remove(
        "username");

    await prefs.remove(
        "password");
  }

  void login() {

    String password =
        passwordController.text;

    if(password == "ASDF") {

      setState(() {
        imageSource = "image/idea.png";
      });

      showSaveDialog();

    } else {

      setState(() {
        imageSource = "image/stop.png";
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Invalid password",
          ),
        ),
      );
    }
  }

  void showSaveDialog() {

    String username = loginController.text.trim();
    String password = passwordController.text.trim();

    String message = "";

    if (username.isNotEmpty && password.isNotEmpty) {
      message =
      "Would you like to save your username and password for next time?";
    }
    else if (username.isNotEmpty) {
      message =
      "Would you like to save your username for next time?";
    }
    else if (password.isNotEmpty) {
      message =
      "Would you like to save your password for next time?";
    }
    else {
      message =
      "Nothing to save.";
    }

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(

          title: const Text(
            "Save Login?",
          ),

          content: Text(message),

          actions: [

            TextButton(

              onPressed: () async {

                await saveLogin();

                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Information saved",
                    ),
                  ),
                );
              },

              child: const Text("Yes"),
            ),

            TextButton(

              onPressed: () async {

                await clearLogin();

                loginController.clear();
                passwordController.clear();

                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Saved information removed",
                    ),
                  ),
                );
              },

              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor:
        Theme.of(context)
            .colorScheme
            .inversePrimary,

        title:
        Text(widget.title),
      ),

      body: Center(

        child:
        SingleChildScrollView(

          child: Column(

            children: [

              Padding(

                padding:
                const EdgeInsets.all(
                    10),

                child: TextField(

                  controller:
                  loginController,

                  decoration:
                  const InputDecoration(

                    labelText:
                    "Login Name",

                    border:
                    OutlineInputBorder(),
                  ),
                ),
              ),

              Padding(

                padding:
                const EdgeInsets.all(
                    10),

                child: TextField(

                  controller:
                  passwordController,

                  obscureText: true,

                  decoration:
                  const InputDecoration(

                    labelText:
                    "Password",

                    border:
                    OutlineInputBorder(),
                  ),
                ),
              ),

              Padding(

                padding:
                const EdgeInsets.all(
                    10),

                child:
                ElevatedButton(

                  onPressed: login,

                  child:
                  const Text(
                    "Login",
                  ),
                ),
              ),

              Semantics(

                label:
                "Login result image",

                child:
                Image.asset(

                  imageSource,

                  width: 300,

                  height: 300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}