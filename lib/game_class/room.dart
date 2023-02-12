import 'furnitures.dart';
import 'item.dart';
import 'door.dart';
import 'global_object.dart';

class Room extends GlobalObject {
  List<Furniture> furnitures = [];
  List<Item> items = [];
  List<Door> doors = [];
  bool firstVisit = true;
  bool areLightsOn = true;

  Room(int id, String name, String description, this.furnitures, this.items, this.doors, this.firstVisit,
      this.areLightsOn)
      : super(id, name, description);
}
