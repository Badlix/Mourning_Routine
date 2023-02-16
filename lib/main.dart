import 'package:escape_game/game_class/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:io';
import 'package:escape_game/game_class/main.dart';
import 'game_class/room.dart';
import 'game_class/player.dart';
import 'dart:io';

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
      home: const MenuPage(title: 'Mourning Routine'),
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.title});
  final String title;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 300, child: Image.asset("assets/game_logo.png")),
              const Spacer(flex: 1),
              SizedBox(
                height: 60,
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GamePage(
                                  title: "Mourning Routine",
                                  whichPlayer: 1,
                                )),
                      );
                    },
                    child: const Text(
                      "First Player",
                      style: TextStyle(fontSize: 30),
                    )),
              ),
              const Spacer(flex: 1),
              SizedBox(
                height: 60,
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GamePage(
                                  title: "Mourning Routine",
                                  whichPlayer: 2,
                                )),
                      );
                    },
                    child: const Text(
                      "Second Player",
                      style: TextStyle(fontSize: 30),
                    )),
              ),
              const Spacer(flex: 8),
            ],
          ),
        ));
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.title, required this.whichPlayer});
  final String title;
  final int whichPlayer;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const TextStyle defaultStyle =
      TextStyle(fontSize: 45, color: Colors.white, fontFamily: 'VT323', letterSpacing: 3);
  static const TextStyle keyWordStyle = TextStyle(color: Colors.yellow);
  var focusNode = FocusNode();
  final myController = TextEditingController();
  String text = "";
  String cmd = "";
  late RichText dialog;
  List<Room> rooms = [];
  Room loading = Room("loading", "", [], [], [], false);
  late Player player = Player("", [loading], Inventory("", []));

  RichText styleText(String text) {
    List<TextSpan> textSpans = [];
    int i = 0;
    int indStartOfWord = 0;
    int indEndOfWord = 0;
    while (i < text.length) {
      indStartOfWord = text.indexOf("*", i);
      indEndOfWord = text.indexOf("*", indStartOfWord + 1);
      if (indStartOfWord != -1 && indStartOfWord < indEndOfWord) {
        textSpans.add(TextSpan(text: text.substring(i, indStartOfWord)));
        textSpans.add(TextSpan(text: text.substring(indStartOfWord + 1, indEndOfWord), style: keyWordStyle));
        i = indEndOfWord + 1;
      } else {
        break;
      }
    }
    //if (textSpans.isEmpty) textSpans.add(TextSpan(text: text));
    if (i < text.length) textSpans.add(TextSpan(text: text.substring(i)));
    return RichText(text: TextSpan(style: defaultStyle, children: textSpans));
  }

  Image setBackground() {
    const List<String> imageAvailible = ["laboratoire", "laboratoire abandonné"];

    if (imageAvailible.contains(player.location.last.name)) {
      return Image.asset("assets/${player.location.last.name}.png");
    }
    return Image.asset("assets/loading.gif");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.whichPlayer == 1) {
      player = intiPlayer1(rooms);
    } else {
      player = initPlayer2(rooms);
    }
    dialog = styleText("Bjr");
    focusNode.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: Center(
          child: SizedBox(
            width: 1500,
            height: 900,
            child: Center(
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    color: Colors.black,
                  ), //Container
                  // Background Image
                  Positioned(
                    top: 5,
                    left: 50,
                    child: SizedBox(
                        width: 1400,
                        height: 700,
                        child: FittedBox(child: setBackground()
                            //opacity: const AlwaysStoppedAnimation(.5),
                            )),
                  ), //Container
                  // Positioned(
                  //   top: 5,
                  //   left: 200,
                  //   child: SizedBox(
                  //     width: 1100,
                  //     height: 630,
                  //     child: FittedBox(child: Image.asset("assets/test.png")),
                  //   ),
                  // ), //Container
                  // Shell Border
                  Positioned(
                    left: 20,
                    top: 625,
                    child: Container(
                      height: 270,
                      width: 1460,
                      color: const Color.fromRGBO(255, 255, 255, 0.7),
                    ),
                  ),
                  // Shell
                  Positioned(
                    left: 25,
                    top: 630,
                    child: Container(
                      height: 260,
                      width: 1450,
                      color: Colors.black,
                    ),
                  ),
                  // Shell text
                  Positioned(
                      left: 50,
                      top: 640,
                      child: SizedBox(
                          height: 150,
                          width: 1400,
                          //color: Colors.red,
                          child: dialog)
                      // child: DefaultTextStyle(
                      //   style: defaultStyle,
                      //   child: AnimatedTextKit(animatedTexts: [
                      //     TyperAnimatedText("aaaaaaaaaaaaaaaaaaaaaaaa", speed: const Duration(milliseconds: 75)),
                      //     TyperAnimatedText("bbbbbbbbbbbbbbbbbbbbbbbb", speed: const Duration(milliseconds: 75)),
                      //   ]),
                      // )),
                      ),
                  // Shell signe '>'
                  const Positioned(
                    left: 40,
                    top: 810,
                    child: SizedBox(
                      height: 50,
                      width: 100,
                      //color: Colors.blue,
                      child: Text(
                        "> ",
                        style: defaultStyle,
                      ),
                    ),
                  ),
                  // Shell TextField
                  Positioned(
                    left: 80,
                    top: 825,
                    child: SizedBox(
                      height: 50,
                      width: 1200,
                      //color: Colors.green,
                      child: TextField(
                        controller: myController,
                        focusNode: focusNode,
                        decoration: const InputDecoration(border: InputBorder.none),
                        // ignore: prefer_const_constructors
                        style: defaultStyle,
                        maxLength: 30,
                        onSubmitted: (value) {
                          cmd = myController.text;
                          setState(() {
                            text = manageInput(player, cmd, rooms);
                            dialog = styleText(text);
                          });
                          myController.clear();
                          focusNode.requestFocus();
                          // get and parse data
                        },
                        onTapOutside: (event) {
                          focusNode.requestFocus();
                        },
                      ),
                    ),
                  ), //Container
                ], //<Widget>[]
              ), //Stack
            ), //Center
          ), //SizedBox
        ) //Center
        );
  }
}
