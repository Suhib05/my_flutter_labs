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
  var _counter = 0.0;
 var myFontSize = 30.0;

  TextStyle _myFontStyle = const TextStyle (
    fontSize: 30,
    color: Colors.blue,
  );
  void _incrementCounter() {
    setState(() {

      if (_counter <=99.0) {
        _counter++;
      }
    });
  }

  void _setNewValue (double newValue){
    setState((){
      myFontSize = newValue;
      _myFontStyle = TextStyle(fontSize: myFontSize, color: Colors.blue );
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

        child: Column(

          mainAxisAlignment: .center,
          children: [
             Text('You have pushed the button this many times:', style: _myFontStyle),
            Text(
              '$_counter',
              style: _myFontStyle,
            ),
            const SizedBox (height : 24),
            Slider (min :10.0, max: 100.0,divisions: 50 , label: myFontSize.toStringAsFixed(1) ,value: myFontSize, onChanged: _setNewValue ),


          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
