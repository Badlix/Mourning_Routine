import 'global_object.dart';
import 'lock_system.dart';

// ----------- DOOR ---------- //

class Door extends GlobalObject {
  String room1 = "";
  String room2 = "";
  bool isLocked = true;
  LockSystem lockSystem;

  Door(int id, String name, String description, this.room1, this.room2, this.isLocked, this.lockSystem)
      : super(id, name, description);

  bool get getIsLocked {
    return isLocked;
  }

  // String unlock(var combi) {
  //   return lockSystem.tryToUnlock(combi);
  // }

  @override
  List<GlobalObject> getAllObject() {
    return lockSystem.locks;
  }

  @override
  String checkLocks() {
    String str = lockSystem.getLockedLocks();
    if (str.length < 2) return "";
    return "Elle semble verouillée par " + str;
  }

  @override
  String open() {
    if (lockSystem.checkIfStillLocked()) {
      return "$name est vérouillée.";
    }
    isLocked = false;
    return "Vous ouvrer $name. Vous voici dans [une piece].";
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
