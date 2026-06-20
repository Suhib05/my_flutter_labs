import 'package:flutter/material.dart';
import 'repository.dart';
import 'profile_page.dart';

class LoginPage extends StatefulWidget {
  final Repository repository;

  const LoginPage(this.repository, {super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String imageSource = "image/question-mark.png";

  @override
  void initState() {
    super.initState();

    loginController.text = widget.repository.username;
    passwordController.text = widget.repository.password;

    if (widget.repository.username.isNotEmpty &&
        widget.repository.password.isNotEmpty) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Previous login loaded"),
          ),
        );
      });
    }
  }

  Future<void> saveLogin() async {
    widget.repository.username = loginController.text;
    widget.repository.password = passwordController.text;

    await widget.repository.saveData();
  }

  Future<void> clearLogin() async {
    loginController.clear();
    passwordController.clear();

    await widget.repository.clearlogin();
  }

  void login() {
    if (passwordController.text == "ASDF") {
      setState(() {
        imageSource = "image/idea.png";
      });

      showSaveDialog();
    } else {
      setState(() {
        imageSource = "image/stop.png";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid password"),
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
    } else if (username.isNotEmpty) {
      message = "Would you like to save your username for next time?";
    } else if (password.isNotEmpty) {
      message = "Would you like to save your password for next time?";
    } else {
      message = "Nothing to save.";
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Save Login?"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () async {
                await saveLogin();

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Information saved"),
                  ),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfilePage(widget.repository),
                  ),
                );
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () async {
                await clearLogin();

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Saved information removed"),
                  ),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfilePage(widget.repository),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Week 5 Lab"),
        backgroundColor:
        Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: loginController,
                  decoration: const InputDecoration(
                    labelText: "Login Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: login,
                  child: const Text("Login"),
                ),
              ),
              Image.asset(
                imageSource,
                width: 300,
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}