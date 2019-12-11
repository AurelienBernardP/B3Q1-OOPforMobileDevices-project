import 'Save.dart';

/*   
 * HealthBackEnd class
 * Attributes:
 *    hydration, nutrition: real numbers representing the different needs of a tree
 *    hydrationMax, nutritionMax : real numbers representing the limit of the needs of a tree
 *    isPolluted: a boolean indicating if the tree is polluted or not
 *    nbPollutions: an integer that represents the number of pollutions in the tree
 * 
 */

class HealthBackEnd {
  double hydration;
  double nutrition;
  bool isPolluted;
  int nbPollutions;

  double hydrationMax = 10;
  double nutritionMax = 1000;
  int nbPollutionsMax = 10;

  /* Class contructor
   * arguments :(they are all optional)
   *    hydration, nutrition: real numbers representing the different needs of a tree
   *    hydrationMax, nutritionMax : real numbers representing the limit of the needs of a tree
   *    isPolluted: a boolean indicating if the tree is polluted or not
   *    nbPollutions: an integer that represents the number of pollutions in the tree
   * 
   * return: instatiated class
   */
  HealthBackEnd(
      {double hydration, double nutrition, bool isPolluted, int nbPollutions}) {
    if (hydration == null)
      this.hydration = 10;
    else
      this.hydration = hydration;

    if (nutrition == null)
      this.nutrition = 1000;
    else
      this.nutrition = nutrition;

    if (isPolluted == null)
      this.isPolluted = false;
    else
      this.isPolluted = isPolluted;

    if (nbPollutions == null)
      this.nbPollutions = 0;
    else
      this.nbPollutions = nbPollutions;
  }

  /*Function determinating the overal health of a tree based on the needs
   * arguments:/
   * 
   * returns: the overal mentionned above
   */
  double getOverall() {
    double overall = hydration * nutritionMax * nbPollutionsMax;
    overall += nutrition * hydrationMax * nbPollutionsMax;
    overall += (nbPollutionsMax - nbPollutions) * hydrationMax * nutritionMax;

    overall /= 3;
    double overallMax = nutritionMax * hydrationMax * nbPollutionsMax;

    return (overall * 100) / overallMax;
  }

  /*Function providing provision to the need "hydration"
   * arguments:
   *    nbDrop: Determinates a certain amount of provision to the need "hydration"
   * 
   * returns: 
   *    true: the provision was needed and has been applied
   *    false: the provision is not needed
   */
  bool hydrateTree(double nbDrop) {
    if (this.hydration >= hydrationMax) return false;

    this.hydration += nbDrop;
    if (this.hydration > hydrationMax) this.hydration = hydrationMax;

    Save().saveGame();
    return true;
  }

  /*Function increasing the need "hydration"
   * arguments:
   *    nbDrop: Determinates an certain additional need to "hydration"
   * 
   * returns: /
   */
  void dehydrateTree(double nbDrop) {
    if (this.hydration <= 0) return;

    this.hydration -= nbDrop;
    if (this.hydration < 0) this.hydration = 0;
  }

  /*Function providing provision to the need "nutrition"
   * arguments:
   *    nutrition: Determinates a certain amount of provision to the need "nutrition"
   * 
   * returns: 
   *    true: the provision was needed and has been applied
   *    false: the provision is not needed
   */
  bool nurishTree(double nutrition) {
    if (this.nutrition >= nutritionMax) return false;

    this.nutrition += nutrition;
    if (this.nutrition > nutritionMax) this.nutrition = nutritionMax;

    Save().saveGame();
    return true;
  }

  /*Function increasing the need "hydration"
   * arguments:
   *    nbDrop: Determinates an certain additional need to "hydration"
   * 
   * returns: /
   */
  void denurishTree(double nutrition) {
    if (this.nutrition <= 0) return;

    this.nutrition -= nutrition;
    if (this.nutrition < 0) this.nutrition = 0;
  }

  /*Function increasing the number of pollution
   * arguments: /
   * 
   * returns: /
   */
  void polluteTree() {
    this.isPolluted = true;
    if (nbPollutions < nbPollutionsMax) nbPollutions += 1;
  }

  /*Function decreasing totally the number of pollution
   * arguments: /
   * 
   * returns: 
   *    true: the tree is cleaned
   *    false: the tree is already cleaned
   */
  bool cleanTree() {
    if (isPolluted) {
      this.isPolluted = false;
      nbPollutions = 0;
      Save().saveGame();
      return true;
    }
    return false;
  }
}
