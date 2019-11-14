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

    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child : _soilQualityDetails(width, height),
            ),
            Container(
          
              child : _vulnerabilityDetails(width, height),
            ),
            Container(
              child : _sunExposureDetails(width, height),
            )
        ],),
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
            Flexible(child : name),
            Flexible(child : details),
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
            Flexible(child : name),
            Flexible(child : details),
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
            Flexible(child : name),
            Flexible(child : details),
          ],);
}
}



