import 'package:escape_game/game_class/input.dart';

import "global_object.dart";
import "lock_system.dart";
import 'item.dart';
import 'player.dart';

class Furniture extends GlobalObject {
  List<Drawer> drawers = [];
  List<GlobalObject> items = [];
  bool isLocked = false;
  late LockSystem lockSystem;

  Furniture(String name, String description, this.drawers, this.items, this.isLocked, this.lockSystem)
      : super(name, description);

  @override
  List<Drawer> getAllDrawers() {
    return drawers;
  }

  @override
  String open() {
    if (drawers.isEmpty) return "Je ne peux pas faire ça";
    if (lockSystem.locks.isNotEmpty && lockSystem.checkIfStillLocked()) {
      return "Il semble que *$name* est vérouillée.";
    }
    isLocked = false;
    String str;
    if (drawers.length == 1) return drawers.first.open();
    return "Il y a " + drawers.length.toString() + ". Je dois choisir lequel ouvrir.";
  }

  @override
  String checkLocks() {
    String str = lockSystem.getLockedLocks();
    if (str.length < 2) return "";
    return "Cet objet semble verouillée par *" + str + "*.";
  }

  @override
  Map<String, GlobalObject> getAccessibleObject() {
    Map<String, GlobalObject> accessibleObject = {};
    for (GlobalObject item in items) {
      accessibleObject[item.name] = item;
    }
    for (Drawer drawer in drawers) {
      accessibleObject[drawer.name] = drawer;
    }
    for (Lock lock in lockSystem.locks) {
      accessibleObject[lock.name] = lock;
    }
    return accessibleObject;
  }

  @override
  String watch() {
    String txt = "";
    if (drawers.isEmpty == false && drawers.length != 1) {
      txt += " Il contient " + parseListOfElement(drawers);
    }
    if (items.isEmpty == false) {
      txt += " Dessus vous y voyez posé " + parseListOfElement(items);
    }
    return description + txt;
  }

  @override
  String check() {
    return watch();
  }

  @override
  String addObject(Item item) {
    items.add(item);
    return "Vous avez posé *" + item.name + "* sur *$name*.";
  }
}

class Drawer extends GlobalObject {
  List<GlobalObject> items = [];
  bool isLocked = false;
  late LockSystem lockSystem;

  Drawer(String name, String description, this.items, this.isLocked, this.lockSystem) : super(name, description);

  @override
  String open() {
    if (lockSystem.locks.isNotEmpty && lockSystem.checkIfStillLocked()) {
      return "Il semble que *$name* est vérouillée.";
    }
    isLocked = false;
    String str;
    if (items.isEmpty) {
      str = "Vous ne trouvait rien d'interessant.";
    } else {
      str = "Vous y trouvé ";
      str += parseListOfElement(items);
    }
    return "Vous ouvrez *$name*.\n" + str;
  }

  @override
  void removeObject(GlobalObject object) {
    for (GlobalObject item in items) {
      if (item == object) {
        items.remove(object);
        return;
      }
    }
  }

  @override
  String checkLocks() {
    String str = lockSystem.getLockedLocks();
    if (str.length < 2) return "";
    return "Ce Tiroir semble verouillée par " + str;
  }

  @override
  Map<String, GlobalObject> getAccessibleObject() {
    Map<String, GlobalObject> accessibleObject = {};
    for (GlobalObject item in items) {
      accessibleObject[item.name] = item;
    }
    for (Lock lock in lockSystem.locks) {
      accessibleObject[lock.name] = lock;
    }
    return accessibleObject;
  }
}

// --------- Cooking Plate -------- //

class CookingPlate extends Furniture {
  bool isOn = false;

  CookingPlate(String name, String description, List<Item> items)
      : super(name, description, [], items, false, LockSystem("", "", []));
}

// -------- Computer ----------- //

class FileC extends GlobalObject {
  String txt;

  FileC(String name, String description, this.txt) : super(name, description);

  @override
  String read() {
    return txt;
  }
}

class Computer extends Furniture {
  bool isOn = false;
  List<FileC> files = [];

  Computer(String name, String description, String descriptionOn, this.files)
      : super(name, description, [], [], false, LockSystem("", "", []));

  @override
  Map<String, GlobalObject> getAccessibleObject() {
    Map<String, GlobalObject> accessibleObject = {};
    for (FileC file in files) {
      accessibleObject[file.name] = file;
    }
    return accessibleObject;
  }

  @override
  String open() {
    return "Je ne peux pas faire ça.";
  }

  @override
  String switchOn() {
    if (isOn) return "L'*ordinateur* est déjà allumé.";
    isOn = true;
    return "L'*ordinateur* est allumé.";
  }

  @override
  String switchOff() {
    if (!isOn) return "L'*ordinateur* est déjà éteint.";
    isOn = false;
    return "L'*ordinateur* est éteint.";
  }

  @override
  String ls() {
    if (isOn == false) return "L'*ordinateur* est éteint.";
    String txt = "";
    for (int i = 1; i <= files.length; ++i) {
      txt += "*" + files[i - 1].name + "*      ";
      if (i % 2 == 0 && i != files.length) txt += '\n';
    }
    return txt;
  }

  @override
  String cat(String nameFile) {
    if (isOn == false) return "L'*ordinateur* est éteint.";
    for (FileC file in files) {
      if (file.name == nameFile) return file.read();
    }
    return "Ce fichier n'existe pas.";
  }
}
