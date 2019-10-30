
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Zone{

  //Characteristic type = null;
  int plantedTree = 0;
  bool locked = true;

  //Zone(this.type);

  bool is_locked(){
    return locked;
  }

  void unlock(){
    locked = false;
  }

  bool is_planted(){
    if (plantedTree != 0)
      return true;
    return false;
  }

  /*void plant_tree(Tree tree){
    if(!is_locked)
      plantedTree = tree;
  }*/

  /*void remove_tree(){
    plantedTree = null;
  }*/

  /*Characteristic get_zone_type(){
    return type;
  }*/
  
}