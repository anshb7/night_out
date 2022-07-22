// ignore_for_file: unused_local_variable

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
  var title;
  var description;
  var price;
  final _titlefocusnode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  TextEditingController _title = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Hi!" + user!.displayName.toString(),
          style: TextStyle(
              color: Colors.black, fontFamily: "SignPainter", fontSize: 35),
        ),
        actions: [
          IconButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                focusNode: _titlefocusnode,
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(
                    focusColor: Colors.black,
                    labelText: "Enter the title of your product",
                    labelStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                controller: _title,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  description = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description.';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  }
                  return null;
                },
                focusNode: _descriptionFocusNode,
                maxLines: 5,
                decoration: InputDecoration(
                    focusColor: Colors.black,
                    labelText: "Enter the description of your product",
                    labelStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                controller: _description,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  price = double.parse(value);
                },
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    focusColor: Colors.black,
                    labelText: "Enter the price of your product",
                    labelStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                controller: _price,
              ),
            ),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      price = double.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    decoration: InputDecoration(
                        focusColor: Colors.black,
                        labelText: "Upload an image",
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.upload_sharp,
                    size: 30,
                  ))
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 1,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      users
                          .add({
                            "title": title,
                            "description": description,
                            "price": price
                          })
                          .then((value) => print("User Added"))
                          .catchError((error) => print("Failed to add user"));
                    },
                    child: Text("Submit")),
              ),
            )
          ],
        )),
      ),
    );
  }

  void selecfile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) {
      return null;
    }
    final path = result.files.single.path;
    setState(() {});
  }
}
