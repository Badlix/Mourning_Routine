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
import 'dart:io';

void rapidParse(Map<String, GlobalObject> map) {
  for (String key in map.keys) {
    print(key);
  }
}

main() {
  //Test Papier
  Paper feuille = Paper("feuille", "C'est une feuille", true, "Je suis le texte de la feuille");
  Watch montre = Watch("montre", "C'est une montre.");
  Paper feuille2 = Paper("vieille lettre", "C'est une vieille lettre", true, "Je suis un texte.");
  Padlock cadena = Padlock("cadena robuste", "C'est un cadena", "1234");
  KeyHole serrure = KeyHole("vieille serrure", "C'est une serrure", 3);
  Key cle = Key("cle", "C'est une cle.", 3);
  LockSystem sys = LockSystem("porte1", "C'est un systeme de sécurité", [cadena, serrure]);
  Door porte1 = Door("porte", "C'est une porte en bois", "cuisine", "salon", true, LockSystem("", "", []));
  Drawer tiroir1 = Drawer("premier tiroir", "C'est un tiroir", [feuille2], false, LockSystem("", "", [cadena]));
  Drawer tiroir2 = Drawer("deuxieme tiroir", "C'est un tiroir", [cle], false, LockSystem("", "", []));
  Furniture meuble =
      Furniture("meuble", "C'est un meuble", [tiroir1], [feuille, montre], false, LockSystem("", "", []));
  Room piece = Room("cuisine", "C'est une cuisine.", [meuble], [], [porte1], true, true);
  Room piece2 = Room("salon", "C'est un salon.", [], [], [porte1], true, true);
  Inventory inventaire = Inventory("inventaire", [montre, cle]);
  Player player = Player("C'est moi.", [piece], inventaire);
  List<Room> rooms = [piece, piece2];
  String? texte = " ";
  // manageInput(player, "inspecter porte");
  // manageInput(player, "inspecter vieille serrure");
  while (texte != "") {
    texte = stdin.readLineSync();
    print(manageInput(player, texte.toString(), rooms));
  }
}
