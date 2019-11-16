import 'dart:core';
import 'package:flutter/material.dart';
import 'AdTreesAppTopBar.dart';
import 'package:flutter/cupertino.dart';
import 'Characteristic.dart';


class Health extends StatelessWidget{
  HealthBackEnd _healthInfo;

  Health(){
    this._healthInfo = HealthBackEnd();
  }

  @override
  Widget build(BuildContext context){
    return buildAllHealth(context);
  }


  bool hydrateTree(int nbDrop){
    return this._healthInfo.hydrateTree(nbDrop);
  }

  void dehydrateTree(int nbDrop){
    this._healthInfo.dehydrateTree(nbDrop);
  }

  bool nurishTree(int nutrition){
    return this._healthInfo.nurishTree(nutrition);
  }

  void denurishTree(int nutrition){
    this._healthInfo.denurishTree(nutrition)
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

      return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                Container(child: _overallHealth(width, height)),
          ],),
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
                        width: (this._healthInfo.hydratation * width)/this._healthInfo.hydratationMax,
                      ),
                      Center(
                        child: Text(
                          ((this._healthInfo.hydratation*100)/this._healthInfo.hydratationMax).toStringAsFixed(2)+"%",
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
                        width: (this._healthInfo.nutrition * width)/this._healthInfo.nutritionMax,
                      ),
                      Center(
                        child: Text(
                          ((this._healthInfo.nutrition*100)/this._healthInfo.nutritionMax).toStringAsFixed(2)+"%",
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
    double overall = this._healthInfo.hydratation * this._healthInfo.nutritionMax * this._healthInfo.damageMax;
    overall += this._healthInfo.nutrition * this._healthInfo.hydratationMax * this._healthInfo.damageMax;
    overall += this._healthInfo.damage * this._healthInfo.nutritionMax * this._healthInfo.hydratationMax;

    overall /= 3;
    double overallMax = this._healthInfo.nutritionMax * this._healthInfo.hydratationMax * this._healthInfo.damageMax;

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
                          ((overall*100)/overallMax).toStringAsFixed(2)+"%",
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

}

class HealthBackEnd {
  double hydratationMax = 100;
  double nutritionMax = 100;
  double damageMax = 100;

  int hydratation;
  int nutrition;
  int damage;

  HealthBackEnd(){
    this.hydratation = 67;
    this.nutrition = 98;
    this.damage = 1;
  }


  bool hydrateTree(int nbDrop){
    if (this.hydratation >= 100)
      return false;
    
    this.hydratation  += nbDrop;
    if(this.hydratation > 100)
      this.hydratation = 100;
    
    return true;
  }

  void dehydrateTree(int nbDrop){
    if(this.hydratation <= 0)
      return;
    
    this.hydratation  -= nbDrop;
    if(this.hydratation < 0)
      this.hydratation = 0;
  }

  bool nurishTree(int _nutrition){
    if (this.nutrition >= 100)
      return false;
    
    this.nutrition  += _nutrition;
    if(this.nutrition > 100)
      this.nutrition = 100;
    
    return true;
  }

  void denurishTree(int _nutrition){
    if(this.nutrition <= 0)
      return;
    
    this.nutrition  -= _nutrition;
    if(this.nutrition < 0)
      this.nutrition = 0;
  }




}