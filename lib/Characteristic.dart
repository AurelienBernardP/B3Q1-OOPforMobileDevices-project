import 'dart:core';
import 'Characteristics/allCharacteristics.dart';
import 'package:flutter/widgets.dart';


abstract class Characteristic{
  int soilQuality;
  int vulnerability;
  int sunExposure;
  CharacteristicDisplay display;

  Widget buildCharacteristic(BuildContext context){
    return this.display.buildCharacteristicDisplay(context);
  }

  int getSoilQuality(){
    return this.soilQuality;
  }

  int getVulnerability(){
    return this.vulnerability;
  }

  String getName();
  int getSunExposure(){
    return this.sunExposure;
  }
}
