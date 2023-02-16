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

// ---------------------------- PLAYER 1 ----------------------------------- //

Player intiPlayer1(List<Room> rooms) {
  // --- locks --- //
  Vegetation vegetation = Vegetation("végétation", "Un amas de végétation impressionnant.");
  // --- lock system --- //
  LockSystem noLock = LockSystem("", "", []);
  LockSystem vegetationLock = LockSystem("", "", [vegetation]);
  // --- objects --- //
  Food kiwi = Food("kiwi", "C'est un kiwi.");
  Food lamproie = Food("lamproie", "C'est une lamproie.");
  Food poireau = Food("poireau", "C'est un poireau.");
  Food fenouil = Food("fenouil", "C'est du fenouil.");
  Food tomate = Food("tomate", "C'est une tomate.");
  // livre pour le rubik's cube
  Paper premierCouvertureLivreCuisine = Paper("premiere de couverture",
      "La première de couverture du livre. Le titre est 'Le Bouillon de A à Z'.", false, "Le Bouillon de A à Z.");
  Paper quatriemeCouvertureLivreCuisine =
      Paper("quatrieme de couverture", "La quatrieme de couverture du livre.", false, "");
  Paper recipe1 = Paper("recette de 80U1LL0N 54V0UR3UX", "La recette du bouillon binaire", false,
      "Recette 80U1LL0N 54V0UR3UX\n1-Remplire marmite\n2-ecailler lamproie+ajouter\n3-fenouil couper+ajouter\n4-kiwi eplucher+ajouter");
  Paper recipe3 = Paper(
      "page étrange",
      "Une page contenant des instructions étranges. Ce n'est surement pas une recette de cuisine.",
      true,
      "Commande Linux Pour Les Débutant\nPour entrer une commande Linux. Vous devez en premier lieux ouvrir un terminal. Vous pourrez taper dans celui ci la commande souhaitée.\nls : permet de voir le contenur d'un dossier\ncat : permet de voir le contenue d'une fichier.");
  // faire d'autres recettes
  //Lighter briquet = Lighter("briquet", "Un simple briquer de couleur bleu. Il semble en bon état.");
  Paper brouillon = Paper("brouillon", "Un papier vieilli a peine lisible. Certain bouts sont manquants.", true, "");
  SealPaper lettre = SealPaper("lettre", "lettre scellée",
      "Une lettre étrange dont le contenu porte sur des recherches.", "Une lettre fermée par un sceau.", true, "");
  Marmite marmite = Marmite("marmite", "Une grande marmite en acier inoxydable. Elle semble propre et en bon état.");
  Item pieceMonnaie1 = Item("piece triste", "Une pièce comportant un dessin représentant un personnage triste.", true);
  Item pieceMonnaie2 = Item("piece heureux", "Une pièce comportant un dessin représentant un personage heureux.", true);
  Item pieceMonnaie3 = Item("piece neutre", "Une pièce comportant un dessin représentant un personnage neutre.", true);
  Item pieceMonnaie4 =
      Item("piece colérique", "Une pièce comportant un dessin représentant un personnage colèrique.", true);
  GlobalObject poubelle =
      GlobalObject("poubelle", "Une odeur nauséabonde se dégage de la poubelle. Mieux vaut ne pas fouiller dedans.");
  // --- furniture --- //
  Drawer armoire1a = Drawer(
      "vieille armoire",
      "Une armoire semblant être sur le point de s'effondrer, il vaudrait mieux ne pas trop y toucher.",
      [lettre],
      false,
      noLock);
  Furniture armoire1b = Furniture(
      "vieille armoire",
      "Une armoire semblant être sur le point de s'effondrer, il vaudrait mieux ne pas trop y toucher.",
      [armoire1a],
      [],
      false,
      noLock);
  Drawer placard1a =
      Drawer("placard en bois de chêne", "C'est un joli placard en bois de chêne.", [marmite], false, noLock);
  Furniture placard1b =
      Furniture("placard en bois de chêne", "C'est un joli placard en bois de chêne.", [placard1a], [], false, noLock);
  Drawer drawerFrigo =
      Drawer("frigo", "Un frigo en bon état.", [kiwi, lamproie, poireau, fenouil, tomate], false, noLock);
  Furniture frigo = Furniture("frigo", "Un frigo en bon état.", [drawerFrigo], [], false, noLock);
  // --- door --- //
  Door porteMoussue = Door("porte moussue", "Une porte de forme circulaire couverte de végétation.",
      "laboratoire négligé", "cuisine", true, vegetationLock);
  // --- room --- //
  Room labo_dela = Room("laboratoire abandonné", "C'est un vieux laboratoire.", [armoire1b], [], [porteMoussue], true);
  // --- player --- //
  Inventory inventaire = Inventory("inventaire", []);
  rooms.add(labo_dela);
  return Player("C'est vous", [labo_dela], inventaire);
}

// ---------------------------- PLAYER 2 ----------------------------------- //

Player initPlayer2(List<Room> rooms) {
  // --- locks --- //
  Padlock cadenaSortie = Padlock("cadenas", "Un cadenas à code à trois chiffres.", "367");
  Padlock cadenaLabo = Padlock("cadena du laboratoire",
      "Un cadena à code contenant quatre smiley représentant différentes émotions.", "triste heureux neutre colerique");
  Padlock cadenaTiroirLabo = Padlock("cadenas", "un cadenas à code à 4 chiffres.", "6734");
  // --- lock system --- //
  LockSystem noLock = LockSystem("", "", []);
  LockSystem lockSortie = LockSystem("", "", [cadenaSortie]);
  LockSystem lockLabo = LockSystem("", "", [cadenaLabo]);
  LockSystem lockTiroirLabo = LockSystem("", "", [cadenaTiroirLabo]);
  // --- objects --- //
  FileC Salou = FileC("Salou.txt", "Un fichier nommé 'Salou.txt'.", "67 72 73 78 69");
  FileC Coronas = FileC("Coronas.txt", "Un fichier nommé 'Coronas.txt'.",
      "Shannon (en irlandais : Sionainn) est une ville du comté de Clare en Irlande. C’est l’une des deux villes nouvelles d’Irlande1 – l’autre étant Craigavon en Irlande du Nord. Shannon est à vingt kilomètres à l'ouest de Limerick.\nLa ville se trouve au fond de l'estuaire et tient son nom du fleuve qui coule à proximité (l'estuaire s'étend sur 102 km, de Killaloe à Loop Head). Elle a acquis le statut de ville le 1er janvier 1982.");
  FileC Nevot = FileC("Nevot.txt", "Un fichier nommé 'Nevot.txt'.", "...");
  FileC Makssoud = FileC("Makssoud.txt", "Un fichier nommé 'Makssoud.txt'.",
      "L’information financière constitue la mémoire de l’entreprise, parce que les comptes annuels doivent être conservés. De plus elle permet aux dirigeants de prendre des décisions :-    Opérationnelles : prises par les exécutants et donc on est à court terme (moins de 2 ans)-    Tactiques : prises par les encadrements supérieurs, moyen terme (2-5 ans)-    Stratégiques : prises par le plus haut niveau hiérarchique qui engage l’entreprise sur une large période (+ de 5 ans)Finalités externes :-    Sur le plan juridique de servir de preuves, dans le cadre des échanges marchands entre l’organisation et ses partenaires.-    Sur le plan fiscal de déterminer les impôts dû par l’entreprise à l’état-    Sur le plan de communication, d’alimenter des bases d’informations publiques afin de renseigner des tiers sur la situation de l’entreprise");
  Paper postIt = Paper("post-it", "Un post-it avec des inscriptions étranges dessus.", false, "U R L");
  Item flechette =
      Item("fléchette", "Une fléchette appartenant surement au jeu de fléchette présent dans la pièce.", true);
  Item rubiksCube = Item("rubik's cube", "Un Rubik’s cube peu commun car des chiffres y sont inscrits.", false);
  Paper brouillon2 = Paper("brouillon", "Un papier vieilli à peine lisible. Certains bouts sont manquants.", true,
      "Texte du brouillon : \nDébut de la construction : Décembre 2002\nFin de la construction : Septembre 2003\nTests réalisés : 134\nNombre de pièces : 12\nSorties de secours : Aucune\nTesteurs sortis indemnes : 4\nTesteurs sortis seuls : 10\nTaux de réussite : 10,44%\nDéfi : Réduire le taux de réussite à 1%.");
  Paper feuilleRubik = Paper("instructions étranges", "Une feuille comprenant des instructions étranges.", false,
      " R -> tourner la face de droite dans le sens des aiguilles d'une montre.\nR' -> tourner la face de droite dans le sens inverse des aiguilles d'une montre.\nL -> tourner la face de gauche dans le sens des aiguilles d'une montre.\nL' -> tourner la face de gauche dans le sens inverse des aiguilles d'une montre.\nD -> tourner la face du bas dans le sens des aiguilles d'une montre.\nD' -> tourner la face du bas dans le sens inverse des aiguilles d'une montre.\nF -> tourner la face de devant dans le sens des aiguilles d'une montre.\nF' -> tourner la face de devant dans le sens inverse des aiguilles d'une montre.\nU -> tourner la face de droite dans le sens inverse des aiguilles d'une montre.\nU' -> tourner la face de droite dans le sens inverse des aiguilles d'une montre.");
  // --- furniture --- //
  Computer ordi = Computer("ordinateur", "Un ordinateur, il est éteint.", "un ordinateur, il est allumé.",
      [Coronas, Makssoud, Nevot, Salou]);
  Drawer tiroir1 = Drawer("premier tiroir", "C'est un tiroir ordinaire.", [], false, noLock);
  Drawer tiroir2 = Drawer("deuxieme tiroir", "C'est un tiroir ordinaire.", [flechette], false, noLock);
  Drawer tiroir3 = Drawer("troisieme tiroir", "C'est un tiroir ordinaire.", [], false, noLock);
  Furniture casier = Furniture("casier", "Un casier ayant trois tiroirs pour y ranger de nombreuses affaires.",
      [tiroir1, tiroir2, tiroir3], [], false, noLock);
  Furniture etagere =
      Furniture("étagère murale", "C'est une étagère murale ordinaire.", [], [rubiksCube, postIt], false, noLock);
  Drawer tiroir1Labo = Drawer("tiroir1", "Un tiroir.", [], false, noLock);
  Drawer tiroir2Labo = Drawer("tiroir2", "Un tiroir.", [], true, lockTiroirLabo);
  Furniture carteMonde = Furniture("carte du monde", "Une grande carte du monde.", [], [], false, noLock);
  Furniture bureauMeuble = Furniture("bureau en bois",
      "Un bureau en bois. Il semble solide. Un ordinateur est posé dessus.", [], [ordi], false, noLock);
  // --- door --- //
  Door porteBureau =
      Door("porte du bureau", "Une porte permettant peut être de sortir ?", "bureau", "sortie", true, lockSortie);
  Door porteLabo = Door("porte du labo", "Une porte pertmettant surement de sortie du laboratoire.", "bureau",
      "laboratoire", true, lockLabo);
  // --- room --- //
  Room labo = Room("laboratoire", "C'est un laboratoire.", [], [], [], true);
  // --- player --- //
  rooms.add(labo);
  Inventory inventaire = Inventory("inventaire", []);
  return Player("C'est vous", [labo], inventaire);
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
  Vegetation liane = Vegetation("Vegetation", "Un amas de vegetation impressionant.");
  Door porte1 = Door("porte", "C'est une porte en bois", "cuisine", "salon", true, LockSystem("", "", [liane]));
  Drawer tiroir1 = Drawer("premier tiroir", "C'est un tiroir", [feuille2], false, LockSystem("", "", [cadena]));
  Drawer tiroir2 = Drawer("deuxieme tiroir", "C'est un tiroir", [cle], false, LockSystem("", "", []));
  Marmite marmite = Marmite("marmite", "yctiuiojpk");
  Food fruit = Food("fruit", "c fruit");
  FileC Salou = FileC("Salou.txt", "Un fichier nommé 'Salou.txt'.", "67 72 73 78 69");
  FileC Coronas = FileC("Coronas.txt", "Un fichier nommé 'Coronas.txt'.",
      "Shannon (en irlandais : Sionainn) est une ville du comté de Clare en Irlande. C’est l’une des deux villes nouvelles d’Irlande1 – l’autre étant Craigavon en Irlande du Nord. Shannon est à vingt kilomètres à l'ouest de Limerick.\nLa ville se trouve au fond de l'estuaire et tient son nom du fleuve qui coule à proximité (l'estuaire s'étend sur 102 km, de Killaloe à Loop Head). Elle a acquis le statut de ville le 1er janvier 1982.");
  FileC Nevot = FileC("Nevot.txt", "Un fichier nommé 'Nevot.txt'.", "...");
  FileC Makssoud = FileC("Makssoud.txt", "Un fichier nommé 'Makssoud.txt'.",
      "L’information financière constitue la mémoire de l’entreprise, parce que les comptes annuels doivent être conservés. De plus elle permet aux dirigeants de prendre des décisions :-    Opérationnelles : prises par les exécutants et donc on est à court terme (moins de 2 ans)-    Tactiques : prises par les encadrements supérieurs, moyen terme (2-5 ans)-    Stratégiques : prises par le plus haut niveau hiérarchique qui engage l’entreprise sur une large période (+ de 5 ans)Finalités externes :-    Sur le plan juridique de servir de preuves, dans le cadre des échanges marchands entre l’organisation et ses partenaires.-    Sur le plan fiscal de déterminer les impôts dû par l’entreprise à l’état-    Sur le plan de communication, d’alimenter des bases d’informations publiques afin de renseigner des tiers sur la situation de l’entreprise");

  Computer ordi = Computer("ordinateur", "Un ordinateur, il est éteint.", "un ordinateur, il est allumé.",
      [Coronas, Makssoud, Nevot, Salou]);
  Furniture meuble = Furniture("meuble", "c meuble", [], [ordi], false, LockSystem("", "", []));
  Room piece = Room("cuisine", "C'est une cuisine.", [meuble, ordi], [marmite], [porte1], true);
  Room piece2 = Room("salon", "C'est un salon.", [], [], [porte1], true);
  Lighter briquet = Lighter("Briquet", "briquet");
  SealPaper lettre =
      SealPaper("lettre", "lettre scellée", "une lettre", "une lettre scellée", true, "Je suis le texte.");
  Inventory inventaire = Inventory("inventaire", [marmite, fruit]);
  Player player = Player("C'est moi.", [piece], inventaire);
  List<Room> rooms = [piece, piece2];
  String? texte = " ";
  manageInput(player, "inspecter ordinateur", rooms);
  manageInput(player, "allumer ordinateur", rooms);
  while (texte != "") {
    texte = stdin.readLineSync();
    print(manageInput(player, texte.toString(), rooms));
  }
}
