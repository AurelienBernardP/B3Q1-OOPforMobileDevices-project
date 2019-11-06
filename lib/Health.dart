import 'dart:core';
import 'package:flutter/material.dart';
import 'AdTreesAppTopBar.dart';
import 'package:flutter/cupertino.dart';
import 'Characteristic.dart';







class Health extends StatelessWidget{
  static double _hydratationMax = 100;
  static double _nutritionMax = 100;
  static double _damageMax = 100;

  int _hydratation;
  int _nutrition;
  int _damage;

  @override
  Widget build(BuildContext context){
    return buildAllHealth(context);
  }

  Health(){
    this._hydratation = 67;
    this._nutrition = 98;
    this._damage = 0;
  }


  //Can use MainAxisAlignment strecht pour étendre
  Widget buildAllHealth(BuildContext context){
      //Size
      Size size = MediaQuery.of(context).size;
      double width = (size.width - 10)/2;
      double height = size.height/20;

      return 
        Scaffold(
          appBar: AdTreesAppTopBar("Health bar", context).getBar(),
          body:
            Center(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    _hydratationHealth(width, height),
                    _nutritionHealth(width, height),
                    _damageHealth(width, height),
                    _overallHealth(width, height),
              ],),
            )
          ));

    }

  Widget buildGeneralHealth(BuildContext context){
      //Size
      Size size = MediaQuery.of(context).size;
      double width = (size.width - 10)/2;
      double height = size.height/20;

      return Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                Container(child: _overallHealth(width, height)),
          ],),
        )
      );
    }


  Row _hydratationHealth(double width, double height){
    Text text = Text(
                "Hydratation",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),);

    Stack health = Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.red,
                        height: height,
                        width: width
                      ),
                      Container(
                        color: Colors.blue,
                        height: height,
                        width: (this._hydratation * width)/_hydratationMax,
                      ),
                      Center(
                        child: Text(
                          ((this._hydratation*100)/_hydratationMax).toString()+"%",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                      ))),]);

    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child : text),
              Expanded(child : health),
            ],);
  }

  Row _nutritionHealth(double width, double height){
    Text text = Text(
                "Nutrition",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.orange,
                ),);

    Stack health = Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.red,
                        height: height,
                        width: width
                      ),
                      Container(
                        color: Colors.blue,
                        height: height,
                        width: (this._nutrition * width)/_nutritionMax,
                      ),
                      Center(
                        child: Text(
                          ((this._nutrition*100)/_nutritionMax).toString()+"%",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                      ))),]);

    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child : text),
              Expanded(child : health),
            ],);
  }

  Row _overallHealth(double width, double height){
    double overall = this._hydratation * _nutritionMax * _damageMax;
    overall += this._nutrition * _hydratationMax * _damageMax;
    overall += this._damage * _nutritionMax * _hydratationMax;

    overall /= 3;
    double overallMax = _nutritionMax * _hydratationMax * _damageMax;

    Text text = Text(
                "Overall",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue,
                ),);

    Stack health = Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.red,
                        height: height,
                        width: width
                      ),
                      Container(
                        color: Colors.green,
                        height: height,
                        width: (overall * width)/overallMax,
                      ),
                      Center(
                        child: Text(
                          ((overall*100)/overallMax).toString()+"%",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                      ))),]);

    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child : text),
              Expanded(child : health),
            ],);
  }

  Row _damageHealth(double width, double height){

    double iconSize = 24.0;

    Text text = Text(
                "Damage",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.red,
                ),);

    Stack health = Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.black,
                        height: height,
                        width: width
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.build,
                              color: Colors.green,
                              size: iconSize,
                            ),
                            Icon(
                              Icons.bug_report,
                              color: Colors.red,
                              size: iconSize,
                            ),
                            Icon(
                              Icons.device_hub,
                              color: Colors.green,
                              size: iconSize,
                            ),
                            Icon(
                              Icons.flash_on,
                              color: Colors.green,
                              size: iconSize,
                            ),],),),
                          ],);
                      
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child : text),
              Expanded(child : health),
            ],);
  }



  bool hydrateTree(int nbDrop){
    if (this._hydratation >= 100)
      return false;
    
    this._hydratation  += nbDrop;
    if(this._hydratation > 100)
      this._hydratation = 100;
    
    return true;
  }

  void dehydrateTree(int nbDrop){
    if(this._hydratation <= 0)
      return;
    
    this._hydratation  -= nbDrop;
    if(this._hydratation < 0)
      this._hydratation = 0;
  }


  bool nurishTree(int _nutrition){
    if (this._nutrition >= 100)
      return false;
    
    this._nutrition  += _nutrition;
    if(this._nutrition > 100)
      this._nutrition = 100;
    
    return true;
  }

  void denurishTree(int _nutrition){
    if(this._nutrition <= 0)
      return;
    
    this._nutrition  -= _nutrition;
    if(this._nutrition < 0)
      this._nutrition = 0;
  }




}