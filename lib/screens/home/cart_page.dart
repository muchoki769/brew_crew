import 'package:brew_crew/components/cart_tile.dart';
import 'package:brew_crew/components/my_button.dart';
import 'package:brew_crew/models/product.dart';
import 'package:brew_crew/models/restaurant.dart';
import 'package:brew_crew/models/shop.dart';
import 'package:brew_crew/screens/home/payment.dart';
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
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        //cart
        final userCart =  restaurant.cart;

        //scaffold
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Cart'),
            centerTitle: true,
            actions: [
              //clear cart button
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Are you sure you want to clear the cart"),
                      actions:[
                        //cancel button
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        //yes button
                        TextButton(
                          onPressed: () {
                            //pop dialog box
                            Navigator.pop(context);
                            restaurant.clearCart();
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    )

                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: Column(
            children: [
              //list of cart
              Expanded(
        child: Column(
          children:[
              userCart.isEmpty ?
                  const  Expanded(child: Center ( child: Text("Cart is empty..")
                   ),
                   )
                  :Expanded(
                  child: ListView.builder(
                    itemCount: userCart.length,
                    itemBuilder: (context, index) {
                      //get individual cart item
                      final cartItem = userCart[index];

                      //return cart tile UI
                     // return ListTile(
                     //    title: Text(cartItem.food.name),
                     //  );
                      return MyCartTile(cartItem: cartItem);
                    },
              ),
              ),
            ]
          ),
        ),

          // button to pay
          // MyButton(
          //     onTap: () =>
          //   Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const Payment(),
          //   ),
          // ),
          //    child: const Text( "Go to checkout"),
          // ),

          MyButton(
            onTap: () { // Use {} instead of =>
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Payment(),
                ),
              );
            },
            child: const Text("Go to checkout"),
          ),




          const SizedBox(height: 25),
          ],
          )
        );
      }

    );

  }
}


//   @override
//   Widget build(BuildContext context) {
//     //get access to the cart
//     final cart = context.watch<Shop>().cart;
//     //get access to the restaurant
//     final userCart =context.watch<Restaurant>().cart;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         foregroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text('Cart'),
//         centerTitle: true,
//       ),
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       body: Column(
//         children: [
//           //cart list
//           Expanded(
//             child: cart.isEmpty ?
//             const Center (child: Text("Your cart is Empty"))
//                 : ListView.builder(
//               itemCount: cart.length,
//                 itemBuilder: (context, index) {
//               //get individual item in cart
//               final item = cart[index];
//
//               //return as a cart tile UI
//               return ListTile(
//                 title: Text(item.name),
//                 subtitle: Text(item.price.toStringAsFixed(2)),
//                 trailing: IconButton(
//                   onPressed: () => removeItemFromCart(context, item),
//                   icon: const Icon(Icons.delete),
//                 ),
//               );
//             },
//             ),
//           ),
//
//           //pay
//           Padding(
//             padding: const EdgeInsets.all(70.0),
//             child: MyButton(onTap:() => payButtonPressed(context),
//                 child: const Text('Pay Now')),
//           ),
//         ],
//       )
//     );
//   }
// }
