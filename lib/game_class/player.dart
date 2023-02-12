import 'package:escape_game/game_class/global_object.dart';

import 'room.dart';
import 'furnitures.dart';
import 'item.dart';

class Player {
  List<GlobalObject> location; // contains room and furnitures
  late Inventory inventory;

  Player(String description, this.location, this.inventory);

  String take(Item item) {
    if (item.isTeakeable) {
      inventory.items.add(item);
      return "Vous avez récupéré " + item.name + ".";
    }
    return "Je ne peux pas faire ça.";
  }
}

class Inventory extends GlobalObject {
  List<Item> items = [];

  Inventory(String name, this.items) : super(0, name, "");

  @override
  String watch() {
    if (items.isEmpty) return "Votre inventaire est vide.";
    String str = "Votre inventaire contient ";
    for (var i = 0; i < items.length - 1; i++) {
      str += items[i].name;
      if (i != items.length - 2) str += ", ";
    }
    str += " et " + items[items.length - 1].name + ".";
    return str;
  }
}
