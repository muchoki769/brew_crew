import 'package:brew_crew/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:25, right: 25, bottom: 25, top: 50),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Thank you for your Order"),
          const SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              border:
              Border.all(color: Theme.of(context).colorScheme.inversePrimary),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(25),
            child: Consumer<Restaurant>(
              builder:(context, restaurant, child) =>
                  Text(restaurant.displayCartReceipt()),
            ),
          ),
          const SizedBox(height: 25),
          const Text("Estimated Delivery Time is in 30-50  minutes")
        ],
      ),
    ),
    );
  }
}
