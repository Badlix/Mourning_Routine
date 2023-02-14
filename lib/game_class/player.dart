import 'package:escape_game/game_class/input.dart';
import 'package:escape_game/game_class/lock_system.dart';
import 'package:flutter_html/shims/dart_ui.dart';

import 'global_object.dart';
import 'door.dart';
import 'room.dart';
import 'furnitures.dart';
import 'item.dart';

class Player {
  List<GlobalObject> location; // contains room and furnitures
  late Inventory inventory;

  Player(String description, this.location, this.inventory);

  GlobalObject getPOV() {
    return location.last;
  }

  String take(Item item) {
    if (item.isTakeable) {
      inventory.items.add(item);
      location.last.removeObject(item);
      return "Vous avez récupéré " + item.name + ".";
    }
    return "Je ne peux pas faire ça.";
  }

  String check(GlobalObject globalObject) {
    if ((globalObject is Item == false) && globalObject != location.last) {
      location.add(globalObject);
      return "Vous inspectez " + globalObject.name + ".";
    }
    return globalObject.description;
  }

  String stepBack() {
    if (location.length <= 1) return "Je ne peux pas faire ça.";
    String tmp = location[location.length - 1].name;
    if (location.last is Drawer && location[location.length - 2].getAllDrawers().length == 1) {
      location.removeLast();
    }
    location.removeLast();
    return "Vous reculer. Vous regarder maintenant " + location.last.name + ".";
  }

  String whereAmI() {
    return "Vous regardez " + location.last.name + ".";
  }

  Map<String, GlobalObject> accessibleObject() {
    Map<String, GlobalObject> objects = {};
    for (Item item in inventory.items) {
      objects[item.name] = item;
    }
    Map<String, GlobalObject> tmp = location.last.getAccessibleObject();
    objects[location.last.name] = location.last;
    return {}
      ..addAll(objects)
      ..addAll(tmp);
  }
}

class Inventory extends GlobalObject {
  List<Item> items = [];

  Inventory(String name, this.items) : super(name, "");

  @override
  String watch() {
    if (items.isEmpty) return "Votre inventaire est vide.";
    String str = "Votre inventaire contient ";
    // for (var i = 0; i < items.length; i++) {
    //   str += items[i].name;
    //   if (i <= items.length - 3 && items.length >= 3) str += ", ";
    //   if (i == items.length - 2) str += " et ";
    // }
    // str += ".";
    return str + parseListOfElement(items);
  }
}
