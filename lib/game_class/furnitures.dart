import "global_object.dart";
import "lock_system.dart";
import 'item.dart';

class Furniture extends GlobalObject {
  List<Furniture> drawers = [];
  List<Item> items = [];
  bool isLocked = false;
  late LockSystem lockSystem;

  Furniture(int id, String name, String description, this.drawers, this.items, this.isLocked, this.lockSystem)
      : super(id, name, description);

  bool get getIsLocked {
    return isLocked;
  }

  String unlock(var combi) {
    if (lockSystem.locks.isEmpty) return "Je ne peux pas faire ça";
    return lockSystem.tryToUnlock(combi);
  }

  @override
  String open() {
    if (drawers.isEmpty) return "Je ne peux pas faire ça";
    if (lockSystem.locks.isNotEmpty && lockSystem.checkIfStillLocked()) {
      return "$name est vérouillée.";
    }
    isLocked = false;
    return "Vous ouvrez $name.";
  }
}
