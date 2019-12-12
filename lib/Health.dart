import 'dart:core';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'HealthBackEnd.dart';

/*
 * Health class
 * Attributes:
 *    healthInfo : reference to the class containing data about the health 
 *                 of a tree to be dispalyed
 */

class Health extends StatelessWidget {
  HealthBackEnd _healthInfo;

  Health({double hydration, double nutrition, bool isPolluted, int nbPollutions}) {
    this._healthInfo = HealthBackEnd(
        hydration: hydration,
        nutrition: nutrition,
        isPolluted: isPolluted,
        nbPollutions: nbPollutions);
  }

  Widget build(BuildContext context) {
    return buildAllHealth(context);
  }

  /*Getter
  * input:/
  *
  * output: the "hydration" of the referenced health
  */
  double getHydration() {
    return _healthInfo.hydration;
  }

  /*Getter
  * input:/
  *
  * output: the "nutrition" of the referenced health
  */
  double getNutrition() {
    return _healthInfo.nutrition;
  }

  /*Getter
  * input:/
  *
  * output: indicator of the pollution of the referenced health
  */
  bool isPolluted() {
    return _healthInfo.isPolluted;
  }

  /*Getter
  * input:/
  *
  * output: the overall state of the referenced health
  */
  double getOverall() {
    return _healthInfo.getOverall();
  }

  /*Getter
  * input:/
  *
  * output: the number of pollutions of the referenced health
  */
  int getNbPollutions() {
    return this._healthInfo.nbPollutions;
  }

  /*hydrateTree
   * input:
   *    nbDrop: a certain amount of provision to the need "hydration" of the referenced health
   * 
   * output:
   *    true: the provision for "hydration" was needed and has been applied
   *    false: the provision for "hydration" is not needed
   */
  bool hydrateTree(double nbDrop) {
    bool result = this._healthInfo.hydrateTree(nbDrop);
    return result;
  }

  /*dehydrateTree
   * input:
   *    nbDrop: an increase to the need "hydration" of the referenced health
   * 
   * effect: increasing the need "hydration" of the referenced health
   */
  void dehydrateTree(double nbDrop) {
    this._healthInfo.dehydrateTree(nbDrop);
  }

  /* nurishTree
   * input:
   *    nutrition: Determinates a certain amount of provision to the need "nutrition" of thereferenced health
   * 
   * output:: 
   *    true: the provision "nutrition" was needed and has been applied
   *    false: the provision "nutrition" is not needed
   */
  bool nurishTree(double nutrition) {
    bool result = this._healthInfo.nurishTree(nutrition);
    return result;
  }

  /* denurishTree
   * input:
   *    nutrition: Determinates an certain additional need to "nutrition" of the referenced health
   * 
   * effect: increasing the need "nutrition" of the referenced health
   */
  void denurishTree(double nutrition) {
    this._healthInfo.denurishTree(nutrition);
  }

  /*cleanTree
   * input: /
   * 
   * output: 
   *    true: the tree is cleaned
   *    false: the tree is already cleaned
   */
  bool cleanTree() {
    bool cleanTree = _healthInfo.cleanTree();
    return cleanTree;
  }

  /* polluteTree
   * input: /
   * 
   * effect: increasing the number of pollution of the referenced health
   */
  void polluteTree() {
    this._healthInfo.polluteTree();
  }

  /* buildAllHealth
   * input: context
   * 
   * output: a popup containing the description of the referenced health
   */
  Widget buildAllHealth(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double widthBox = (size.width - 10) / 2;
    double heightBox = size.height / 20;

    return AlertDialog(
      title: Text(
        "Health Bars",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _hydrationHealth(widthBox, heightBox),
            SizedBox(
              height: heightBox,
            ),
            _nutritionHealth(widthBox, heightBox),
            SizedBox(
              height: heightBox,
            ),
            _pollutionHealth(widthBox, heightBox),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );

    ;
  }

  /* buildGeneralHealth
   * input: context
   * 
   * output: a container representing the overall state of the health
   */
  Widget buildGeneralHealth(BuildContext context) {
    //Size
    Size size = MediaQuery.of(context).size;
    double width = size.width - 10;
    double height = size.height / 15;

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(child: _overallHealth(width, height)),
        ],
      ),
    );
  }

  /* _hydrationHealth
   * input: width, height
   * 
   * output: description of the need hydration of the referenced health
   */
  Row _hydrationHealth(double width, double height) {
    Text text = Text(
      "Hydration",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.blueGrey,
      ),
    );

    Stack health = Stack(children: <Widget>[
      Container(color: Colors.red, height: height, width: width),
      Container(
        color: Colors.blue,
        height: height,
        width: (this._healthInfo.hydration * width) /
            this._healthInfo.hydrationMax,
      ),
      Center(
          child: Text(
              ((this._healthInfo.hydration * 100) /
                          this._healthInfo.hydrationMax) .toStringAsFixed(2) +"%",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ))),
    ]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(child: text),
        Expanded(child: health),
      ],
    );
  }

  /* _nutritionHealth
   * input: width, height
   * 
   * output: description of the need nutrition of the referenced health
   */
  Row _nutritionHealth(double width, double height) {
    Text text = Text(
      "Nutrition",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.orange,
      ),
    );

    Stack health = Stack(children: <Widget>[
      Container(color: Colors.red, height: height, width: width),
      Container(
        color: Colors.blue,
        height: height,
        width: (this._healthInfo.nutrition * width) /
            this._healthInfo.nutritionMax,
      ),
      Center(
          child: Text(
              ((this._healthInfo.nutrition * 100) /
                          this._healthInfo.nutritionMax)
                      .toStringAsFixed(2) +
                  "%",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ))),
    ]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(child: text),
        Expanded(child: health),
      ],
    );
  }

  /* overallHealth
   * input: context
   * 
   * output: description of the overall state of the health
   */
  Widget _overallHealth(double width, double height) {
    double overall = this._healthInfo.getOverall();
    double overallMax =
        this._healthInfo.nutritionMax * this._healthInfo.hydrationMax;

    Stack health = Stack(children: <Widget>[
      Container(color: Colors.red, height: height, width: width),
      Container(
        color: Colors.green,
        height: height,
        width: (((overall * 100 * width) / overallMax) > 0.0)
            ? (overall * 100 * width) / overallMax
            : 0.0,
      ),
      Center(
          child: Text(overall.toStringAsFixed(2) + "%",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blueGrey[100],
              ))),
    ]);

    return Expanded(child: health);
  }

  /* _pollutionHealth
   * input: width, height
   * 
   * output: description of the need pollution of the referenced health
   */
  Row _pollutionHealth(double width, double height) {
    Text text = Text(
      "Pollution [" + _healthInfo.nbPollutions.toString() + "]",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.red,
      ),
    );

    String nameImagePollution;
    if (_healthInfo.isPolluted)
      nameImagePollution = "skull";
    else
      nameImagePollution = "star";
    Image health = Image.asset(
      "assets/images/" + nameImagePollution + ".png",
      fit: BoxFit.contain,
      height: height,
      width: height,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(child: text),
        Expanded(child: health),
      ],
    );
  }
}
