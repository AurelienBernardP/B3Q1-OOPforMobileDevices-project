import 'CharacteristicBackEnd.dart';

/*
 * Snowy class
 * Attributes:
 *    has the same attributes as CharacteristicBackEnd class
 */
class Snowy extends CharacteristicBackEnd{
  static final Snowy _singleton = Snowy._internal();

  factory Snowy(){
    return _singleton;
  }

  //private constructor, initialising Snowy for the first time
  Snowy._internal(){
    this.soilQuality = 1;
    this.vulnerability = 2;
    this.sunExposure = 0;
  }

  /*Getter
   * input: /
   * output: the name of the zone Snowy
   */
  String getName(){
    return "Snowy";
  }


}
