import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String imageSource = "image/question-mark.png";
// here we use void cuz the function doesn't return a value
  void login() {
    // this line mean the string will strore text and gets the value from Password TextField
    String password = passwordController.text;
    print(password);
// setState to refresh the screen
    setState(() {
      if (password == "ASDF") {
        imageSource = "image/idea.png";
      } else {
        imageSource = "image/stop.png";
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
                // 10 mean add 10 px all = top , bottom, left, right (LTBR)
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  //InputDecoration makes textfeild perttier
                  decoration: const InputDecoration(
                    labelText: "Password",
                    // Draw a border (outline) around the TextField.
                    //OutlineInputBorder means draws the box around the field.
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                //Elevatedbutton to crate a button
                //child mean widget inside another widget like here the padding is the parent widget
                child: ElevatedButton(

                  onPressed: login,
                  child: const Text("Login"),
                ),
              ),

              Semantics(
                label: "Login result image",
                //Image.asset =  load image from project folder
                child: Image.asset(
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