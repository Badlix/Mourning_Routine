import 'package:escape_game/game_class/door.dart';
import 'package:escape_game/game_class/furnitures.dart';
import 'item.dart';

class GlobalObject {
  String name = "";
  String description = "";
  List<String> actions = ["regarder"];

  GlobalObject(this.name, this.description);

  String get getName {
    return name;
  }

  String get getDescription {
    return description;
  }

  List<String> get getActions {
    return actions;
  }

  String watch() {
    return description;
  }

  String check() {
    return description;
  }

  String open() {
    return "Je ne peux pas faire ça.";
  }

  String read() {
    return "Je ne peux pas faire ça.";
  }

  String use() {
    return "Je ne peux pas faire ça.";
  }

  List<Item> getAllItems() {
    return [];
  }

  List<Furniture> getAllFurnitures() {
    return [];
  }

  List<Door> getAllDoors() {
    return [];
  }

  List<Drawer> getAllDrawers() {
    return [];
  }

  String checkLocks() {
    return "";
  }

  Map<String, GlobalObject> getAccessibleObject() {
    return {};
  }

  String tryToUnlockLock(var combi) {
    return "Je ne peux pas faire ça.";
  }

  void removeObject(GlobalObject object) {}
}
