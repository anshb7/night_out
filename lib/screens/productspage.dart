// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:night_out/provider/productdetails.dart';
import 'package:night_out/provider/products.dart';
import 'package:night_out/screens/add_productscreen.dart';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:night_out/login.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../provider/googlesignin.dart';
import 'package:file_picker/file_picker.dart';
import '../provider/products.dart';

class Prodcutspage extends StatefulWidget {
  const Prodcutspage({Key? key}) : super(key: key);

  @override
  State<Prodcutspage> createState() => _ProdcutspageState();
}

class _ProdcutspageState extends State<Prodcutspage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshProducts(BuildContext context) async {
    await getusersdata();
  }

  @override
  Widget build(BuildContext context) {
    final prod = Provider.of<Products>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              icon: Icon(
                Icons.logout_sharp,
                color: Colors.black,
              ))
        ],
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Hi! " + user!.displayName.toString(),
          style: TextStyle(
              color: Colors.black, fontFamily: "SignPainter", fontSize: 35),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: StreamBuilder<List<Product>>(
            stream: getusersdata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final products = snapshot.data!.toList();
                return GridView.builder(
                    itemCount: products.length,
                    padding: EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (BuildContext ctx, i) {
                      return GridTile(
                        child: GestureDetector(
                          child: Image.network(products[i].imageUrl),
                        ),
                        footer: GridTileBar(
                          backgroundColor: Colors.black,
                          title: Text(products[i].title),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

Stream<List<Product>> getusersdata() =>
    FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
