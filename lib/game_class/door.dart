import 'global_object.dart';
import 'lock_system.dart';

// ----------- DOOR ---------- //

class Door extends GlobalObject {
  String room1 = "";
  String room2 = "";
  bool isLocked = true;
  late LockSystem lockSystem;

  Door(int id, String name, String description, this.room1, this.room2, this.isLocked, this.lockSystem)
      : super(id, name, description);

  bool get getIsLocked {
    return isLocked;
  }

  String unlock(var combi) {
    return lockSystem.tryToUnlock(combi);
  }

  @override
  String open() {
    if (lockSystem.checkIfStillLocked()) {
      return "$name est vérouillée.";
    }
    isLocked = false;
    return "Vous ouvrer $name. Vous voici dans [une piece].";
  }
}
