import 'dart:core';

/*
 * CharacteristicBackEnd class
 * Attributes:
 *    soilQuality: an integer representing the characteristic "SoilQuality" of a zone
 *    vulnerabilty: an integer representing the characteristic "vulnerabilty" of a zone
 *    sunExposure: an integer representing the characteristic "sunExposure" of a zone
 */
abstract class CharacteristicBackEnd {
  int soilQuality;
  int vulnerability;
  int sunExposure;

  int getSoilQuality() {
    return this.soilQuality;
  }

  int getVulnerability() {
    return this.vulnerability;
  }

  String getName();
  int getSunExposure() {
    return this.sunExposure;
  }
}
