import 'Characteristic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'TreeScreen.dart';

class Zone{

  Characteristic type;
  TreeScreen plantedTree;
  bool locked = true;

  Zone(Characteristic type){
    this.type = type;
  }

  bool is_locked(){
    return locked;
  }

  void unlock(){
    locked = false;
  }

  bool is_planted(){
    if (plantedTree != null)
      return true;
    return false;
  }

  void plantTree(){
    if(!locked)
      plantedTree = TreeScreen();
  }

  /*void remove_tree(){
    plantedTree = null;
  }*/

  Widget buildZone(BuildContext context){
    return this.type.buildCharacteristic(context);
  }

  Widget getTree(){
    return plantedTree;
  }
  
  String get_zone_type(){
    return this.type.getName();
  }
  
}