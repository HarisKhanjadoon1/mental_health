import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String userLoggedInKey = "LoggedInkey";
  static String userNameKey = "UserNameKey";
  static String userEmailKey = "UserEmailKey";
  static String driverLoggedInKey = "LoggedInkey";
  static String driverNameKey = "UserNameKey";
  static String driverEmailKey = "UserEmailKey";

  //saving data in sharedpref
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSp(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmail(String useremail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, useremail);
  }

  //getting data from sp
  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserNameSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  static Future<String?> getUserEmailSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }
  //saving driverdata in sharedpref
  static Future<bool> savedriverLoggedInStatus(bool isdriverLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(driverLoggedInKey, isdriverLoggedIn);
  }

  static Future<bool> savedriverNameSp(String driverName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(driverNameKey, driverName);
  }

  static Future<bool> savedriverEmail(String driveremail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(driverEmailKey, driveremail);
  }

  //getting drievrdata from sp
  static Future<bool?> getdriverLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(driverLoggedInKey);
  }

  static Future<String?> getdriverNameSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(driverNameKey);
  }

  static Future<String?> getdriverEmailSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(driverEmailKey);
  }
}
