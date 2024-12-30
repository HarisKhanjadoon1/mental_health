
import 'package:flutter/material.dart';
import 'package:mental_health/Assessment/QuizPage.dart';
import 'package:mental_health/l10n/languageProvider.dart';
import 'package:mental_health/widget/Appcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Assessment extends StatefulWidget {
  const Assessment({Key? key}) : super(key: key);

  @override
  State<Assessment> createState() => _AssessmentState();
}

class _AssessmentState extends State<Assessment> {
  String _currentLanguage = 'en';
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString('language_code') ?? 'en';

  }





  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    List<String> depression = [
      languageProvider.translate('dipone'),
      languageProvider.translate('diptwo'),
      languageProvider.translate('dipthree'),
      languageProvider.translate('dipfour'),
      languageProvider.translate('dipfive'),
      languageProvider.translate('dipsix'),
      languageProvider.translate('dipseven'),
      languageProvider.translate('dipeight'),
    ];
    List<String> anxiety = [
      languageProvider.translate('anxone'),
      languageProvider.translate('anxtwo'),
      languageProvider.translate('anxthree'),
      languageProvider.translate('anxfour'),
      languageProvider.translate('anxfive'),
      languageProvider.translate('anxsix'),
      languageProvider.translate('anxseven'),
    ];

    List<String> pstd = [
      languageProvider.translate('pstdone'),
      languageProvider.translate('pstdtwo'),
      languageProvider.translate('pstdthree'),
      languageProvider.translate('pstdfour'),
      languageProvider.translate('pstdfive'),
    ];

    List<String> schizophrenia = [
      languageProvider.translate('schone'),
      languageProvider.translate('schtwo'),
      languageProvider.translate('schthree'),
      languageProvider.translate('schfour'),
      languageProvider.translate('schfive'),
      languageProvider.translate('schsix'),
      languageProvider.translate('schseven'),
      languageProvider.translate('scheight'),
    ];

    List<String> stressQuestions = [
      languageProvider.translate('stressone'),
      languageProvider.translate('stresstwo'),
      languageProvider.translate('stressthree'),
      languageProvider.translate('stressfour'),
      languageProvider.translate('stressfive'),
      languageProvider.translate('stresssix'),

    ];


    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.translate('assessment Test'),),
        centerTitle: true,
        backgroundColor: AppColors.ecogreen,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height / 3,
                width: 0.90 * width,
                child: Image(
                  image: AssetImage('assets/images/test.jpg'),
                ),
              ),
              SizedBox(height: height / 40),
              Text(
                  languageProvider.translate('choose self assesment test based on following disorders'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(height: height / 20),
              InkWell(
                child: ListTile(
                  title: Center(child: Text(languageProvider.translate('depression'), style: style)),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizPage(
                              depression,
                              8,
                              languageProvider.translate('depression'),
                              [Colors.blue, Colors.greenAccent])));
                },
              ),
              SizedBox(height: height / 60),
              InkWell(
                child: ListTile(
                  title: Center(child: Text( languageProvider.translate('anxiety'), style: style)),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizPage(
                              anxiety,
                              7,
                              languageProvider.translate('anxiety and stress'),
                              [Colors.red, Colors.pinkAccent])));
                },
              ),
              SizedBox(height: height / 60),
              InkWell(
                child: ListTile(
                  title: Center(child: Text(languageProvider.translate('PTSD'), style: style)),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizPage(
                              pstd, 5, languageProvider.translate('PTSD'), [Colors.cyan, Colors.teal])));
                },
              ),
              SizedBox(height: height / 60),
              InkWell(
                child: ListTile(
                  title: Center(child: Text(languageProvider.translate('schizophrenia'), style: style)),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizPage(
                              schizophrenia,
                              8,
                              languageProvider.translate('schizophrenia'),
                              [Colors.purple, Colors.indigo])));
                },
              ),
              SizedBox(height: height / 60),
              InkWell(
                child: ListTile(
                  title: Center(child: Text( languageProvider.translate('stress'), style: style)),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizPage(stressQuestions, 6,
                              languageProvider.translate('stress'), [Colors.brown, Colors.blueGrey])));
                },
              ),
              SizedBox(height: height / 60),
            ],
          ),
        ),
      ),
    );
  }
}

const style = TextStyle(fontSize: 15, color: Colors.black);
