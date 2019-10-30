import "dart:core";

/**
 * Wallet
 */

//Singleton ? 
//isSufficient private or public ?
//adjustCoints bool or int ?
//Une seule fonction pour add & remove

class Wallet {
  int _amount;

  Wallet(){
    this._amount = 0;
  }

   /* boolean (int coinsValue)
   * 
   * Indicates if the coins of the player has been succesfuly
   * adjusted.
   * 
   * (Input) coinsValue: an integer representing the value of an object
   * 
   * (Output) true if coins adjusted, false if not
   * 
   */
  bool adjustCoins(int coinsValue){
    if(!isSufficient(coinsValue))
      return false;

    this._amount -= coinsValue;
    return true;
  }

    getCoins(){
      return this._amount;
   }

   /* boolean isSufficient(int coinsValue)
   * 
   * Indicates if the coins of the player is sufficient to
   * buy an item which costs *coinsValue*
   * 
   * (Input) coinsValue: an integer representing the value of an object
   * 
   * (Output) true if sufficient, false if not sufficient
   * 
   */
   bool isSufficient(int coinsValue){
      if(coinsValue < 0)
         return true;
      if(this._amount - coinsValue >= 0)
         return true;
      else
         return false;
   }
}