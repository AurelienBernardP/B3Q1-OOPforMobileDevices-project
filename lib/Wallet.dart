import "dart:core";
import "Save.dart";

/*Wallet  class
 * 
 * Singleton class that represents the wallet
 * 
 * Attributes : 
 *            _amount : The amount in the wallet
 */
class Wallet {
  int _amount;
  static final Wallet _singleton = Wallet._internal();

  /*Wallet
  * input: /
  *
  * return: the instantiatesd class
  */
  factory Wallet() {
    return _singleton;
  }

  /*
  * input: /
  *
  * return: the amount of wallet from the save
  */
  Wallet._internal() {
    _amount = Save().getWallet();
  }

  /* retrieveCoins
  * input: 
  *    coinsValue: an integer indicating the amount to retrieve from the wallet
  *
  * return: /
  */
  void retrieveCoins(int coinsValue) {
    if (isSufficient(coinsValue)) this._amount -= coinsValue;
  }

  /*getCoins
  * input: /
  *
  * return: the amount of the wallet
  */
  int getCoins() {
    return this._amount;
  }

  /*isSufficient
  * input: 
  *   coinsValue: an integer representing the value of an object
  *
  * return:
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
  *    coinsValue: an integer indicating the amount to add to the wallet
  *
  * return: /
  */
  void addCoins(int addedCoins) {
    _amount += addedCoins;
  }
}
