import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'repository.dart';

class ProfilePage extends StatefulWidget {
  final Repository repository;

  const ProfilePage(this.repository, {super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late TextEditingController firstController;
  late TextEditingController lastController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    firstController =
        TextEditingController(text: widget.repository.firstName);

    lastController =
        TextEditingController(text: widget.repository.lastName);

    phoneController =
        TextEditingController(text: widget.repository.phone);

    emailController =
        TextEditingController(text: widget.repository.email);

    firstController.addListener(saveData);
    lastController.addListener(saveData);
    phoneController.addListener(saveData);
    emailController.addListener(saveData);

    Future.delayed(Duration.zero, () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Welcome Back ${widget.repository.username}",
          ),
        ),
      );
    });
  }

  Future<void> saveData() async {
    widget.repository.firstName = firstController.text;
    widget.repository.lastName = lastController.text;
    widget.repository.phone = phoneController.text;
    widget.repository.email = emailController.text;

    await widget.repository.saveData();
  }

  Future<void> launchPhone() async {
    Uri uri = Uri.parse("tel:${phoneController.text}");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showError();
    }
  }

  Future<void> launchSMS() async {
    Uri uri = Uri.parse("sms:${phoneController.text}");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showError();
    }
  }

  Future<void> launchEmail() async {
    Uri uri = Uri.parse("mailto:${emailController.text}");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showError();
    }
  }

  void showError() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: const Text(
          "This URL is not supported on this device.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    firstController.dispose();
    lastController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor:
        Theme.of(context).colorScheme.inversePrimary,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            Text(
              "Welcome Back ${widget.repository.username}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: firstController,
              decoration: const InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: lastController,
              decoration: const InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Flexible(
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: launchPhone,
                  child: const Icon(Icons.phone),
                ),

                const SizedBox(width: 5),

                ElevatedButton(
                  onPressed: launchSMS,
                  child: const Icon(Icons.sms),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Flexible(
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: launchEmail,
                  child: const Icon(Icons.mail),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}