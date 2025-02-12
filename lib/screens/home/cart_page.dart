import 'package:brew_crew/components/my_button.dart';
import 'package:brew_crew/models/product.dart';
import 'package:brew_crew/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  //remove item from cart
  void removeItemFromCart(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // content: Text('Add ${product.name} to cart?'),
        content: const Text("Remove this item to cart?"),
        actions: [
          //cancel button
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),

          //yes button
          MaterialButton(
            onPressed: () {
              //pop dialog box
              Navigator.pop(context);

              //remove to cart
              context.read<Shop>().removeFromCart(product);
            },
            child: const Text('Yes'),
          ),

        ],
      ),
    );
    }

    //pay button pressed
  void payButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
      content:
        Text("User wants to pay! Connect this app to my payment backend"),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    //get access to the cart
    final cart = context.watch<Shop>().cart;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cart'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          //cart list
          Expanded(
            child: cart.isEmpty ?
            const Center (child: Text("Your cart is Empty"))
                : ListView.builder(
              itemCount: cart.length,
                itemBuilder: (context, index) {
              //get individual item in cart
              final item = cart[index];

              //return as a cart tile UI
              return ListTile(
                title: Text(item.name),
                subtitle: Text(item.price.toStringAsFixed(2)),
                trailing: IconButton(
                  onPressed: () => removeItemFromCart(context, item),
                  icon: const Icon(Icons.delete),
                ),
              );
            },
            ),
          ),

          //pay
          Padding(
            padding: const EdgeInsets.all(70.0),
            child: MyButton(onTap:() => payButtonPressed(context),
                child: const Text('Pay Now')),
          ),
        ],
      )
    );
  }
}
