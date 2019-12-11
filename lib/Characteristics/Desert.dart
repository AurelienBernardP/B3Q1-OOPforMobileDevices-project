import 'CharacteristicBackEnd.dart';

/*
 * Desert class
 * Attributes:
 *    has the same attributes as CharacteristicBackEnd class
 */
class Desert extends CharacteristicBackEnd {
  static final Desert _singleton = Desert._internal();

  factory Desert() {
    return _singleton;
  }

  //private constructor, initialising Desert for the first time
  Desert._internal() {
    this.soilQuality = 0;
    this.vulnerability = 0;
    this.sunExposure = 2;
  }

  /*Getter
   * input: /
   * output: the name of the zone Desert
   */
  String getName() {
    return "Desert";
  }
}
