import 'door.dart';
import 'furnitures.dart';
import 'global_object.dart';
import 'input.dart';
import 'item.dart';
import 'lock_system.dart';
import 'player.dart';
import 'room.dart';

String manageInput(Player player, String text) {
  if (text == "reculer") return player.stepBack();
  if (text == "regarder autour") return player.whereAmI();
  if (text == "regarder inventaire") return player.inventory.watch();

  List<String> cmd = parseInput(text);
  if (cmd[0].isEmpty && cmd[1].isEmpty) return "Je n'ai pas compris.";
  if (cmd[0] == "essayer" && player.location.last is Padlock) {
    String txt = player.location.last.tryToUnlockLock(cmd[1]);
    if (txt.contains("Vous avez déverouillé")) {
      player.stepBack();
    }
    return player.location.last.tryToUnlockLock(cmd[1]);
  }
  Map<String, GlobalObject> mapObject = player.accessibleObject();

  if (mapObject.containsKey(cmd[1]) == false) return "Je n'ai pas cet objet à disposition.";
  GlobalObject objectToInteract = mapObject[cmd[1]]!;

  if (cmd[0] == "regarder") return objectToInteract.watch();
  if (cmd[0] == "inspecter") {
    if (objectToInteract is Door || objectToInteract is Furniture || objectToInteract is Drawer) {
      return player.check(objectToInteract) + "\n" + objectToInteract.checkLocks();
    }
    if (objectToInteract is Padlock) {
      return player.check(objectToInteract) + "\nVous devriez essayer d'entré une combinaison.";
    }
    if (objectToInteract is KeyHole) {
      return player.check(objectToInteract) + "\nVous devriez utiliser une clé";
    }
    return player.check(objectToInteract);
  }
  if (cmd[0] == "deverouiller") {
    if (objectToInteract is Padlock) {
      return player.check(objectToInteract) + "\nVous devriez essayer d'entré une combinaison.";
    }
    if (objectToInteract is KeyHole) {
      return player.check(objectToInteract) + "\nVous devriez utiliser une clé";
    }
  }
  if (cmd[0] == "lire") return objectToInteract.read();
  if (cmd[0] == "ouvrir") {
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
    return objectToInteract.open();
  }
  if (cmd[0] == "prendre" && objectToInteract is Item) return player.take(objectToInteract);

  return "Je ne peux pas faire ça";
}
