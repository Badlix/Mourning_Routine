import 'package:escape_game/game_class/door.dart';
import 'package:escape_game/game_class/furnitures.dart';
import 'player.dart';
import 'item.dart';

class GlobalObject {
  String name = "";
  String description = "";

  GlobalObject(this.name, this.description);

  String get getName {
    return name;
  }

  String get getDescription {
    return description;
  }

  String watch() {
    return description;
  }

  String check() {
    return watch();
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

  String unSeal() {
    return "Je ne peux pas faire ça.";
  }

  String addObject(Item item) {
    return "";
  }

  void removeObject(GlobalObject object) {}

  String cut() {
    return "Je ne peux pas faire ça.";
  }

  String peel() {
    return "Je ne peux pas faire ça.";
  }

  String scale() {
    return "Je ne peux pas faire ça.";
  }

  String nextPage() {
    return "Je ne peux pas faire ça.";
  }

  String previousPage() {
    return "Je ne peux pas faire ça.";
  }

  String turn() {
    return "Je ne peux pas faire ça.";
  }

  String throwDart(Player player) {
    return "Je ne peux pas faire ça.";
  }

  String ls() {
    return "Je ne peux pas faire ça.";
  }

  String cat(String nameFile) {
    return "Je ne peux pas faire ça.";
  }

  String switchOn() {
    return "Je ne peux pas faire ça.";
  }

  String switchOff() {
    return "Je ne peux pas faire ça.";
  }
}
