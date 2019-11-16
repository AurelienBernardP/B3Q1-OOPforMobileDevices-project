import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'dart:io';
import 'dart:async';
class AdTreesAppTopBar extends AppBar {
  final String text = "AdTrees";
  AppBar bar;

  AdTreesAppTopBar(String text, BuildContext context) {
    this.text.replaceAll('AdTrees', text);
    Widget button = IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
      },
    );

    AppBar bar = new AppBar(
      title: Text(text),
      backgroundColor: Colors.green,
      actions: <Widget>[button],
    );
    this.bar = bar;
  }
  AppBar getBar() => bar;
}

class SettingsScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("settings"),
        ),
        backgroundColor: Colors.green,
        body: Container(
          child: Container(
            child: AdmobBanner(
                adUnitId: 'ca-app-pub-3940256099942544/6300978111',
                adSize: AdmobBannerSize.LARGE_BANNER,
                listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                  switch (event) {
                    case AdmobAdEvent.loaded:
                      print('Admob banner loaded!');
                      break;

                    case AdmobAdEvent.opened:
                      print('Admob banner opened!');
                      break;

                    case AdmobAdEvent.closed:
                      print('Admob banner closed!');
                      break;

                    case AdmobAdEvent.failedToLoad:
                      print(
                          'Admob banner failed to load. Error code: ${args['errorCode']}');
                      break;
                    default:
                      break;
                  }
                }),
          ),
        ));
  }
}
