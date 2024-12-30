

import 'package:flutter/material.dart';
import 'package:mental_health/widget/Appcolor.dart';

const textinputDecoration = InputDecoration(
  labelStyle: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w300,
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.ecogreen,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.ecogreen,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.ecogreen,
    ),
  ),
);
void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnakBar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
      backgroundColor: color,
    ),
  );
}
