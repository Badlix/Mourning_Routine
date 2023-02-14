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

  @override
  List<Item> getAllItems() {
    return items;
  }

  @override
  List<Furniture> getAllFurnitures() {
    return furnitures;
  }

  @override
  List<Door> getAllDoors() {
    return doors;
  }

  @override
  Map<String, GlobalObject> getAccessibleObject() {
    Map<String, GlobalObject> accessibleObject = {};
    for (Furniture furniture in furnitures) {
      accessibleObject[furniture.name] = furniture;
    }
    for (Item item in items) {
      accessibleObject[item.name] = item;
    }
    for (Door door in doors) {
      accessibleObject[door.name] = door;
    }
    return accessibleObject;
  }
}
