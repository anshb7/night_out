// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
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

class Prodcutspage extends StatefulWidget {
  const Prodcutspage({Key? key}) : super(key: key);

  @override
  State<Prodcutspage> createState() => _ProdcutspageState();
}

class _ProdcutspageState extends State<Prodcutspage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
