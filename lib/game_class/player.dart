import 'package:escape_game/game_class/input.dart';
import 'package:escape_game/game_class/lock_system.dart';
import 'global_object.dart';
import 'door.dart';
import 'room.dart';
import 'furnitures.dart';
import 'item.dart';

class Player {
  List<GlobalObject> location; // contains room and furnitures
  late Inventory inventory;
  String description;

  Player(this.description, this.location, this.inventory);

  GlobalObject getPOV() {
    return location.last;
  }

  String take(Item item) {
    if (item.isTakeable) {
      inventory.items.add(item);
      if (location.last.name != "frigo") location.last.removeObject(item);
      return "Vous avez récupéré *" + item.name + "*.";
    }
    return "Je ne peux pas faire ça.";
  }

  String put(Item item) {
    if (inventory.items.contains(item) == false) return "Vous ne possedez pas cet item.";
    if (item.name == "marmite") {
      if (location.last.name == "plaque de cuisson") {
        inventory.removeObject(item);
        return location.last.addObject(item);
      }
      return "Vous ne pouvez pas poser cet objet ici.";
    }
    return "Vous n'avez pas de raison de poser cet objet.";
  }

  String check(GlobalObject globalObject) {
    if ((globalObject is Item == false) && globalObject != location.last) {
      location.add(globalObject);
      return "Vous inspectez *" + globalObject.name + "*.";
    }
    return "Vous inspectez *" + globalObject.name + "*.";
  }

  String stepBack() {
    if (location.length <= 1) return "Je ne peux pas faire ça.";
    String tmp = location[location.length - 1].name;
    if (location.last is Drawer && location[location.length - 2].getAllDrawers().length == 1) {
      location.removeLast();
    }
    location.removeLast();
    return "Vous reculez. \nVous regardez maintenant *" + location.last.name + "*.";
  }

  String whereAmI() {
    return "Vous regardez *" + location.last.name + "*.";
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
    if (items.isEmpty) return "Votre *inventaire* est vide.";
    return "Votre *inventaire* contient " + parseListOfElement(items);
  }

  @override
  void removeObject(GlobalObject object) {
    for (Item item in items) {
      if (item == object) {
        items.remove(object);
        return;
      }
    }
  }
}
