import 'package:escape_game/game_class/input.dart';

import "global_object.dart";
import "lock_system.dart";
import 'item.dart';
import 'player.dart';

class Furniture extends GlobalObject {
  List<Drawer> drawers = [];
  List<Item> items = [];
  bool isLocked = false;
  late LockSystem lockSystem;

  Furniture(int id, String name, String description, this.drawers, this.items, this.isLocked, this.lockSystem)
      : super(id, name, description);

  // bool isDrawer() {
  //   return (drawers.isEmpty);
  // }

  // String unlock(var combi) {
  //   if (lockSystem.locks.isEmpty) return "Je ne peux pas faire ça";
  //   return lockSystem.tryToUnlock(combi);
  // }

  @override
  List<Item> getAllItems() {
    return items;
  }

  @override
  List<Drawer> getAllDrawers() {
    return drawers;
  }

  @override
  String open() {
    if (drawers.isEmpty) return "Je ne peux pas faire ça";
    if (lockSystem.locks.isNotEmpty && lockSystem.checkIfStillLocked()) {
      return "$name est vérouillée.";
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
    return "Cet objet semble verouillée par " + str;
  }

  @override
  Map<String, GlobalObject> getAccessibleObject() {
    Map<String, GlobalObject> accessibleObject = {};
    for (Item item in items) {
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
}

class Drawer extends GlobalObject {
  List<Item> items = [];
  bool isLocked = false;
  late LockSystem lockSystem;

  Drawer(int id, String name, String description, this.items, this.isLocked, this.lockSystem)
      : super(id, name, description);

  // String unlock(var combi) {
  //   if (lockSystem.locks.isEmpty) return "Je n'ai pas besoins de faire ça";
  //   return lockSystem.tryToUnlock(combi);
  // }

  @override
  List<Item> getAllItems() {
    return items;
  }

  @override
  String open() {
    if (lockSystem.locks.isNotEmpty && lockSystem.checkIfStillLocked()) {
      return "$name est vérouillée.";
    }
    isLocked = false;
    String str;
    if (items.isEmpty) {
      str = "Vous ne trouvait rien d'interessant.";
    } else {
      str = "Vous y trouvé ";
      str += parseListOfElement(items);
    }
    return "Vous ouvrez $name.\n" + str;
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
    for (Item item in items) {
      accessibleObject[item.name] = item;
    }
    for (Lock lock in lockSystem.locks) {
      accessibleObject[lock.name] = lock;
    }
    return accessibleObject;
  }
}
