import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String address;
  String profile;
  String phone;
  String email;
  DateTime dob;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime lastSignIn;

  UserModel({
    required this.uid,
    required this.name,
    required this.address,
    required this.profile,
    required this.phone,
    required this.email,
    required this.dob,
    required this.createdAt,
    required this.updatedAt,
    required this.lastSignIn,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "uid": uid,
      "name": name,
      "address": address,
      "profile": profile,
      "phone": phone,
      "email": email,
      "dob": dob,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": Timestamp.fromDate(updatedAt),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      profile: map['profile'] as String,
      phone: map['phone'] as String,
      email: map['phone'] as String,
      dob: map['dob'] as DateTime,
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
      lastSignIn: map['lastSignIn'] as DateTime,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
