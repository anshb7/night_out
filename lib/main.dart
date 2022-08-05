import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:night_out/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:night_out/otpscreen.dart';
import 'package:night_out/provider/googlesignin.dart';
import 'package:night_out/provider/productdetails.dart';
import 'package:night_out/provider/products.dart';
import 'package:night_out/screens/productspage.dart';
import 'package:provider/provider.dart';
import 'loginnpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GoogleSignInProvider()),
        ChangeNotifierProvider.value(value: Products())
      ],
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(primary: Colors.white, secondary: Colors.white),
            fontFamily: "Roboto",
            textSelectionTheme:
                TextSelectionThemeData(cursorColor: Colors.black),
            progressIndicatorTheme: ProgressIndicatorThemeData(
              color: Colors.black,
              refreshBackgroundColor: Colors.black,
              circularTrackColor: Colors.white,
            ),
            androidOverscrollIndicator: AndroidOverscrollIndicator.glow),
        home: Homepage(),
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            Text(
              "Nirvana",
              style: TextStyle(
                fontFamily: "SignPainter",
                fontSize: 40,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: double.infinity,
            width: 475,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                        "https://st2.depositphotos.com/2333335/7730/v/450/depositphotos_77309022-stock-illustration-vector-watercolor-pink-dress.jpg"))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              """All your fashion needs at one place!""",
              style: TextStyle(fontFamily: "SignPainter", fontSize: 40),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(2),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontFamily: "SignPainter",
                          fontSize: 40,
                          color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Loginnpage())));
                    },
                  ),
                ),
              ),
              Icon(Icons.arrow_circle_right_sharp)
            ],
          )
        ],
      ),
    );
  }
}
