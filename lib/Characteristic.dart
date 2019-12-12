import 'package:auto_size_text/auto_size_text.dart';

import 'Characteristics/CharacteristicBackEnd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/*
 * Characteristic class
 *    In charge of the display of the characteristics of a zone
 * 
 * Attributes:
 *    info : reference to the class containing data
 *           to be dispalyed
 */
class Characteristic {
  CharacteristicBackEnd info;

  Characteristic(CharacteristicBackEnd info) {
    this.info = info;
  }

  Widget buildCharacteristicDisplay(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = (size.width - 10) / 2;
    double height = size.height / 20;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(height: height / 30,),
        AutoSizeText(
          "Characteristics:",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
        SizedBox(height: height / 25, width: 1,),
        _soilQualityDetails(width, height),
        _vulnerabilityDetails(width, height),
        _sunExposureDetails(width, height),
        SizedBox(height: height / 30,),
      ],
    );
  }

  /*
   * input: 
   *    width: width of the box showing the state of "soil quality"
   *    height: height of the box showing the state of "soil quality"
   * 
   * output: 
   *    Container with the description of "soil quality"
   */
  Container _soilQualityDetails(double width, double height) {
    AutoSizeText name = AutoSizeText(
      "Soil Quality",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey[100],
      ),
    );

    int quality = this.info.getSoilQuality();
    String image = _getBarImage(quality);
    Container details = Container(
      width: width / 5,
      height: height / 3,
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/" + image),
          fit: BoxFit.fill,
        ),
      ),
    );
    return Container(
      margin: EdgeInsets.all(width / 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          name,
          details,
        ],
      ),
    );
  }

  /*
   * input: 
   *    width: width of the box showing the state of "vulnerability"
   *    height: height of the box showing the state of "vulnerability"
   * 
   * output: 
   *    Container with the description of "vulnerability"
   */
  Container _vulnerabilityDetails(double width, double height) {
    AutoSizeText name = AutoSizeText(
      "Vulnerability",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey[100],
      ),
    );

    int quality = this.info.getVulnerability();
    String image = _getBarImage(quality);
    Container details = Container(
      width: width / 5,
      height: height / 3,
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/" + image),
          fit: BoxFit.fill,
        ),
      ),
      child: Text(' '),
    );
    return Container(
      margin: EdgeInsets.all(width / 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          name,
          details,
        ],
      ),
    );
  }

  /*
   * input: 
   *    width: width of the box showing the state of "sun exposure"
   *    height: height of the box showing the state of "sun exposure"
   * 
   * output: 
   *    Container with the description of "sun exposure"
   */
  Container _sunExposureDetails(double width, double height) {
    AutoSizeText name = AutoSizeText(
      "Sun Exposure",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey[100],
      ),
    );

    int quality = this.info.getSunExposure();
    String image = _getBarImage(quality);
    Container details = Container(
      width: width / 5,
      height: height / 3,
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/" + image),
          fit: BoxFit.fill,
        ),
      ),
    );

    return Container(
      margin: EdgeInsets.all(width / 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          name,
          details,
        ],
      ),
    );
  }

  /*
   * input: 
   *    quality: an integer representing the quality of a characteristic
   * 
   * output: 
   *    a string which is the name of the image representing the state
   */
  _getBarImage(int quality) {
    switch (quality) {
      case 0:
        return "high.png";
      case 1:
        return "medium.png";
      case 2:
        return "low.png";
    }
  }
}
