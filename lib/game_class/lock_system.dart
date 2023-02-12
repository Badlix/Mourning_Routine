import 'global_object.dart';

class LockSystem extends GlobalObject {
  bool isLocked = true;
  List<Lock> locks = [];

  LockSystem(int id, String name, String description, this.locks) : super(id, name, description);

  bool get getIsLocked {
    return isLocked;
  }

  bool checkIfStillLocked() {
    for (Lock lock in locks) {
      if (lock.isLocked == true) {
        return true;
      }
    }
    return false;
  }

  String tryToUnlock(var combi) {
    if (combi is int) {
      // substitut pour clé
      for (Lock lock in locks) {
        if (lock.tryToUnlockLock(combi)) return "Vous avez déverouillez " + lock.name;
      }
      return "Aucune serrure ne correspond à cette clée.";
    }
    // Regarder le pov du joueur
    // if (locks[lockNumber] is Padlock) {
    //   if (locks[0].tryToUnlockLock(combi)) {
    //     return ("Vous avez déverouillez " + locks[lockNumber].name);
    //   }
    //   return "Mauvaise Combinaison.";
    // } else if (locks[lockNumber] is KeyHole) {
    //   if (locks[lockNumber].tryToUnlockLock(combi)) {
    //     return "Vous avez déverouillez " + locks[lockNumber].name;
    //   }
    //   return "Mauvaise clée.";
    // }
    return "jsp";
  }
}

// ----------- LOCK ---------- //

class Lock extends GlobalObject {
  bool isLocked = true;

  Lock(int id, String name, String description) : super(id, name, description);

  bool tryToUnlockLock(var combi) {
    return true;
  }
}

// ----------- PADLOCK ---------- //

class Padlock extends Lock {
  String code = "";

  Padlock(int id, String name, String description, this.code) : super(id, name, description);

  @override
  bool tryToUnlockLock(var combi) {
    if (combi == code) {
      isLocked = false;
      return true;
    }
    return false;
  }
}

// ----------- KEYHOLE ---------- //

class KeyHole extends Lock {
  int key = 3;

  KeyHole(int id, String name, String description, this.key) : super(id, name, description);

  @override
  bool tryToUnlockLock(var combi) {
    if (key == combi) {
      isLocked = false;
      return true;
    }
    return false;
  }
}
