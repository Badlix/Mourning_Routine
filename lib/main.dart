import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter_html/flutter_html.dart' show Html;
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mourning Routine',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Mourning Routine'),
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
  List<String> images = ['<p>chargement</p>'];
  int ind = 0;

  Future loadImages() async {
    List<String> listImage = [];
    listImage.add(await rootBundle.loadString('assets/test1.txt'));
    listImage.add(await rootBundle.loadString('assets/test2.txt'));
    setState(() {
      images = listImage;
    });
  }

  void addCounter() {
    setState(() {
      ind += 1;
    });
  }

  @override
  void initState() {
    loadImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(60, 60, 60, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Image.asset("assets/test4.png")],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
