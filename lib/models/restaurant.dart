import 'package:brew_crew/models/cart_item.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import'food.dart';

class Restaurant extends ChangeNotifier {

  //List of food menu
  final List <Food> _menu = [
    //burgers
    Food(
        name: "Classic cheeseburger",
        description:
        "A juicy beef patty with melted cheddar, lettuce, tomato,a hint of onion and pickles.",
        imagePath: "lib/images/burgers/fresh-burger.png",
        price: 400,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),
    // Food (
    //     name: "Classic cheeseburger",
    //     description:
    //     "A juicy beef patty with melted cheddar, lettuce, tomato,a hint of onion and pickles.",
    //     imagePath: "lib/images/burgers/fresh-burger.png",
    //     price: 400,
    //     category: FoodCategory.burgers,
    //     availableAddons:[
    //       Addon(name: "Extra cheese", price: 0.99),
    //       Addon(name: "Bacon", price: 1.99),
    //       Addon(name: "Avocado", price: 2.99),
    //     ]
    // ),

    Food(
        name: "cheeseburger with lettuce-tomato",
        description:
        "a-double-cheeseburger-with-lettuce-tomato.",
        imagePath: "lib/images/burgers/a-double-cheeseburger-with-lettuce-tomato.png",
        price: 350,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),
    Food(
        name: "large chicken burger",
        description:
        "double large chicken zinger burger with fries and cheese.",
        imagePath: "lib/images/burgers/double-large-chicken-zinger-burger-with-fries-and-cheese.png",
        price: 600,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "Grilled Onions", price: 0.99),
          Addon(name: "Jalapenos", price: 1.99),
          Addon(name: "Extra BBQ Sauce", price: 2.99),
        ]
    ),
    //salads
    Food(
        name: "vegetable salad",
        description:
        "vegetable salad.",
        imagePath: "lib/images/salads/vegetable-salad.png",
        price: 250,
        category: FoodCategory.salads,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),
    Food(
        name: "salad tomatoes bacon",
        description:
        "delicious salad tomatoes bacon.",
        imagePath: "lib/images/salads/delicious_salad-tomatoes-bacon.png",
        price: 300,
        category: FoodCategory.salads,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),

    //sides
    Food(
        name: "Medium french fries",
        description:
        "Medium french fries.",
        imagePath: "lib/images/sides/Medium_french-fries.png",
        price: 300,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),
    Food(
        name: "french fries",
        description:
        "french fries.",
        imagePath: "lib/images/sides/french-fries.png",
        price: 200,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),
    Food(
        name: "fried chicken",
        description:
        "hot and crispy fried chicken.",
        imagePath: "lib/images/sides/hot-and-crispy-fried-chicken.png",
        price: 200,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),

    Food(
        name: "hotdog",
        description:
        "Delicious hotdog.",
        imagePath: "lib/images/sides/hotdog.png",
        price: 250,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),


    //desserts
    Food(
        name: "Butter cake",
        description:
        "Butter cake.",
        imagePath: "lib/images/desserts/butter-cake.png",
        price: 800,
        category: FoodCategory.desserts,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),
    Food(
        name: "trifle",
        description:
        "trifle.",
        imagePath: "lib/images/desserts/trifle.png",
        price: 500,
        category: FoodCategory.desserts,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),

    //drinks
    Food(
        name: "Cold Coca cola.",
        description:
        "Cold Coca cola.",
        imagePath: "lib/images/drinks/coca-cola.png",
        price: 150,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),

    Food(
        name: "Mojito cocktail",
        description:
        "refreshing green mojito cocktail with lime and mint garnish.",
        imagePath: "lib/images/drinks/refreshing-green-mojito-cocktail-with-lime-and-mint-garnish.png",
        price: 150,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),

    Food(
        name: "citrus cocktail",
        description:
        "refreshing citrus cocktail with orange slice and mint garnish.",
        imagePath: "lib/images/drinks/refreshing-citrus-cocktail-with-orange-slice-and-mint-garnish.png",
        price: 150,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),

    Food(
        name: "Lemon cocktail",
        description:
        "refreshing cocktail-with-lemon-and-mint-garnish.",
        imagePath: "lib/images/drinks/refreshing-cocktail-with-lemon-and-mint-garnish.png",
        price: 150,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),

    Food(
        name: "Lemon cocktail ",
        description:
        "refreshing-cocktail-with-lime-and-mint-served-over-ice.png.",
        imagePath: "lib/images/drinks/refreshing-cocktail-with-lime-and-mint-served-over-ice.png",
        price: 150,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99),
        ]
    ),


  ];

  //user cart
  final List<CartItem> _cart = [];

  //delivery address
  String _deliveryAddress = 'Sandalwood Karen Nairobi';

  // GETTERS
  List <Food> get menu => _menu;

  List<CartItem> get cart => _cart;

//OPERATIONS


//add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    //see if there is a cart item already with the same food and selected addons
    //flutter pub add collection
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      //check if the food items are the same
      bool isSameFood = item.food == food;

      //check if selected addons are the same
      bool isSameAddon =
      const ListEquality().equals(item.selectedAddons, selectedAddons);
      return isSameFood && isSameAddon;
    });

    //if item already exists increase its quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }
//otherwise add a new cart item to the cart
    else {
      _cart.add(CartItem(food: food, selectedAddons: selectedAddons),
      );
    }
    notifyListeners();
  }

//remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart [cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

//get total price of cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

//get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;


    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

//clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  //update delivery address
  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

//HELPERS


//generate a receipt
String displayCartReceipt(){
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt.");
    receipt.writeln();

    //format date to include up to seconds only
    //flutter pub add intl
  String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  receipt.writeln(formattedDate);
  receipt.writeln();
  receipt.writeln("----------");

  for (final cartItem in _cart){
    receipt.writeln(
      "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
    if (cartItem.selectedAddons.isNotEmpty) {
      receipt.writeln(
        " Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
    }
    receipt.writeln();

  }
  receipt.writeln("----------");
  receipt.writeln();
  receipt.writeln("Total Item: ${getTotalItemCount()}");
  receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
  receipt.writeln();
  receipt.writeln("Delivering to: $_deliveryAddress");


  return receipt.toString();

}
//format double value into money
  String _formatPrice(double price) {
    return "Ksh ${ price.toStringAsFixed(2)}";
  }

//format list of addons into a string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(",");
  }
}