import 'package:flutter/material.dart';
import 'package:life_sync/common/buttons/dynamic_button.dart';
import 'package:life_sync/common/buttons/scale_button.dart';
import 'package:provider/provider.dart';
import '../providers/room_provider.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({super.key});

  @override
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  String _roomName = '';
  String _selectedIcon = 'living_room';

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Room Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room name';
                  }
                  return null;
                },
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                onSaved: (value) {
                  _roomName = value!;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Room Icon',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: roomProvider.availableRoomIcons.length,
                  itemBuilder: (context, index) {
                    final icon = roomProvider.availableRoomIcons[index];
                    return ScaleButton(
                      onTap: () {
                        setState(() {
                          _selectedIcon = icon;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: _selectedIcon == icon
                                  ? Colors.blue
                                  : Colors.grey.shade200,
                              width: 2),
                          color: _selectedIcon == icon
                              ? Colors.blue.shade100
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            icon.replaceAll('_', ' ').toUpperCase(),
                            style: TextStyle(
                                fontWeight: _selectedIcon == icon
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              DynamicButton.fromText(
                  text: "Add Rooms",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // Add room using provider
                      roomProvider.addRoom(_roomName, _selectedIcon);

                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Room added successfully!')),
                      );

                      // Navigate back
                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
