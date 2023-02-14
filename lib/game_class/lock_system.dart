import 'package:escape_game/game_class/input.dart';

import 'global_object.dart';
import 'item.dart';

class LockSystem extends GlobalObject {
  bool isLocked = true;
  List<Lock> locks = [];

  LockSystem(String name, String description, this.locks) : super(name, description);

  bool get getIsLocked {
    return isLocked;
  }

  String getLockedLocks() {
    List<Lock> lockedLock = [];
    for (Lock lock in locks) {
      if (lock.isLocked) lockedLock.add(lock);
    }
    return parseListOfElement(lockedLock);
  }

  bool checkIfStillLocked() {
    for (Lock lock in locks) {
      if (lock.isLocked == true) {
        return true;
      }
    }
    return false;
  }
}

// ----------- LOCK ---------- //

class Lock extends GlobalObject {
  bool isLocked = true;

  Lock(String name, String description) : super(name, description);

  String tryToUnlockLock(var combi) {
    return "";
  }
}

// ----------- PADLOCK ---------- //

class Padlock extends Lock {
  String code = "";

  Padlock(String name, String description, this.code) : super(name, description);

  @override
  String tryToUnlockLock(var combi) {
    if (combi == code) {
      isLocked = false;
      return "Vous avez déverouillé $name.";
    }
    return "Rien ne se passe, vous avez surement essayer la mauvaise combinaison.";
  }
}

// ----------- KEYHOLE ---------- //

class KeyHole extends Lock {
  int idKeyHole;

  KeyHole(String name, String description, this.idKeyHole) : super(name, description);

  @override
  String tryToUnlockLock(var combi) {
    print(combi);
    if (combi is Key && combi.idKeyHole == idKeyHole) {
      isLocked = false;
      return "Vous avez déverouillé $name.";
    }
    return "Vous essayer de déverouiller $name.La clé ne semble ne pas correspondre pas à cette porte";
  }
}
