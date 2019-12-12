import 'package:admob_flutter/admob_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'AdTreesApp.dart';
import 'Save.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:io';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void main() {
    //initialize the admob package with a test acount id
    Admob.initialize('ca-app-pub-3940256099942544~3347511713');
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(new SplashScreen());
    });
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: 'Making the world greener',
      future: waitingScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            return AdTreesApp();
          }
          else{
            return splashScreenDiplay();
          }
        },
    );
  }


  MaterialApp splashScreenDiplay(){

    return 
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Loading",
      home: 
      Scaffold(
      body:
      Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration:new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/treemap.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                    Container(
                      child: 
                      Text(
                        "AdTrees",
                        style: TextStyle(
                            color: Colors.yellow[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 50
                            ),
                      ),
                    ),
                    CircularProgressIndicator(backgroundColor: Colors.yellow, valueColor: new AlwaysStoppedAnimation<Color>(Colors.green)),
                  ],
                ),
        ],
      ),
    )
    );
    
  }
}

  Future <String> loadingData() async{
    String userData;
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user.txt');
      userData = await file.readAsString();
      String key = '201640382014185520176639.Caramel';
      final keyEncrypter = encrypt.Key.fromUtf8(key);
      final iv = encrypt.IV.fromLength(16);

      encrypt.Encrypter encrypter = encrypt.Encrypter(encrypt.AES(keyEncrypter));
      final decrypted = encrypter.decrypt64(userData, iv: iv);

      userData = decrypted;
    } catch (e) {
      print("Save incorrect or not existing.");
    }
    return userData;
  }

  Future <Text> waitingScreen() async{
    Save();
    String userData = await loadingData();
    if(!Save().readGame(userData)){
      Save().reset();
      Save().readGame(Save().emergencyRecovery());
    }
    await Future.delayed(Duration(seconds:2));
    return Text("Loading...");
  }



