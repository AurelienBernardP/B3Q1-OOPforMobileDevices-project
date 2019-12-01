import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Save.dart';

class Health extends StatelessWidget{
  HealthBackEnd _healthInfo;

  Health({double hydration, double nutrition, bool isPolluted, int nbPollutions}){
    this._healthInfo = HealthBackEnd(hydration: hydration,
                                     nutrition: nutrition,
                                     isPolluted: isPolluted,
                                     nbPollutions: nbPollutions);

  }

  @override
  Widget build(BuildContext context){
    return buildAllHealth(context);
  }

  double gethydration(){
    return _healthInfo.hydration;
  }

  double getNutrition(){
    return _healthInfo.nutrition;
  }

  bool isPolluted(){
    return _healthInfo.isPolluted;
  }

  double getOverall(){
    return _healthInfo.getOverall();
  }

  int getNbPollutions(){
    return this._healthInfo.nbPollutions;
  }


  bool hydrateTree(double nbDrop){
    bool result = this._healthInfo.hydrateTree(nbDrop);
    Save().saveGame();
    return result;
  }

  void dehydrateTree(double nbDrop){
    this._healthInfo.dehydrateTree(nbDrop);
  }

  bool nurishTree(double nutrition){
    bool result = this._healthInfo.nurishTree(nutrition);
    Save().saveGame();
    return result;
  }

  void denurishTree(double nutrition){
    this._healthInfo.denurishTree(nutrition);
  }

  bool cleanTree(){
    bool cleanTree = _healthInfo.cleanTree();
    Save().saveGame();
    return cleanTree;
  }

  void polluteTree(){
    this._healthInfo.polluteTree();
  }

  Widget buildAllHealth(BuildContext context){
      //Size
      Size size = MediaQuery.of(context).size;
      double widthBox = (size.width - 10)/2;
      double heightBox = size.height/20;

      return AlertDialog(
        title: Text(
                "Health Bars",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),),
        content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    _hydrationHealth(widthBox, heightBox),
                    SizedBox(height: heightBox,),
                    _nutritionHealth(widthBox, heightBox),
                    SizedBox(height: heightBox,),
                    _pollutionHealth(widthBox, heightBox),
              ],),
          ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
      ),
      );

            ;

    }

  Widget buildGeneralHealth(BuildContext context){
      //Size
      Size size = MediaQuery.of(context).size;
      double width = size.width - 10;
      double height = size.height/15;

      return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                Container(child: _overallHealth(width, height)),
          ],),
        );
    }


  Row _hydrationHealth(double width, double height){
    Text text = Text(
                "hydration",
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
                        width: (this._healthInfo.hydration * width)/this._healthInfo.hydrationMax,
                      ),
                      Center(
                        child: Text(
                          ((this._healthInfo.hydration*100)/this._healthInfo.hydrationMax).toStringAsFixed(2)+"%",
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

  Widget _overallHealth(double width, double height){
    double overall = this._healthInfo.getOverall();
    double overallMax = this._healthInfo.nutritionMax * this._healthInfo.hydrationMax;

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
                        width: (overall * 100 * width)/overallMax,
                      ),
                      Center(
                        child: Text(
                          overall.toStringAsFixed(2)+"%",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blueGrey[100],
                      ))),]);

    return Expanded(child : health);
  }

  Row _pollutionHealth(double width, double height){
    Text text = Text(
                "Pollution",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.red,
                ),);

    String nameImagePollution;
    if(_healthInfo.isPolluted)
      nameImagePollution = "skull";
    else
      nameImagePollution = "star";
    Image health = Image.asset(
                      "assets/images/"+nameImagePollution+".png",
                      fit: BoxFit.contain,
                      height: height,
                      width: height,
                    );

    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child : text),
              Expanded(child : health),
            ],);
  }

}

class HealthBackEnd {
  double hydrationMax = 10;
  double nutritionMax = 1000;

  double hydration;
  double nutrition;
  bool isPolluted;
  int nbPollutions;

  HealthBackEnd({double hydration, double nutrition, bool isPolluted, int nbPollutions}){
    if(hydration == null)
      this.hydration = 10;
    else
      this.hydration = hydration;
    
    if(nutrition == null)
      this.nutrition = 1000;
    else
      this.nutrition = nutrition;

    if(isPolluted == null)
      this.isPolluted = false;
    else
      this.isPolluted = isPolluted;

    if(nbPollutions == null)
      this.nbPollutions = 0;
    else
      this.nbPollutions = nbPollutions;
  }


  double getOverall(){

    double overall =  hydration *  nutritionMax;
    overall +=  nutrition *  hydrationMax;
    if(isPolluted)
      overall +=  0 *  nutritionMax * hydrationMax;
    else
      overall +=  nutritionMax * hydrationMax;
      
    overall /= 3;
    double overallMax = nutritionMax * hydrationMax;

    return (overall * 100)/overallMax;
  }

  bool hydrateTree(double nbDrop){
    if (this.hydration >= hydrationMax)
      return false;
    
    this.hydration  += nbDrop;
    if(this.hydration > hydrationMax)
      this.hydration = hydrationMax;
    
    return true;
  }

  void dehydrateTree(double nbDrop){
    if(this.hydration <= 0)
      return;
    
    this.hydration  -= nbDrop;
    if(this.hydration < 0)
      this.hydration = 0;
  }

  bool nurishTree(double nutrition){
    if (this.nutrition >= nutritionMax)
      return false;
    
    this.nutrition  += nutrition;
    if(this.nutrition > nutritionMax)
      this.nutrition = nutritionMax;
    
    return true;
  }

  void denurishTree(double nutrition){
    if(this.nutrition <= 0)
      return;
    
    this.nutrition  -= nutrition;
    if(this.nutrition < 0)
      this.nutrition = 0;
  }

  void polluteTree(){
      this.isPolluted = true;
      nbPollutions += 1;
    }

  bool cleanTree(){
    if(isPolluted){
      this.isPolluted = false;
      nbPollutions = 0;
      return true;
    }
    return false;
    }



}