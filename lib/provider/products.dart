import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import './productdetails.dart';
import '../screens/add_productscreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Products with ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Future getusersdata() async {
    try {
      final uid = user!.uid;
      var data = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("users")
          .orderBy("price", descending: true)
          .get() as Map<String, dynamic>;
      final List<Product> loadedproducts = [];
      data.forEach((uid, value) {
        loadedproducts.add(Product(
            title: value["title"],
            description: value["description"],
            price: value["price"],
            imageUrl: value["imageUrl"]));
      });
      _items = loadedproducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
