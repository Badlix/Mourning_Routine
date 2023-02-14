import 'package:escape_game/game_class/global_object.dart';

bool isInputValid(String text) {
  if (text.isEmpty) return false;
  if (text.contains(' ') == false || text.indexOf(' ') == 0) return false;
  if (text.indexOf(' ') == text.length - 1) return false;
  return true;
}

List<String> parseInput(String cmd) {
  List<String> words = ["", ""];
  if (isInputValid(cmd) == false) return words;
  String verbe = cmd.substring(0, cmd.indexOf(' '));
  String objet = cmd.substring(cmd.indexOf(' ') + 1, cmd.length);
  words[0] = verbe;
  words[1] = objet;
  return words;
}

String parseListOfElement(List<GlobalObject> words) {
  String str = "";
  for (var i = 0; i < words.length; i++) {
    str += words[i].name;
    if (i <= words.length - 3 && words.length >= 3) str += ", ";
    if (i == words.length - 2) str += " et ";
  }
  str += ".";
  return str;
}
