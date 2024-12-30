import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mental_health/Auth/login_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? finalEmail;

  get Get => null;


  @override
  void initState() {
    Timer(Duration(seconds: 5),(){
      Get.off(LogInScreen());
    });
    // TODO: implement initState
    super.initState();
  }


/*
  Future getValidationData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedEmail  = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);

  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backgroundd.jpg'),
                fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.4),
              ])),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Mind Rate",
                    style: TextStyle(
                        fontFamily: "Nunito",
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Text(
                  "Let's Assessment your Mental Health.",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Nunito",),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}