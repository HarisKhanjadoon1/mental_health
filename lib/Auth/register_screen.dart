

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mental_health/Auth/helper_function.dart';
import 'package:mental_health/Auth/login_screen.dart';
import 'package:mental_health/widget/Appcolor.dart';
import 'package:mental_health/widget/widgets.dart';


import './services/auth_services.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isloading = false;
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String fullName = '';
  String phone = '';
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                labelText: "Full Name",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color:AppColors.ecogreen,
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  fullName = val;
                                });
                              },
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "Name cannot be empty";
                                }
                              }),
                          const SizedBox(
                            height: 15.0,
                          ),
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
                                return "Password must be at least 6 characters";
                              } else {
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
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: textinputDecoration.copyWith(
                              labelText: "Phone",
                              prefixIcon: Icon(
                                Icons.phone,
                                color:AppColors.ecogreen,
                              ),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Phone number is required";
                              }
                              else if (val.contains('@#!%^&*()abcbefghigklmnopqrst')) {
                                return "enter valid phone number";
                              } else if (val.length>11) {
                                return "enter valid phone number";
                              }
                              else if (val.length<11) {
                                return "enter valid phone number";
                              }
                              else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                phone = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 7,
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
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () {
                                register();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(
                                text: "Already have an account? ",
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Login now",
                                    style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => nextScreen(
                                        context,
                                        const LogInScreen(),
                                      ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
    );
  }

  register() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
    }
    //String category = _category.toString().split('.').last;
    await authServices
        .regiseterUser(fullName, email, password, phone)
        .then((value) async {
      if (value == true) {
        await HelperFunction.saveUserLoggedInStatus(true);
        await HelperFunction.saveUserEmail(email);
        await HelperFunction.saveUserNameSp(fullName);
        // ignore: use_build_context_synchronously
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          // ignore: use_build_context_synchronously
          nextScreenReplace(context, const LogInScreen());
          Fluttertoast.showToast(msg: "Register Succesfully");
        } else {
          // ignore: use_build_context_synchronously
          /*nextScreen(
            context,
            const VerifyEmail(),
          );*/
          nextScreenReplace(context, const LogInScreen());
          Fluttertoast.showToast(msg: "Register Succesfully");
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
