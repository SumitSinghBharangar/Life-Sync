import 'package:cloud_firestore/cloud_firestore.dart';

var _store = FirebaseFirestore.instance;

CollectionReference<Map<String, dynamic>> usersCollection =
    _store.collection('users');
