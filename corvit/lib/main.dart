import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:corvit/firebase_options.dart';
import 'package:corvit/search.dart';
import 'package:corvit/shoes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );

  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: shoes(),
  ));
}

class splashscreen extends StatelessWidget {
  const splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen.fadeIn(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.white,
        onInit: () {
          debugPrint("On Init");
        },
        onEnd: () {
          debugPrint("On End");
        },
        childWidget: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/images/download.png"),
        ),
        onAnimationEnd: () => debugPrint("On Fade In End"),
        nextScreen:  shoes(),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
    );
  }
}

