import 'package:flutter/material.dart';
import 'package:mental_health/l10n/languageProvider.dart';
import 'package:mental_health/resource/Webview.dart';
import 'package:mental_health/widget/Appcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
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
    return Scaffold(
      backgroundColor: AppColors.solightblue,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppColors.ecogreen,
          title: Text(
            languageProvider.translate('resource_library'),
            style: TextStyle(
              fontFamily: 'SourceSansPro',
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),

      body: Stack(
        children: <Widget>
        [
          SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    // padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),


                    ),
                    child: MaterialButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(url: 'https://youtu.be/NQcYZplTXnQ',)));
                    },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset("assets/images/video.png"),
                          ),
                          Text(
                            languageProvider.translate('Video link'),
                            style: new TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito'
                            ),

                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    // padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),


                    ),
                    child: MaterialButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(url: 'https://youtu.be/DxIDKZHW3-E?feature=shared',)));
                    },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset("assets/images/video.png"),
                          ),
                          Text(
                            languageProvider.translate('Video link'),
                            style: new TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito'
                            ),

                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    // padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),


                    ),
                    child: MaterialButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(url: 'https://youtu.be/gWs-AswW398?si=b0aNfkk8fxlWN-RE',)));
                    },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset("assets/images/video.png"),
                          ),
                          Text(
                            languageProvider.translate('Video link'),
                            style: new TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito'
                            ),

                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    // padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),


                    ),
                    child: MaterialButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(url: 'https://youtu.be/RzPcWnrdlmw?si=lxVmhdqCg3euSKM8',)));
                    },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset("assets/images/video.png"),
                          ),
                          Text(
                            languageProvider.translate('Video link'),
                            style: new TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito'
                            ),

                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    // padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),


                    ),
                    child: MaterialButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(url: 'https://youtu.be/syWAzm0p3xo?si=RDj6sRiBv3LbKoHt',)));
                    },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset("assets/images/video.png"),
                          ),
                          Text(
                            languageProvider.translate('Video link'),
                            style: new TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito'
                            ),

                          ),

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),

    );
  }
}
