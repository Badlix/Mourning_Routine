import 'package:escape_game/game_class/input.dart';

import 'global_object.dart';
import 'item.dart';

class LockSystem extends GlobalObject {
  bool isLocked = true;
  List<Lock> locks = [];

  LockSystem(int id, String name, String description, this.locks) : super(id, name, description);

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

  // String tryToUnlock(var combi) {
  //   if (combi is Key) {
  //     // substitut pour clé
  //     for (Lock lock in locks) {
  //       if (lock.tryToUnlockLock(combi)) return "Vous avez déverouillez " + lock.name;
  //     }
  //     return "Aucune serrure ne correspond à cette clée.";
  //   }
  //   // Regarder le pov du joueur
  //   // if (locks[lockNumber] is Padlock) {
  //   //   if (locks[0].tryToUnlockLock(combi)) {
  //   //     return ("Vous avez déverouillez " + locks[lockNumber].name);
  //   //   }
  //   //   return "Mauvaise Combinaison.";
  //   // } else if (locks[lockNumber] is KeyHole) {
  //   //   if (locks[lockNumber].tryToUnlockLock(combi)) {
  //   //     return "Vous avez déverouillez " + locks[lockNumber].name;
  //   //   }
  //   //   return "Mauvaise clée.";
  //   // }
  //   return "jsp";
  // }
}

// ----------- LOCK ---------- //

class Lock extends GlobalObject {
  bool isLocked = true;

  Lock(int id, String name, String description) : super(id, name, description);

  String tryToUnlockLock(var combi) {
    return "";
  }
}

// ----------- PADLOCK ---------- //

class Padlock extends Lock {
  String code = "";

  Padlock(int id, String name, String description, this.code) : super(id, name, description);

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
  KeyHole(int id, String name, String description) : super(id, name, description);

  @override
  String tryToUnlockLock(var combi) {
    if (combi is Key && combi.idKeyHole == id) {
      isLocked = false;
      return "Vous avez déverouillé $name.";
    }
    return "Vous essayer de déverouiller $name.La clé ne semble ne pas correspondre pas à cette porte";
  }
}
