import 'CharacteristicBackEnd.dart';

/*
 * Path class
 * Attributes:
 *    has the same attributes as CharacteristicBackEnd class
 */
class Path extends CharacteristicBackEnd {
  static final Path _singleton = Path._internal();

  factory Path() {
    return _singleton;
  }

  //private constructor, initialising Path for the first time
  Path._internal() {
    this.soilQuality = 0;
    this.vulnerability = 2;
    this.sunExposure = 2;
  }

  /*Getter
   * input: /
   * output: the name of the zone Path
   */
  String getName() {
    return "Path";
  }
}
