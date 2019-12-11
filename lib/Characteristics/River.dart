import 'CharacteristicBackEnd.dart';
/*
 * River class
 * Attributes:
 *    has the same attributes as CharacteristicBackEnd class
 */
class River extends CharacteristicBackEnd {
  static final River _singleton = River._internal();

  factory River() {
    return _singleton;
  }

  //private constructor, initialising River for the first time
  River._internal() {
    this.soilQuality = 1;
    this.vulnerability = 0;
    this.sunExposure = 0;
  }

  /*Getter
   * input: /
   * output: the name of the zone River
   */
  String getName() {
    return "River";
  }
}
