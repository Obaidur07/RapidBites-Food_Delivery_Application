import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_models.dart';
import '../../utils/app_constants.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList){
    var time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.CARTLIST, cart);
  }

  List<CartModel> getCartList(){
    List<String>? carts = [];
    if(sharedPreferences.containsKey(AppConstants.CARTLIST)){
      carts = sharedPreferences.getStringList(AppConstants.CARTLIST);
    }
    List<CartModel> cartList = [];
    carts?.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HSITORY_LIST,)){
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HSITORY_LIST,)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element)=> cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HSITORY_LIST,)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HSITORY_LIST,)!;
    }
    for(int i = 0 ; i < cart.length ; i++){
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HSITORY_LIST, cartHistory);
  }
  void removeCart(){
    cart = [];
    sharedPreferences.remove(AppConstants.CARTLIST);
  }

}

