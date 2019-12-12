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
   * input :(they are all optional)
   *    hydration, nutrition: real numbers representing the different needs of a tree
   *    hydrationMax, nutritionMax : real numbers representing the limit of the needs of a tree
   *    isPolluted: a boolean indicating if the tree is polluted or not
   *    nbPollutions: an integer that represents the number of pollutions in the tree
   * 
   * output: instatiated class
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

  /*getOverall
   * input:/
   * 
   * output: a real number representing the overall health of a tree based on the needs
   */
  double getOverall() {
    double overall = hydration * nutritionMax * nbPollutionsMax;
    overall += nutrition * hydrationMax * nbPollutionsMax;
    overall += (nbPollutionsMax - nbPollutions) * hydrationMax * nutritionMax;

    overall /= 3;
    double overallMax = nutritionMax * hydrationMax * nbPollutionsMax;

    return (overall * 100) / overallMax;
  }

  /*hydrateTree
   * input:
   *    nbDrop: Determinates a certain amount of provision to the need "hydration"
   * 
   * output:
   *    true: the provision for "hydration" was needed and has been applied
   *    false: the provision for "hydration" is not needed
   */
  bool hydrateTree(double nbDrop) {
    if (this.hydration >= hydrationMax) return false;

    this.hydration += nbDrop;
    if (this.hydration > hydrationMax) this.hydration = hydrationMax;

    return true;
  }

  /*dehydrateTree
   * input:
   *    nbDrop: an increase to the need "hydration"
   * 
   * effect: increasing the need "hydration"
   */
  void dehydrateTree(double nbDrop) {
    if (this.hydration <= 0) return;

    this.hydration -= nbDrop;
    if (this.hydration < 0) this.hydration = 0;
  }

  /* nurishTree
   * input:
   *    nutrition: Determinates a certain amount of provision to the need "nutrition"
   * 
   * output:: 
   *    true: the provision "nutrition" was needed and has been applied
   *    false: the provision "nutrition" is not needed
   */
  bool nurishTree(double nutrition) {
    if (this.nutrition >= nutritionMax) return false;

    this.nutrition += nutrition;
    if (this.nutrition > nutritionMax) this.nutrition = nutritionMax;

    return true;
  }

  /* denurishTree
   * input:
   *    nutrition: Determinates an certain additional need to "hydration"
   * 
   * effect: increasing the need "hydration"
   */
  void denurishTree(double nutrition) {
    if (this.nutrition <= 0) return;

    this.nutrition -= nutrition;
    if (this.nutrition < 0) this.nutrition = 0;
  }

  /* polluteTree
   * input: /
   * 
   * effect: increasing the number of pollution
   */
  void polluteTree() {
    this.isPolluted = true;
    if (nbPollutions < nbPollutionsMax) nbPollutions += 1;
    else nbPollutions = nbPollutionsMax;
  }

  /*cleanTree
   * input: /
   * 
   * output: 
   *    true: the tree is cleaned
   *    false: the tree is already cleaned
   */
  bool cleanTree() {
    if (isPolluted) {
      this.isPolluted = false;
      nbPollutions = 0;
      return true;
    }
    return false;
  }
}
