import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
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

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  UploadTask? uploadTask;
  File? file;
  var title;
  var description;
  var price;
  late String imageUrl;
  final _titlefocusnode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  TextEditingController _title = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final filename = file != null ? basename(file!.path) : "No file Selected";
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
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
          "Add Product Details",
          style: TextStyle(
              color: Colors.black, fontFamily: "SignPainter", fontSize: 35),
        ),
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
                  child: TextField(
                    onChanged: (value) {
                      price = double.parse(value);
                    },
                    decoration: InputDecoration(
                        focusColor: Colors.black,
                        labelText: filename.toString(),
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
                  onPressed: () {
                    selecfile();
                  },
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
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      uploadfile();
                      users
                          .add({
                            "title": title,
                            "description": description,
                            "price": price,
                            "imageUrl": imageUrl
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
    setState(() => file = File(path.toString()));
  }

  Future uploadfile() async {
    if (file == null) {
      return;
    }
    final fileName = File(file!.path);
    final destination = "productImages/$fileName";
    final ref = FirebaseStorage.instance.ref().child(destination);
    uploadTask = ref.putFile(fileName);
    final snapshot = await uploadTask!.whenComplete(() => {});
    final url = await snapshot.ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }
}
