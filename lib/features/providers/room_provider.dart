import 'package:flutter/foundation.dart';

import 'package:life_sync/common/models/room_model.dart';

class RoomProvider with ChangeNotifier {
  List<RoomModel> _rooms = [
    RoomModel(id: '1', name: 'Living Room', icon: 'living_room'),
    RoomModel(id: '2', name: 'Bedroom', icon: 'bedroom'),
    RoomModel(id: '3', name: 'Kitchen', icon: 'kitchen'),
    RoomModel(id: '4', name: 'Bathroom', icon: 'bathroom'),
  ];

  List<RoomModel> get rooms => _rooms;

  void addRoom(String name, String icon) {
    // Generate a unique ID
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    // Create new room
    final newRoom = RoomModel(id: id, name: name, icon: icon);

    // Add room to the list
    _rooms.add(newRoom);
    notifyListeners();
  }

  void deleteRoom(String id) {
    _rooms.removeWhere((room) => room.id == id);
    notifyListeners();
  }

  // List of predefined room icons
  List<String> get availableRoomIcons => [
        'living_room',
        'bedroom',
        'kitchen',
        'bathroom',
        'office',
        'garage',
        'garden',
        'dining_room',
      ];
}
