import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_health/l10n/languageProvider.dart';
import 'package:mental_health/widget/Appcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User? user;
  String? name;
  String? email;
  String? phone;
  String selectedLanguage = 'English';
  final List<String> languages = ['English', 'Urdu'];

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
    _initializeApp();
  }

  Future<void> fetchUserProfile() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
      setState(() {
        user = currentUser;
        name = userDoc['fullName'];
        email = userDoc['email'];
        phone = userDoc['phone'];
      });
    }
  }
  String _currentLanguage = 'en';

  Future<void> _initializeApp() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString('language_code') ?? 'en';

  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            languageProvider.translate('setting'),),
        backgroundColor:AppColors.ecogreen,
        elevation: 0,
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
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
                  width: 150.0, // Set your desired width
                  height: 150.0, // Set your desired height
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20),
            buildProfileField('Name', name),
            SizedBox(height: 10),
            buildProfileField('Email', email),
            SizedBox(height: 10),
            buildProfileField('Phone', phone),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Language',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedLanguage,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLanguage = newValue!;
                          });
                        },
                        items: languages.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              value ?? '',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}


