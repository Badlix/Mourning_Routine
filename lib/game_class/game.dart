import 'door.dart';
import 'furnitures.dart';
import 'global_object.dart';
import 'input.dart';
import 'item.dart';
import 'lock_system.dart';
import 'player.dart';
import 'room.dart';

String manageInput(Player player, String text, List<Room> rooms) {
  if (text == "reculer" || text == "sortir") return player.stepBack();
  if (text == "regarder autour") return player.whereAmI() + " " + player.location.last.watch();
  if (text == "regarder inventaire") return player.inventory.watch();
  if (text == "regarder moi") return player.description;
  if (text == "ls" || text == "taper ls") return player.location.last.ls();

  List<String> cmd = parseInput(text);
  if (cmd[0].isEmpty && cmd[1].isEmpty) return "Je n'ai pas compris.";
  if (cmd[0] == "essayer") return cmdTry(player, cmd[1]);

  Map<String, GlobalObject> mapObject = player.accessibleObject();

  if (mapObject.containsKey(cmd[1]) == false) return "Je n'ai pas cet objet à disposition.";

  GlobalObject objectToInteract = mapObject[cmd[1]]!;

  if (text == "page suivante" || text == "lire page suivante") return objectToInteract.nextPage();
  if (text == "page précedente" || text == "lire page précedente") return objectToInteract.previousPage();
  if (cmd[0] == "regarder") return objectToInteract.watch();
  if (cmd[0] == "inspecter") return cmdCheck(player, objectToInteract);
  if (cmd[0] == "deverouiller") return cmdUnlock(player, objectToInteract);
  if (cmd[0] == "lire") return objectToInteract.read();
  if (cmd[0] == "ouvrir") return cmdOpen(player, objectToInteract, rooms);
  if (cmd[0] == "prendre") return cmdTake(player, objectToInteract);
  if (cmd[0] == "utiliser") return cmdUse(player, objectToInteract);
  if (cmd[0] == "desceller") return objectToInteract.unSeal();
  if (cmd[0] == "poser") return cmdPut(player, objectToInteract);
  if (cmd[0] == "ajouter") return cmdAdd(player, objectToInteract);
  if (cmd[0] == "couper") return cmdCut(player, objectToInteract);
  if (cmd[0] == "éplucher") return cmdCut(player, objectToInteract);
  if (cmd[0] == "écailler") return cmdCut(player, objectToInteract);
  if (cmd[0] == "tourner") return objectToInteract.turn();
  if (cmd[0] == "allumer") return objectToInteract.switchOn();
  if (cmd[0] == "éteindre") return objectToInteract.switchOff();
  if (cmd[0] == "cat") return player.location.last.cat(cmd[1]);
  //if (cmd[0] == "lancer") return cmdThrow(player, objectToInteract);
  return "Je ne peux pas faire ça";
}

// ------------ Complicated action function -----------------//

String cmdTry(Player player, String code) {
  if (player.location.last is Padlock) {
    String txt = player.location.last.tryToUnlockLock(code);
    if (txt.contains("Vous avez déverouillé")) {
      player.stepBack();
    }
    return txt;
  }
  return "Je ne peux pas faire ça.";
}

String cmdUnlock(Player player, GlobalObject objectToInteract) {
  if (objectToInteract is Padlock) {
    return player.check(objectToInteract) + "\nVous devriez essayer d'entré une combinaison.";
  }
  if (objectToInteract is KeyHole) {
    return player.check(objectToInteract) + "\nVous devriez utiliser une clé.";
  }
  return "Je ne peux pas faire ça.";
}

String cmdOpen(Player player, GlobalObject objectToInteract, List<Room> rooms) {
  if (objectToInteract is Furniture || objectToInteract is Drawer) {
    String txt = objectToInteract.open();
    if (txt.contains("Vous ouvrez")) {
      if (objectToInteract is Furniture) {
        player.check(objectToInteract.drawers.first);
      } else {
        player.check(objectToInteract);
      }
    }
  }
  if (objectToInteract is Door) {
    String txt = objectToInteract.open();
    if (txt.contains("Vous ouvrez")) {
      String newRoom = objectToInteract.otherRoom(player.location.first.name);
      print(newRoom);
      player.location.clear();
      for (Room room in rooms) {
        if (room.name == newRoom) player.location.add(room);
      }
      return txt + "Vous voici dans *$newRoom*.";
    }
  }
  return objectToInteract.open();
}

String cmdTake(Player player, GlobalObject objectToInteract) {
  if (objectToInteract is Item) {
    return player.take(objectToInteract);
  }
  return "Je ne peux pas prendre cet objet";
}

String cmdUse(Player player, GlobalObject objectToInteract) {
  String txt = player.location.last.tryToUnlockLock(objectToInteract);
  if (txt.contains("Vous avez ")) {
    player.stepBack();
  }
  return txt;
}

String cmdPut(Player player, GlobalObject objectToInteract) {
  if (objectToInteract is Item) return player.put(objectToInteract);
  return "Vous n'avez pas de raison de poser cet objet.";
}

String cmdAdd(Player player, GlobalObject objectToInteract) {
  if (player.inventory.items.contains(objectToInteract) == false) return "Vous ne possédez pas cet objet.";
  if (objectToInteract is Food && player.location.last is CookingPlate) {
    for (Item item in player.location.last.getAllItems()) {
      if (item is Marmite) {
        player.inventory.removeObject(objectToInteract);
        return item.addFood(objectToInteract);
      }
    }
  }
  return "Vous ne pouvez pas faire ça.";
}

String cmdUnseal(Player player, GlobalObject objectToInteract) {
  player.take(Lighter("briquet", "Un simple *briquet* de couleur bleu. Il semble en bon état."));
  return objectToInteract.unSeal();
}

String cmdCut(Player player, GlobalObject objectToInteract) {
  for (Item item in player.inventory.items) {
    if (item.name == "couteau de poche") {
      if (objectToInteract is Food) return objectToInteract.cut();
      return "Je ne peux pas couper cet objet.";
    }
  }
  return "Je n'ai rien pour couper.";
}

String cmdPeel(Player player, GlobalObject objectToInteract) {
  for (Item item in player.inventory.items) {
    if (item.name == "couteau de poche") {
      if (objectToInteract is Food) return objectToInteract.cut();
      return "Je ne peux pas éplucher cet objet.";
    }
  }
  return "Je n'ai rien pour éplucher.";
}

String cmdScale(Player player, GlobalObject objectToInteract) {
  for (Item item in player.inventory.items) {
    if (item.name == "couteau de poche") {
      if (objectToInteract is Food) return objectToInteract.cut();
      return "Je ne peux pas écailler cet objet.";
    }
  }
  return "Je n'ai rien pour écailler.";
}

String cmdCheck(Player player, GlobalObject objectToInteract) {
  if (objectToInteract is Door || objectToInteract is Furniture || objectToInteract is Drawer) {
    return player.check(objectToInteract) + " " + objectToInteract.check() + " " + objectToInteract.checkLocks();
  }
  if (objectToInteract is Padlock) {
    return player.check(objectToInteract) + "\nVous devriez essayer d'entré une combinaison.";
  }
  if (objectToInteract is KeyHole) {
    return player.check(objectToInteract) + "\nVous devriez utiliser une clé.";
  }
  return player.check(objectToInteract) + " " + objectToInteract.check();
}
