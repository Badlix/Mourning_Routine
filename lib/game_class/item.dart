import 'global_object.dart';

// ---------- Item ---------- //

class Item extends GlobalObject {
  bool isTakeable;

  Item(int id, String name, String description, this.isTakeable)
      : super(
          id,
          name,
          description,
        ) {
    if (isTakeable) actions.add("prendre");
  }
}

// ---------- Paper ---------- //

class Paper extends Item {
  String text = "";

  Paper(int id, String name, String description, bool isTeakeable, this.text)
      : super(id, name, description, isTeakeable) {
    actions.add("lire");
  }

  @override
  String read() {
    return text;
  }
}

// ---------- Lighter ---------- //

class Lighter extends Item {
  List<String> whereToUse = ["Plaque de cuisson"];

  Lighter(int id, String name, String description) : super(id, name, description, true) {
    actions.add("utiliser");
  }
}

// ---------- Watch ---------- //

class Watch extends Item {
  DateTime endGame = DateTime(0);

  Watch(int id, String name, String description) : super(id, name, description, true);

  void startWatch() {
    var today = DateTime.now();
    endGame = DateTime(
      today.year,
      today.month,
      today.day,
      today.hour + 1,
      today.minute,
      today.second,
    );
  }

  @override
  String watch() {
    if (endGame.year == 0) {
      String minute = DateTime.now().minute.toString();
      if (minute.length == 1) minute = "0" + minute;
      return "Il est " + DateTime.now().hour.toString() + "h$minute.";
    }
    Duration lastingTime = endGame.difference(DateTime.now());
    return "Il vous reste " + lastingTime.inMinutes.toString() + " minutes.";
  }
}

// ---------- Key ----------- //

class Key extends Item {
  int idKeyHole;

  Key(int id, String name, String description, this.idKeyHole) : super(id, name, description, true);
}
