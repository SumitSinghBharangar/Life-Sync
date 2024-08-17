import 'dart:convert';

import 'package:life_sync/common/models/master_model.dart';

class UserModel extends MasterPerson{
  String mail;
  String uid;
  String name;
  String image;
  String phone;
  String homeAddress;
  String imageUrl;
  List<String> tokens;
  UserModel({
    required this.mail,
    required this.homeAddress,
    required this.image,
    required this.imageUrl,
    required this.name,
    required this.phone,
    required this.tokens,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mail': mail,
      'uid': uid,
      'name': name,
      'image': image,
      'phone': phone,
      'homeAddress': homeAddress,
      'imageUrl': imageUrl,
      'tokens': tokens,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      mail: map['mail'] as String,
      uid: map['uid'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      phone: map['phone'] as String,
      homeAddress: map['homeAddress'] as String,
      imageUrl: map['imageUrl'] as String,
      tokens: List<String>.from(map['tokens'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}