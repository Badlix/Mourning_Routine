import 'global_object.dart';
import 'player.dart';

// ---------- Item ---------- //

class Item extends GlobalObject {
  bool isTakeable;

  Item(String name, String description, this.isTakeable) : super(name, description);
}

// ---------- Paper ---------- //

class Paper extends Item {
  String text = "";

  Paper(String name, String description, bool isTeakeable, this.text) : super(name, description, isTeakeable);

  @override
  String read() {
    return text;
  }
}

// -------- Seal Letter--------- //
class SealPaper extends Paper {
  String unsealName;
  String unsealDescription;
  bool isSealed = true;

  SealPaper(this.unsealName, String name, this.unsealDescription, String description, bool isTeakeable, String text)
      : super(name, description, isTeakeable, text);

  @override
  String unSeal() {
    isSealed = false;
    name = unsealName;
    description = description;
    return "J'ai ouvert $name. Il y a $name à l'intérieur.";
  }

  @override
  String watch() {
    if (isSealed) return description;
    return super.watch();
  }

  @override
  String read() {
    if (isSealed) return "$name est  scellée. Je devrais essayer de la désceller d'abord.";
    return super.read();
  }
}

// ---------- Lighter ---------- //

class Lighter extends Item {
  List<String> whereToUse = ["Plaque de cuisson"];

  Lighter(String name, String description) : super(name, description, true);
}

// ---------- Watch ---------- //

class Watch extends Item {
  DateTime endGame = DateTime(0);

  Watch(String name, String description) : super(name, description, true);

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
    return "Il me reste " + lastingTime.inMinutes.toString() + " minutes.";
  }
}

// ---------- Key ----------- //

class Key extends Item {
  int idKeyHole;

  Key(String name, String description, this.idKeyHole) : super(name, description, true);
}

// ---------- Food ----------- //
class Food extends Item {
  bool isCut = false;
  bool isPeel = false;
  bool isScale = false;
  bool isCooked = false;

  Food(String name, String description) : super(name, description, true);

  @override
  String cut() {
    if (isCut) return "J'ai déjà coupé *$name*.";
    isCut = true;
    return "J'ai coupé *$name*.";
  }

  @override
  String peel() {
    if (isCut) return "J'ai déjà épluché *$name*.";
    isPeel = true;
    return "J'ai épluché *$name*.";
  }

  @override
  String scale() {
    if (isCut) return "J'ai déjà écaillé *$name*.";
    isScale = true;
    return "J'ai écaillé *$name*.";
  }
}

// ----------- Marmite ----------- //

class Marmite extends Item {
  Recipe recipe = Recipe();

  Marmite(String name, String description) : super(name, description, true);

  String addFood(Food food) {
    recipe.addFood(food);
    return "J'ajoute *" + food.name + "* à *$name*.";
  }
}

// ----------- Recipe ----------- //

class Recipe {
  List<Food> foods = [];

  Recipe();

  void addFood(Food food) {
    foods.add(food);
  }

  bool checkIfRecipeIsGood() {
    if (foods.length != 3) return false;
    for (Food food in foods) {
      if (food.name == "kiwi" && food.isPeel == true && food.isCut == true && food.isScale == false) continue;
      if (food.name == "lamproie" && food.isPeel == false && food.isCut == true && food.isScale == true) continue;
      if (food.name == "fenouil" && food.isPeel == false && food.isCut == true && food.isScale == false) continue;
      return false;
    }
    return true;
  }
}

// ------------ Book ------------ //

class Book extends Item {
  List<Paper> pages = [];
  int currentPage = 0;

  Book(String name, String description, this.pages) : super(name, description, true) {
    for (Paper page in pages) {
      pages.add(page);
    }
  }

  @override
  String read() {
    return pages[currentPage].read();
  }

  @override
  String open() {
    return read();
  }

  @override
  String nextPage() {
    if (currentPage == pages.length - 1) return "Je ne peux pas faire ça.";
    ++currentPage;
    return pages[currentPage].read();
  }

  @override
  String previousPage() {
    if (currentPage == 0) return "Je ne peux pas faire ça.";
    --currentPage;
    return pages[currentPage].read();
  }
}

// --------- Knife ------- //

class Knife extends Item {
  Knife(
    String name,
    String description,
  ) : super(name, description, true);
}

// --------- Rubik ------------ //

class Rubik extends Item {
  Rubik(String name, String description) : super(name, description, false);

  @override
  String turn() {
    return "Impossible de tourner les faces du *rubik’s cube*, il est trop vieux.";
  }
}

// ------------ Dart ---------- //

class Dart extends Item {
  Dart(String name, String description) : super(name, description, true);

  @override
  String throwDart(Player player) {
    if (player.location.last.name == "carte du monde") {
      return "ok";
    }
    return "Je ne devrais pas faire ça.";
  }
}
