import 'Characteristic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'TreeScreen.dart';
import 'Item.dart';
import 'TreeBackEnd.dart';

/*
 * Zone class
 * Attributes:
 *    type: a Characteristic representing the characteristics of the zone
 *    plantedTreeScreen: a TreeScreen that corresponds to the zone
 *    plantedTree: an Item that is planted
 *    locked: a boolean used in order to determine whether a zone is locked or not
 */

class Zone{

  Characteristic type;
  TreeScreen plantedTreeScreen;
  Item plantedTree;
  bool locked;

  /*
   * input: type, a Characteristic
   *        isLocked, a boolean 
   * output: a new zone
   */
  Zone(Characteristic type, {bool isLocked}){
    this.type = type;
    if(isLocked==null)
      locked = true;
    else
      locked = isLocked;
  }

  /*
   * input: /
   * output: locked, a boolean used in order to determine whether a zone is locked or not
   */
  bool isLocked(){
    return locked;
  }

  /*
   * input: /
   * output: plantedTree, an Item that is planted
   */
  Item getPlantedTree(){
    return plantedTree;
  }

  /*
   * input: /
   * effect: sets the locked attribute to false
   */
  void unlock(){
    locked = false;
  }

  /*
   * input: /
   * output: returns true if a tree has already been planted in this zone
   *         returns false otherwise
   */
  bool isPlanted(){
    if (plantedTree != null)
      return true;
    return false;
  }


  /*
   * input: treeType, an Item that is the type of tree that will be planted in the zone
   *        name, a string that is the tree's name
   *        treeInfo, the information associated with the tree 
   *          (used in case the tree was already planted and we are loading the data)
   * effect: display
   */
  void plantTree(Item treeType, {String name, TreeBackEnd treeInfo}){
    plantedTree = treeType;
    if(treeInfo == null)
      plantedTreeScreen = TreeScreen(zone:this,treeType:treeType, name: name);
    else
      plantedTreeScreen = TreeScreen(tree: treeInfo);

  }

  /*
   * input: context, BuildContext
   * output: a widget containing the characteristics of the zone
   */
  Widget buildZone(BuildContext context){
    return this.type.buildCharacteristic(context);
  }

  /*
   * input: /
   * output: a widget that is the screen of the tree planted in the zone
   */
  Widget getTreeScreenWidget(){
    return plantedTreeScreen;
  }

  /*
   * input: /
   * output: a TreeBackEnd, the information about the tree planted in the zone
   */
  TreeBackEnd getTreeScreen(){
    return plantedTreeScreen.getTreeInfo();
  }
  
  /*
   * input: /
   * output: a string that is the name of the zone type
   */
  String getZoneType(){
    return this.type.getName();
  }

  /*
   * input: /
   * output: a string that is the name of the planted tree in the zone
   */
  String getTreeType(){
    return this.plantedTree.getName();
  }
}