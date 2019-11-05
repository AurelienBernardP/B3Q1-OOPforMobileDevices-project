import 'dart:core';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

abstract class Characteristic {
  int _hydratation;
  String _soilQuality;
  String _vulnerability;
  int _sunExposure;

  int getHydratation(){
    return this._hydratation;
  }

  String getSoilQuality(){
    return this._soilQuality;
  }

  String getVulnerability(){
    return this._vulnerability;
  }

  int getSunExposure(){
    return this._sunExposure;
  }

    Widget buildCharacteristic(BuildContext context){
      //Size
      Size size = MediaQuery.of(context).size;
      double width = (size.width - 10)/2;
      double height = size.height/20;

      return Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                _hydratationDetails(width, height),
                SizedBox(height: height/2,),
                _soilQualityDetails(width, height),
                SizedBox(height: height/2,),
                _vulnerabilityDetails(width, height),
                SizedBox(height: height/2,),
                _sunExposureDetails(width, height),

          ],),
        )
      );
  }

  
  Row _hydratationDetails(double width, double height){

    Text name = Text(
                "Hydratation",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),);

    Text details = Text(
                this._hydratation.toString(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue,
                ),);
                      
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child : name),
              Expanded(child : details),
            ],);
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
                this._soilQuality.toString(),
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
              Expanded(child : name),
              Expanded(child : details),
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
                this._vulnerability.toString(),
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
              Expanded(child : name),
              Expanded(child : details),
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
                this._sunExposure.toString(),
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
              Expanded(child : name),
              Expanded(child : details),
            ],);
  }


}

class Desert extends Characteristic{
  static final Desert _singleton = Desert._internal();

  factory Desert(){
    return _singleton;
  }

  Desert._internal(){
    this._hydratation = 15;
    this._soilQuality = "Very low";
    this._vulnerability = "Low";
    this._sunExposure = 100;
  }



}

class Forest extends Characteristic{
  static final Forest _singleton = Forest._internal();
  
    factory Forest(){
      return _singleton;
    }
  
    Forest._internal(){
      this._hydratation = 80;
      this._soilQuality = "High";
      this._vulnerability = "Low";
      this._sunExposure = 60;
    }
  
  }


class Plains extends Characteristic{
  static final Plains _singleton = Plains._internal();

  factory Plains(){
    return _singleton;
  }

  Plains._internal(){
    this._hydratation = 90;
    this._soilQuality = "Normal";
    this._vulnerability = "High";
    this._sunExposure = 70;
  }



}

class Jungle extends Characteristic{
  static final Jungle _singleton = Jungle._internal();

  factory Jungle(){
    return _singleton;
  }

  Jungle._internal(){
    this._hydratation = 90;
    this._soilQuality = "Very high";
    this._vulnerability = "Normal";
    this._sunExposure = 70;
  }
}


class Savanna extends Characteristic{
  static final Savanna _singleton = Savanna._internal();

  factory Savanna(){
    return _singleton;
  }

  Savanna._internal(){
    this._hydratation = 30;
    this._soilQuality = "Low";
    this._vulnerability = "Normal";
    this._sunExposure = 80;
  }



}
