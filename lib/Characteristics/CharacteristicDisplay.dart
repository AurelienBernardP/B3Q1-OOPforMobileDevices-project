import '../Characteristic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CharacteristicDisplay {
  Characteristic info;

  CharacteristicDisplay(Characteristic info) {
    this.info = info;
  }

  Widget buildCharacteristicDisplay(BuildContext context) {
    //Size
    Size size = MediaQuery.of(context).size;
    double width = (size.width - 10) / 2;
    double height = size.height / 20;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Characteristics:",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.yellow,
          ),
        ),
        SizedBox(height: 10),
        _soilQualityDetails(width, height),
        _vulnerabilityDetails(width, height),
        _sunExposureDetails(width, height),
      ],
    );
  }

  Row _soilQualityDetails(double width, double height) {
    Text name = Text(
      "Soil Quality",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
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
    return Row(
      children: <Widget>[
        SizedBox(width: 7),
        name,
        Spacer(),
        details,
        SizedBox(width: 7),
      ],
    );
  }

  Row _vulnerabilityDetails(double width, double height) {
    double iconSize = 24.0;
    Text name = Text(
      "Vulnerability",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
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
    return Row(
      children: <Widget>[
        SizedBox(width: 7),
        name,
        Spacer(),
        details,
        SizedBox(width: 7),
      ],
    );
  }

  Row _sunExposureDetails(double width, double height) {
    Text name = Text(
      "Sun Exposure",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
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

    return Row(
      children: <Widget>[
        SizedBox(width: 7),
        name,
        Spacer(),
        details,
        SizedBox(width: 7),
      ],
    );
  }

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
