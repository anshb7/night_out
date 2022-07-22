import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:night_out/otpscreen.dart';
import 'package:night_out/provider/googlesignin.dart';
import 'package:night_out/screens/productspage.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController phone_no = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Welcome!",
            style: TextStyle(
                fontFamily: "SignPainter", fontSize: 40, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 340,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/fashion.gif")),
                      borderRadius: BorderRadius.circular(30))),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    """New User? Sign up below :""",
                    style: TextStyle(fontFamily: "SignPainter", fontSize: 30),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                        cursorColor: Colors.black,
                        controller: phone_no,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            prefix: Padding(
                              padding: EdgeInsets.all(4),
                              child: Text('+91'),
                            ),
                            focusColor: Colors.black,
                            labelText: "Enter phone no:",
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )))),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OTPScreen(phone_no.text)));
                  },
                  child: Text("Get OTP"),
                ),
              ),
              Divider(
                thickness: 1,
                indent: 23,
                endIndent: 23,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    """OR""",
                    style: TextStyle(fontFamily: "SignPainter", fontSize: 30),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: GestureDetector(
                        onTap: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.signInWithGoogle();
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              "https://cdn2.hubspot.net/hubfs/53/image8-2.jpg"),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/en/thumb/0/04/Facebook_f_logo_%282021%29.svg/640px-Facebook_f_logo_%282021%29.svg.png"),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              "https://www.pngkey.com/png/full/2-27646_twitter-logo-png-transparent-background-logo-twitter-png.png"),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
