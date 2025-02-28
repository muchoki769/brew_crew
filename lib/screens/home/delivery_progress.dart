import 'package:brew_crew/components/my_receipt.dart';
import 'package:brew_crew/models/restaurant.dart';
import 'package:brew_crew/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryProgress extends StatefulWidget {
  const DeliveryProgress({super.key});

  @override
  State<DeliveryProgress> createState() => _DeliveryProgressState();
}

class _DeliveryProgressState extends State<DeliveryProgress> {
  //get access to the database
  FirestoreService db = FirestoreService();
  @override
   void initState() {
      super.initState();

      //if we get to this page ,submit order to firestore db
    String receipt = context.read<Restaurant>().displayCartReceipt();
     db.saveOrderToDatabase(receipt);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Delivery Progress"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
      body: Column(
        children: [
          MyReceipt()
        ],
      ),
    );
  }

  //custom bottom nav bar - Message/Call delivery driver
Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          //profile pic
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ),
          //driver details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("David",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
              ),

              Text("Driver",
                  style: TextStyle(
                    // fontSize: 18,
                    // fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  )
              ),
            ],
          ),
          const Spacer(),

          Row(
            children: [
              //message button
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.message),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(width: 20),

              //call button
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.call),
                  color: Colors.green,
                ),
              ),
            ]
          )
        ],
      )
    );
}
}
