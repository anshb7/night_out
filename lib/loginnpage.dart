import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:night_out/productspage.dart';
import 'login.dart';

class Loginnpage extends StatelessWidget {
  const Loginnpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return Prodcutspage();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something went worng"),
            );
          } else {
            return Loginpage();
          }
        });
  }
}
