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


/* Getter
 * input: /
 * 
 * output: an integer corresponding to the characteristic "soil quality"
 */
  int getSoilQuality() {
    return this.soilQuality;
  }

/* Getter
 * input: /
 * 
 * output: an integer corresponding to the characteristic "vulnerability"
 */
  int getVulnerability() {
    return this.vulnerability;
  }

/* Getter
 * input: /
 * 
 * output: an integer corresponding to the characteristic "soil quality"
 */
  String getName();

/* Getter
 * input: /
 * 
 * output: an integer corresponding to the characteristic "sun exposure"
 */
  int getSunExposure() {
    return this.sunExposure;
  }
}
