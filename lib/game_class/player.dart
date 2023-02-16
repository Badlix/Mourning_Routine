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
      return "J'ai *" + item.name + "*.";
    }
    return "Je ne peux pas faire ça.";
  }

  String put(Item item) {
    if (inventory.items.contains(item) == false) return "Je ne possède pas cet objet.";
    if (item.name == "marmite") {
      if (location.last.name == "plaque de cuisson") {
        inventory.removeObject(item);
        return location.last.addObject(item);
      }
      return "je ne peux pas poser cet objet ici.";
    }
    return "Je ne devrais pas mettre cet objet là.";
  }

  String check(GlobalObject globalObject) {
    if ((globalObject is Item == false) && globalObject != location.last) {
      location.add(globalObject);
      return "J'inspecte *" + globalObject.name + "*.";
    }
    return "J'inspecte *" + globalObject.name + "*.";
  }

  String stepBack() {
    if (location.length <= 1) return "Je ne peux pas faire ça.";
    String tmp = location[location.length - 1].name;
    if (location.last is Drawer && location[location.length - 2].getAllDrawers().length == 1) {
      location.removeLast();
    }
    location.removeLast();
    return "Je recule. \nMe voilà de retour à *" + location.last.name + "*.";
  }

  String whereAmI() {
    return "Je regarde *" + location.last.name + "*.";
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
    if (items.isEmpty) return "Mon *inventaire* est vide.";
    return "Mon *inventaire* contient " + parseListOfElement(items);
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
