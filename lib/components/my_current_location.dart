import 'package:brew_crew/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({

    super.key
  });

  // TextEditingController textController = TextEditingController();

  void openLocationSearchBox(BuildContext context, TextEditingController textController){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Your Location"),
          content: TextField(
            controller: textController,
            decoration:  InputDecoration(
              hintText: "Enter address..."),
          ),
          actions: [
            //cancel button
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                textController.clear();
                },
              child:const Text("cancel"),

            ),

            //save button
            MaterialButton(
              onPressed: () {
                //update delivery address
                String newAddress = textController.text;
                context.read<Restaurant>().updateDeliveryAddress(newAddress);
                Navigator.pop(context);
                textController.clear();
                },
              child: Text("Save"),

            ),
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return  Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "deliver now",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),

          ),
          GestureDetector(
            onTap: () => openLocationSearchBox(context, textController) ,
            child: Row(
              children: [
                //address
                // Icon(Icons.location_on),
                // Consumer<Restaurant>(
                //   builder: (context, restaurant, child) =>
                // Text(
                //   restaurant.deliveryAddress,
                //   style:TextStyle(color: Theme.of(context).colorScheme.primary,
                //       fontWeight: FontWeight.bold
                //   ),
                //
                //
                // ),
                // ),


                //drop down menu
                Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
