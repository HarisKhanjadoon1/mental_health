import 'dart:typed_data';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mental_health/Dashboard/Dashboard.dart';
import 'package:mental_health/SplashScreen/SplashScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mental_health/l10n/app_localization.dart';
import 'package:mental_health/l10n/languageProvider.dart';
import 'package:mental_health/l10n/localConstants.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uid = Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => LanguageProvider()),
          ],
          child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  @override
  void initState() {
    super.initState();
    _initializeLocale();
  }

  void _initializeLocale() async {
    Locale locale = await LocaleConstants.getLocale();
    setState(() {
      _locale = locale;
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {

    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale?.languageCode == locale?.languageCode &&
              supportedLocale?.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales?.first;
      },
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('ur', ''),
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: languageProvider.locale.languageCode == 'ur'
              ? TextDirection.ltr
              : TextDirection.ltr,
          child: child!,
        );
      },
      home: Dashboard(),
    );
  }
}
