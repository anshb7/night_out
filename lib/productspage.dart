import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:night_out/login.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'provider/googlesignin.dart';

class Prodcutspage extends StatefulWidget {
  const Prodcutspage({Key? key}) : super(key: key);

  @override
  State<Prodcutspage> createState() => _ProdcutspageState();
}

class _ProdcutspageState extends State<Prodcutspage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.displayName.toString()),
        actions: [
          IconButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
