import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:night_out/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:night_out/otpscreen.dart';
import 'package:night_out/provider/googlesignin.dart';
import 'package:provider/provider.dart';
import 'loginnpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
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
            Text(
              "pret couture",
              style: TextStyle(
                  fontFamily: "SignPainter", fontSize: 10, color: Colors.black),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          CarouselSlider(
            items: [
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    scale: 2,
                    image: NetworkImage(
                        "https://www.fabindia.com/ccstore/v1/images/?source=/file/v5502430193602780392/products/10702398WN.f.14.10.21.jpg&height=475&width=475"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://www.fabindia.com/ccstore/v1/images/?source=/file/v2980669719710341180/products/10730264YL.f.19.04.22.JPG&height=940&width=940"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://www.fabindia.com/ccstore/v1/images/?source=/file/v9024915306022692968/products/10679377BU.f.15.04.21.jpg&height=475&width=475"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://www.fabindia.com/ccstore/v1/images/?source=/file/v6031255366014275427/products/10713450RD.f.15.01.2022.jpg&height=475&width=475"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://www.fabindia.com/ccstore/v1/images/?source=/file/v730584163968987835/products/10712230BU.f.23022022.jpg&height=475&width=475"),
                      fit: BoxFit.cover),
                ),
              ),
            ],

            //Slider Container properties
            options: CarouselOptions(
              height: 475,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 9 / 16,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              viewportFraction: 0.8,
            ),
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
