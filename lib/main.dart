import 'package:first/ItemList.dart';
import 'package:first/TreeList.dart';
import 'package:first/TreeScreen.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'AdTreesAppTopBar.dart';
import 'Planet.dart';
import 'ItemList.dart';
import 'AdTreesApp.dart';
import 'PollutedZones.dart';
import 'Timer.dart';
import 'Save.dart';
import 'dart:io';
import 'dart:core';

import 'package:path_provider/path_provider.dart';

void main() {
    //Admob.initialize('ca-app-pub-3940256099942544~3347511713');
    //Save().saveGame();
    runApp(new SplashScreen());
    
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: 'Making Tree Babies',
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
      title: "Loading",
      home: 
      Scaffold(
      body:
      Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.greenAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 40,
                           width: 40,
                          decoration:new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage("assets/images/cactus.png"),
                              fit: BoxFit.fill,
                            ),
                          ),),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "AdTrees",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "The Trees Are Growing",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          )
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
      print("From saved file: " +userData);
    } catch (e) {
      //Initialising the whole game
      userData = Save().emergencyRecovery();
    }
    return userData;
  }

  Future <Text> waitingScreen() async{
    Save();

    String userData = await loadingData();
    Save().readGame(userData);
    await Future.delayed(Duration(seconds:5));
    return Text("Loading...");
  }



