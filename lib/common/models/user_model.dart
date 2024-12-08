import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;

  String name;
  String address;
  String? profile;
  String profileUrl;
  String phone;
  String email;
  DateTime dob;
  DateTime? createdAt;
  DateTime updatedAt;

  List<String>? tokens;

  UserModel({
    this.uid,
    required this.name,
    required this.address,
    this.profile,
    required this.profileUrl,
    required this.phone,
    required this.email,
    required this.dob,
    this.createdAt,
    required this.updatedAt,
    this.tokens,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "uid": uid ?? "",
      "name": name,
      "address": address,
      "profile": profile ?? "",
      "profileUrl": profileUrl,
      "phone": phone,
      "email": email,
      "dob": dob,
      "createdAt": createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      "updatedAt": Timestamp.fromDate(updatedAt),
      "tokens": tokens ?? "",
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
      dob: (map['dob'] as Timestamp).toDate(),
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      tokens: map["tokens"] != null
          ? List<String>.from(map['tokens'] as List<dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
