import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Save.dart';

class Health extends StatelessWidget{
  HealthBackEnd _healthInfo;

  Health({double hydratation, double nutrition, bool isPolluted, int nbPollutions}){
    this._healthInfo = HealthBackEnd(hydratation: hydratation,
                                     nutrition: nutrition,
                                     isPolluted: isPolluted,
                                     nbPollutions: nbPollutions);

  }

  @override
  Widget build(BuildContext context){
    return buildAllHealth(context);
  }

  double getHydratation(){
    return _healthInfo.hydratation;
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
                    _hydratationHealth(widthBox, heightBox),
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

  Widget _overallHealth(double width, double height){
    double overall = this._healthInfo.getOverall();
    double overallMax = this._healthInfo.nutritionMax * this._healthInfo.hydratationMax;

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
  double hydratationMax = 10;
  double nutritionMax = 1000;

  double hydratation;
  double nutrition;
  bool isPolluted;
  int nbPollutions;

  HealthBackEnd({double hydratation, double nutrition, bool isPolluted, int nbPollutions}){
    if(hydratation == null)
      this.hydratation = 10;
    else
      this.hydratation = hydratation;
    
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

    double overall =  hydratation *  nutritionMax;
    overall +=  nutrition *  hydratationMax;
    if(isPolluted)
      overall +=  0 *  nutritionMax * hydratationMax;
    else
      overall +=  nutritionMax * hydratationMax;
      
    overall /= 3;
    double overallMax = nutritionMax * hydratationMax;

    return (overall * 100)/overallMax;
  }

  bool hydrateTree(double nbDrop){
    if (this.hydratation >= hydratationMax)
      return false;
    
    this.hydratation  += nbDrop;
    if(this.hydratation > hydratationMax)
      this.hydratation = hydratationMax;
    
    return true;
  }

  void dehydrateTree(double nbDrop){
    if(this.hydratation <= 0)
      return;
    
    this.hydratation  -= nbDrop;
    if(this.hydratation < 0)
      this.hydratation = 0;
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