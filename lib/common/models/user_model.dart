import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;

  String name;
  String address;
  String profile;
  String profileUrl;
  String phone;
  String email;
  DateTime dob;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime lastSignIn;
  List<String> tokens;

  UserModel({
    required this.uid,
    required this.name,
    required this.address,
    required this.profile,
    required this.profileUrl,
    required this.phone,
    required this.email,
    required this.dob,
    required this.createdAt,
    required this.updatedAt,
    required this.lastSignIn,
    required this.tokens,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "uid": uid,
      "name": name,
      "address": address,
      "profile": profile,
      "profileUrl": profileUrl,
      "phone": phone,
      "email": email,
      "dob": dob,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": Timestamp.fromDate(updatedAt),
      "tokens": tokens,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      profile: map['profile'] as String,
      profileUrl: map["profileUrl"] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      dob: map['dob'] as DateTime,
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
      lastSignIn: map['lastSignIn'] as DateTime,
      tokens: List<String>.from(map['tokens'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
