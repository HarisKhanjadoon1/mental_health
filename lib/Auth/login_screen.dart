// ignore_for_file: use_build_context_synchronously

import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/Assessment/Assessment.dart';
import 'package:mental_health/Auth/helper_function.dart';
import 'package:mental_health/Auth/register_screen.dart';
import 'package:mental_health/Auth/services/auth_services.dart';
import 'package:mental_health/Auth/usermodel.dart';
import 'package:mental_health/Dashboard/Dashboard.dart';
import 'package:mental_health/widget/Appcolor.dart';
import 'package:mental_health/widget/widgets.dart';



class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _isloading = false;
  String role = '';
  String name = '';
  String accountcategory = '';
  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      body: _isloading
          ? Center(
        child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor),
      )
          : SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Container(
                height: 290,
                decoration: BoxDecoration(
                  color: AppColors.ecogreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(90, 50),
                    bottomRight: Radius.elliptical(90, 50),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/images/logo.jpeg",
                    width: 150.0,  // Set your desired width
                    height: 150.0,  // Set your desired height
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 12, 30, 8),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: textinputDecoration.copyWith(
                        labelText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color:AppColors.ecogreen,
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val) {
                        return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!)
                            ? null
                            : "Please enter a valid email";
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: textinputDecoration.copyWith(
                        labelText: "Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color:AppColors.ecogreen,
                        ),
                      ),
                      validator: (val) {

                        if (val!.length < 6) {
                          return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)
                              ? null
                              : "Please enter a valid passward with Regular Expression";
                        }
                        else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.ecogreen,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          login();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text.rich(
                      TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              color: Colors.black

                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Register here",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Nunito',
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => nextScreen(
                                      context, const RegisterScreen())),
                          ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                        },
                        child: Text("Forget Password")),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  login() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
    }
    await authServices.loginUser(email, password).then((value) async {
      if (value == true) {
        final firebaseuser = FirebaseAuth.instance.currentUser!.uid;

        if (firebaseuser != null) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(firebaseuser)
              .get()
              .then((value) {
            UserModel userModel =
            UserModel.fromMap(value.data() as Map<String, dynamic>);
            name = userModel.fullName.toString();
          });
        }
        await HelperFunction.saveUserLoggedInStatus(true);
        await HelperFunction.saveUserEmail(email);
        await HelperFunction.saveUserNameSp(name);

        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          final firebaseuser = FirebaseAuth.instance.currentUser!.uid;
          await FirebaseFirestore.instance
              .collection("users")
              .doc(firebaseuser)
              .get()
              .then((value) {
            nextScreenReplace(context, const Dashboard());

          });
        } else {
          nextScreen(
            context,

            const Dashboard(),

          );

        }
      } else {
        showSnakBar(context, Colors.red, value);
        setState(() {
          _isloading = false;
        });
      }
    });


  }



}
