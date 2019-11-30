import "dart:core";
import "Save.dart";

class Wallet {
  int _amount ;
  static final Wallet _singleton = Wallet._internal();

  factory Wallet(){
    return _singleton;
  }

  Wallet._internal(){
    _amount = Save().getWallet();
  }

  void retrieveCoins(int coinsValue){
    if(isSufficient(coinsValue))
      this._amount -= coinsValue;
  }

  int getCoins(){
      return this._amount;
   }

  String saveWallet(){
    return _amount.toString();
  }

   bool isSufficient(int coinsValue){
      if(coinsValue < 0)
         return true;
      if(this._amount - coinsValue >= 0)
         return true;
      else
         return false;
   }

   void addCoins(int addedCoins){
     _amount+= addedCoins;
   }
}