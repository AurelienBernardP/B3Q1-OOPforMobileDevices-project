import 'dart:io';

import 'package:flutter/material.dart';
import 'Guide.dart';
import 'Wallet.dart';
import 'package:admob_flutter/admob_flutter.dart';

class AdTreesAppTopBar {
  final String text = "AdTrees";
  AppBar bar;

  AdTreesAppTopBar(String text, BuildContext context, {bool isGuide}) {
    this.text.replaceAll('AdTrees', text);

    AdmobInterstitial interstitialAd = AdmobInterstitial(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
    );
    interstitialAd.load();
    Widget settingsButton = Container(
      margin: new EdgeInsets.only(bottom: 10.0, right: 30.0),
      child: IconButton(
        icon: Icon(Icons.help_outline, color: Colors.blueGrey[100], size: 40.0),
        onPressed: () {
          if (isGuide == null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Guide()),
            );
          }
        },
      ),
    );
    Widget adsButton = GestureDetector(
      onTap: () async {
        if (await interstitialAd.isLoaded) {
          interstitialAd.show();
          Wallet().addCoins(2);
          interstitialAd = AdmobInterstitial(
            adUnitId: 'ca-app-pub-3940256099942544/1033173712',
          );
          interstitialAd.load();
        }
      },
      child: Container(
        margin: new EdgeInsets.only(bottom: 10.0, left: 10.0),
        //alignment: Alignment.topRight,
        height: MediaQuery.of(context).size.height / 20,
        width: MediaQuery.of(context).size.height / 20,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/button_play.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
    Widget backButton = GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: new EdgeInsets.only(bottom: 10.0, left: 10.0),
        //alignment: Alignment.topRight,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/left.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
        /*IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),*/
        bar = new AppBar(
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blueGrey[100],
              ),
            ),
            Row(children: <Widget>[
              Text(
                Wallet().getCoins().toString(),
                maxLines: 1,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.yellow,
                ),
              ),
              Icon(Icons.strikethrough_s, color: Colors.yellow, size: 25.0),
              adsButton,
            ]),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      leading: Navigator.canPop(context) ? backButton : null,
      actions: <Widget>[settingsButton],
    );
    this.bar = bar;
  }
  AppBar getBar() => bar;
}
