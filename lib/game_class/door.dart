import 'global_object.dart';
import 'lock_system.dart';

// ----------- DOOR ---------- //

class Door extends GlobalObject {
  String room1;
  String room2;
  bool isLocked = true;
  LockSystem lockSystem;

  Door(String name, String description, this.room1, this.room2, this.isLocked, this.lockSystem)
      : super(name, description);

  bool get getIsLocked {
    return isLocked;
  }

  @override
  List<GlobalObject> getAllObject() {
    return lockSystem.locks;
  }

  @override
  String checkLocks() {
    String str = lockSystem.getLockedLocks();
    if (str.length < 2) return "";
    return ". Elle semble verouillée par " + str;
  }

  String otherRoom(String currentRoom) {
    if (room1 == currentRoom) return room2;
    return room1;
  }

  @override
  String open() {
    if (lockSystem.checkIfStillLocked()) {
      return "$name est vérouillée.";
    }
    isLocked = false;
    return "Vous ouvrez $name.";
  }

  @override
  Map<String, GlobalObject> accessibleObject() {
    Map<String, GlobalObject> accessibleObject = {};
    for (Lock lock in lockSystem.locks) {
      accessibleObject[lock.name] = lock;
    }
    return accessibleObject;
  }

  @override
  Map<String, GlobalObject> getAccessibleObject() {
    Map<String, GlobalObject> accessibleObject = {};
    for (Lock lock in lockSystem.locks) {
      accessibleObject[lock.name] = lock;
    }
    return accessibleObject;
  }
}
