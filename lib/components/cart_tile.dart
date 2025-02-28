import 'package:brew_crew/components/my_quantity_selector.dart';
import 'package:brew_crew/models/cart_item.dart';
import 'package:brew_crew/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  // final Food food;

  const MyCartTile({
    super.key,
    required this.cartItem,
    // required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(builder: (context, restaurant, child) => Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      // margin: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(cartItem.food.imagePath,
                  height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(width: 20),

                //name and price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //food name
                    Text(cartItem.food.name),

                    // food price
                    Text('KSh ${cartItem.food.price.toStringAsFixed(2)}',

                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(height: 20),

                    //increment or decrement quantity
                    QuantitySelector(
                        quantity: cartItem.quantity,
                        food: cartItem.food,
                        onIncrement: () {
                          //increment quantity
                          restaurant.addToCart(cartItem.food, cartItem.selectedAddons);

                        },
                        onDecrement: () {
                          //decrement quantity
                          restaurant.removeFromCart(cartItem);
                        }
                    )

                  ],
                ),
                // const Spacer(),

              ],
            ),
          ),
          //addons
          SizedBox(
            height: cartItem.selectedAddons.isEmpty ? 0 : 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
              children: cartItem.selectedAddons.map(
                  (addon) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Row(
                        children:[
                          // addon name
                          Text(addon.name),
                          const SizedBox(width: 10),

                          //addon price
                          Text('KSh ${addon.price.toStringAsFixed(2)}'

                          ),
                        ],
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      onSelected: (value) {},
                      backgroundColor:
                      Theme.of(context).colorScheme.tertiary,
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),

                    ),
                  ),
              ).toList(),

            ),

          ),
        ]
      ),
    )
    );
  }
}
