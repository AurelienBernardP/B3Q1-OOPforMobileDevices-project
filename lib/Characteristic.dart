import 'dart:core';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class Characteristic {
  int _hydratation;
  String _soilQuality;
  String _vulnerability;
  int _sunExposure;

  Characteristic (int hydra, String soil, String vul, int sun){
    this._hydratation = hydra;
    this._soilQuality = soil;
    this._vulnerability = vul;
    this._sunExposure = sun;

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

  Characteristic getInstance(){
    return this;
  }

}