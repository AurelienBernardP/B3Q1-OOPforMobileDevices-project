import '../Characteristic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class CharacteristicDisplay {
  Characteristic info;

  CharacteristicDisplay (Characteristic info){
    this.info = info;
  }

  Widget buildCharacteristicDisplay(BuildContext context){
    //Size
    Size size = MediaQuery.of(context).size;
    double width = (size.width - 10)/2;
    double height = size.height/20;

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
                ),),
            SizedBox(height:10),
             _soilQualityDetails(width, height),
            _vulnerabilityDetails(width, height),
            _sunExposureDetails(width, height),
        ],
    );
}

Row _soilQualityDetails(double width, double height){

  Text name = Text(
              "SoilQuality",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),);

  Text details = Text(
              this.info.getSoilQuality().toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.red,
              ),);
                    
  return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            name,
            details,
          ],);
}

Row _vulnerabilityDetails(double width, double height){
  double iconSize = 24.0;
  Text name = Text(
              "Vulnerability",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),);

  Text details = Text(
              this.info.getVulnerability().toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.red,
              ),);
                    
  return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            name,
            details,
          ],);
}

Row _sunExposureDetails(double width, double height){

  Text name = Text(
              "Sun Exposure",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),);

  Text details = Text(
              this.info.getSunExposure().toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.orange,
              ),);
                    
  return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            name,
            details,
          ],);
}
}



