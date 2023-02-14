import 'package:escape_game/game_class/game.dart';
import 'package:escape_game/game_class/lock_system.dart';
import 'package:escape_game/game_class/room.dart';
import 'global_object.dart';
import 'door.dart';
import 'lock_system.dart';
import 'item.dart';
import 'player.dart';
import 'furnitures.dart';
import 'input.dart';

void rapidParse(Map<String, GlobalObject> map) {
  for (String key in map.keys) {
    print(key);
  }
}

main() {
  //Test Papier
  Paper feuille = Paper(1, "feuille", "C'est une feuille", true, "Je suis le texte de la feuille");
  Watch montre = Watch(1, "montre", "C'est une montre.");
  Paper feuille2 = Paper(2, "vieille lettre", "C'est une vieille lettre", true, "Je suis un texte.");
  Padlock cadena = Padlock(2, "cadena robuste", "C'est un cadena", "1234");
  KeyHole serrure = KeyHole(3, "vieille serrure", "C'est une serrure");
  LockSystem sys = LockSystem(1, "porte1", "C'est un systeme de sécurité", [cadena, serrure]);
  Door porte1 = Door(3, "porte", "C'est une porte en bois", "salle1", "salle2", true, sys);
  Drawer tiroir1 = Drawer(2, "meuble", "C'est un tiroir", [feuille2], false, LockSystem(0, "", "", []));
  Furniture meuble =
      Furniture(1, "meuble", "C'est un meuble", [tiroir1], [feuille, montre], false, LockSystem(0, "", "", []));
  Room piece = Room(1, "cuisine", "C'est une cuisine", [meuble], [], [porte1], true, true);
  Inventory inventaire = Inventory("inventaire", [montre]);
  Player player = Player("C'est moi.", [piece], inventaire);

  // print(manageInput(perso, "ouvrir porte en bois"));
  // print(manageInput(perso, "deverouiller porte en bois"));
  // print(manageInput(perso, "inspecter porte en bois"));
  // print(manageInput(perso, "inspecter cadena robuste"));
  rapidParse(player.accessibleObject());
  print("---");
  print(manageInput(player, "inspecter porte"));
  print("---");
  print(manageInput(player, "regarder inventaire"));
  print("---");
  print(manageInput(player, "inspecter cadena robuste"));
  print("---");
  print(manageInput(player, "essayer 1235"));
  print("---");
  print(manageInput(player, "regarder autour"));
  print(manageInput(player, "essayer 1234"));
  print("----");
  print(manageInput(player, "ouvrir porte"));
  // print(perso.stepBack());
  // print(perso.whereAmI());
  // print(perso.accessibleObject());

  //print(manageInput(perso, "ouvrir meuble"));
  //print(manageInput(perso, "regarder autour"));
  //print(manageInput(perso, "reculer"));
  //print(manageInput(perso, "regarder autour"));
  //print(manageInput(perso, "regarder inventaire"));
}
