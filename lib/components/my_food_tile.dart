import 'package:flutter/material.dart';
import 'package:brew_crew/models/food.dart';


class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;
  const FoodTile({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [

                //text food details
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(food.name),
                        // Text( 'Ksh'  + food.price.toString(),
                          Text('KSh ${food.price}',

                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                            ),

                        const SizedBox(height: 10),
                        Text(food.description,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        )
                        ),
                      ],
                    ),
                ),
                const SizedBox(width: 15),
                //food image
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(food.imagePath, height: 120),
                ),
              ],
            ),
          ),
        ),
        Divider(
          indent: 25,
          endIndent: 25,
          // thickness: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
      ]
    );
  }
}
