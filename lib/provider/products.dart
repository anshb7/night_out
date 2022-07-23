import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import './productdetails.dart';
import '../screens/add_productscreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class Products with ChangeNotifier {
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  List<Product> _items = [];

  Future<List> get items async {
    await users
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs.map(
            (DocumentSnapshot documentSnapshot) => Product(
                title: documentSnapshot["title"],
                description: documentSnapshot["description"],
                price: documentSnapshot["price"],
                imageUrl: documentSnapshot["imageUrl"])))
        .toList();

    return [..._items];
  }
}
