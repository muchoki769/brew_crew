import 'package:brew_crew/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier{
  //products for sale
final List<Product> _shop = [
  //product  1
  Product(name: "Yellow pepper",
      price: 0.99,
      description: "Item Description..",
      imagePath: "assets/bright-yellow-pepper.png",
       ),

  //product  2
  Product(name: "fresh black raisins",
      price: 1.99,
      description: "Item Description..",
    imagePath: "assets/fresh-black-raisins.png"
  ),

  //product  3
  Product(name: "fresh jicama",
      price: 0.99,
      description: "Item Description..",
    imagePath: "assets/fresh-jicama.png"
  ),

  //product  4
  Product(name: "rice",
      price: 10.99,
      description: "Item Description..",
    imagePath: "assets/rice-seeds.png"
  ),

  Product(name: "fresh parsley",
      price: 1.99,
      description: "Item Description..",
      imagePath: "assets/vecteezy_fresh-parsley.png"
  ),

  Product(name: "fresh red onion",
      price: 0.99,
      description: "Item Description..",
      imagePath: "assets/fresh-red-onion.png"
  ),


 ];
  //user cart
List<Product> _cart = [
  ];
  //get product list
List<Product> get shop => _shop;
  //get user cart
List<Product> get cart => _cart;
  //add item to cart
void addToCart(Product item) {
    _cart.add(item);
    notifyListeners();

  }
  //remove item from cart
void removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();

   }
}