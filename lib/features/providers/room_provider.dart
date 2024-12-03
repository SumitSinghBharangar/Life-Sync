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

  void addRoom(RoomModel room) {
    _rooms.add(room);
    notifyListeners();
  }
}
