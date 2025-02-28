import 'package:brew_crew/models/shop.dart';
import 'package:brew_crew/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductTile extends StatelessWidget {
  final Product product;
  const MyProductTile({
    super.key,
    required this.product,
  });

  void addToCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // content: Text('Add ${product.name} to cart?'),
          content: Text("Add this item to cart?"),
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

              //add to cart
              context.read<Shop>().addToCart(product);
              },
            child: const Text('Yes'),
          ),

         ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(25.0),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             //product image
             AspectRatio(
               aspectRatio: 1, //image will be a square
               child:Container(
                   decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,
                     borderRadius: BorderRadius.circular(12.0),
                   ),
                   width: double.infinity,
                   padding: const EdgeInsets.all(25.0),
                   child: Image.asset(product.imagePath),
               ),
             ),
             const SizedBox(height: 12.0),

             //product name
             Text(product.name,
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 20.0,
               ),
             ),

             const SizedBox(height: 12.0),
             //product description
             Text(
                 product.description,
                 style: TextStyle(
                   color: Theme.of(context).colorScheme.inversePrimary,

                 )
             ),
           ],
         ),

              //product price + add to cart button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$' + product.price.toStringAsFixed(2)),// Display price with 2 decimal places,from a double to a string

                  //add to cart button
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: IconButton(
                      onPressed: () => addToCart(context),
                      icon: const Icon(Icons.add_shopping_cart),
                    ),
                  )
                ],
              ),
            ],
          ),

      );

  }
}
