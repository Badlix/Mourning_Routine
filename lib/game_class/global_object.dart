class GlobalObject {
  int id = 0;
  String name = "";
  String description = "";
  List<String> actions = ["regarder"];

  GlobalObject(this.id, this.name, this.description);

  int get getId {
    return id;
  }

  String get getName {
    return name;
  }

  String get getDescription {
    return description;
  }

  List<String> get getActions {
    return actions;
  }

  String watch() {
    return description;
  }

  String check() {
    return description;
  }

  String open() {
    return "Je ne peux pas faire ça";
  }

  String read() {
    return "Je ne peux pas faire ça";
  }
}