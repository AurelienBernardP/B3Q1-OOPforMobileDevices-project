import "dart:core";
import "Save.dart";

/*Wallet  class
 * 
 * Singleton class that represents the wallet of the game
 * 
 * Attributes : 
 *   _amount : The amount in the wallet
 */
class Wallet {
  int _amount;
  static final Wallet _singleton = Wallet._internal();

  /*Wallet
  * input: /
  *
  * output: the instantiatesd class
  */
  factory Wallet() {
    return _singleton;
  }

  //private constructor, initialising TimersForTrees for the first time
  Wallet._internal() {
    _amount = Save().getWallet();
  }

  /* retrieveCoins
  * input: 
  *    coinsValue: an integer indicating the amount to retrieve from the wallet
  *
  * effect: retrieve the amount coinsValue from the wallet
  */
  void retrieveCoins(int coinsValue) {
    if (isSufficient(coinsValue)) this._amount -= coinsValue;
  }

  /*getCoins
  * input: /
  *
  * output: the amount of the currrent wallet
  */
  int getCoins() {
    return this._amount;
  }

  /*isSufficient
  * input: 
  *   coinsValue: an integer representing the value of an object
  *
  * output:
  *   true: the amount in the wallet is sufficient for coinsValue
  *   false: the amount in the wallet is not sufficient for coinsValue
  */
  bool isSufficient(int coinsValue) {
    if (coinsValue < 0) return true;
    if (this._amount - coinsValue >= 0)
      return true;
    else
      return false;
  }

  /* addCoins
  * input: 
  *    addedCoins: an integer indicating the amount to add to the wallet
  *
  * effect: adding coins to the current wallet
  */
  void addCoins(int addedCoins) {
    _amount += addedCoins;
  }
}
