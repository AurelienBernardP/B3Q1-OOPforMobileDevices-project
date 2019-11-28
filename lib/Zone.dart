import 'Characteristic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'TreeScreen.dart';
import 'Item.dart';

class Zone{

  Characteristic type;
  TreeScreen plantedTreeScreen;
  Item plantedTree;
  bool locked;

  Zone(Characteristic type, {bool isLocked}){
    this.type = type;
    if(isLocked==null)
      locked = true;
    else
      locked = isLocked;
  }

  bool isLocked(){
    return locked;
  }

  Item getPlantedTree(){
    return plantedTree;
  }

  void unlock(){
    locked = false;
  }

  bool isPlanted(){
    if (plantedTree != null)
      return true;
    return false;
  }

  void viewTree(){
    if(!locked)
      plantedTreeScreen = TreeScreen();
  }

  void plantTree(Item treeType, {String name, TreeBackEnd treeInfo}){
    plantedTree = treeType;
    if(treeInfo == null)
      plantedTreeScreen = TreeScreen(zone:this,treeType:treeType, name: name);
    else
      plantedTreeScreen = TreeScreen(tree: treeInfo);

  }

  void removeTree(){
    plantedTree = null;
  }

  Widget buildZone(BuildContext context){
    return this.type.buildCharacteristic(context);
  }

  Widget getTreeScreenWidget(){
    return plantedTreeScreen;
  }

  TreeBackEnd getTreeScreen(){
    return plantedTreeScreen.getTreeInfo();
  }
  
  String getZoneType(){
    return this.type.getName();
  }

  String getTreeType(){
    return this.plantedTree.getName();
  }
}