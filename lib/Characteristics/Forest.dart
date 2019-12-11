import 'CharacteristicBackEnd.dart';

/*
 * Forest class
 * Attributes:
 *    has the same attributes as CharacteristicBackEnd class
 */
class Forest extends CharacteristicBackEnd {
  static final Forest _singleton = Forest._internal();

  factory Forest() {
    return _singleton;
  }

  //private constructor, initialising Forest for the first time
  Forest._internal() {
    this.soilQuality = 2;
    this.vulnerability = 0;
    this.sunExposure = 1;
  }

  /*Getter
   * input: /
   * output: the name of the zone Forest
   */
  String getName() {
    return "Forest";
  }
}
