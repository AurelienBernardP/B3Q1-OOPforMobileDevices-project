import 'package:flutter/material.dart';
import 'Guide.dart';
import 'Wallet.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';

/* adTreesAppTopBar 
 *
 * This class creates a general appbar that can be used
 * throughout the whole application
 * 
 *   atributes: 
 *     text : appbar title
 *     bar : Appbar
 *     intertitialAd : admob advertisement reference
 */
class AdTreesAppTopBar {
  final String text = "AdTrees"; //appbar title by default
  AppBar bar; //Appbar
  AdmobInterstitial interstitialAd; // admob advertisement reference

  /*Constructor
   * input:
   *    text- String to be displayed as the title of the appbar
   *    context- context in which the appbar is being built 
   *    isGuide- (optional parameter) - boolean that should be set to true if
   *            if the bar is build inn the guide to avoid navigation to the current screen
   * 
   * return: AdTreesAppTopBar object holding an instantiated appbar 
   */
  AdTreesAppTopBar(String text, BuildContext context, {bool isGuide}) {
    this.text.replaceAll('AdTrees', text); //replace the defaullt text

    //intatiiate the app advertisement
    interstitialAd = AdmobInterstitial(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
    );
    //load the avertisement for it to be readily available
    interstitialAd.load();

    Widget guideButton = Container(
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
    //button to diisplay an advert
    Widget adsButton = GestureDetector(
      onTap: () async {
        if (await interstitialAd.isLoaded) {
          Wallet().addCoins(2); //reward the user
          interstitialAd.show(); //show the advert
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EmptyAdScreen()));
          interstitialAd = AdmobInterstitial(
            adUnitId: 'ca-app-pub-3940256099942544/1033173712',
          );
          interstitialAd.load(); //load new ad
        }
      },
      child: Container(
        margin: new EdgeInsets.only(bottom: 10.0, left: 10.0),
        height: MediaQuery.of(context).size.height / 15,
        width: MediaQuery.of(context).size.height / 15,
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/left.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );

    var title = AutoSizeText.rich(
      TextSpan(
        text: text +" |",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey[100],
        ),
        children: <TextSpan>[
          TextSpan(
            text:" "+ Wallet().getCoins().toString() + "\$",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.yellow,
            ),
          ),
        ],
      ),maxLines: 2,
      
    );
    bar = new AppBar(
      title:
        title,
      
      backgroundColor: Colors
          .transparent, //transparent backgroud to be able to have a different design for each screen
      leading: Navigator.canPop(context)
          ? backButton // make a back arrow if it is not the first screen of the app
          : null,
      actions: <Widget>[adsButton, guideButton],
    );

    this.bar = bar;
  }

  /* appbar getter
   * input :/
   * 
   * returns: instantiated appbar during this class constructor
   */
  AppBar getBar() => bar;
}

class EmptyAdScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      Navigator.pop(context);
    });

    return Scaffold(
      body: Container(),
    );
  }
}
