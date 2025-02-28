import 'package:brew_crew/components/my_button.dart';
import 'package:brew_crew/models/food.dart';
import 'package:brew_crew/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {

  final Food food;
  final Map<Addon, bool> selectedAddons = {};

   FoodPage({
    super.key,
    required this.food,
  }) {
     //initialize selected addons to be false unless selected
     for (Addon addon in food.availableAddons) {
       selectedAddons[addon] = false;
     }
   }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {

  //method to cart
  void addToCart (Food food, Map<Addon, bool>selectedAddons){
    //close the current food page to go back to menu
    Navigator.pop(context);
   //get selected addons
   List<Addon> currentlySelectedAddons = [];
   for (Addon addon in widget.food.availableAddons) {
     if (widget.selectedAddons[addon] == true) {
       currentlySelectedAddons.add(addon);
     }

   }
   //add to cart
   context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }
  @override
  Widget build(BuildContext context) {
   return Stack(
     children: [
       //scaffold UI
   Scaffold(
   body: SingleChildScrollView(
   child: Column(
   children: [
   //food image
   Image.asset(widget.food.imagePath),

    Padding(
    padding: const EdgeInsets.all(25.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    //food name
    Text(widget.food.name,
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    // color: Theme.of(context).colorScheme.inversePrimary,
    ),
    ),
    // Text(widget.food.price.toString(),
    Text('KSh ${widget.food.price}',
    style: TextStyle(
    fontSize: 16,
    color: Theme.of(context).colorScheme.primary,
    ),
    ),

    const SizedBox(height: 10),

    //food description
    Text(widget.food.description,
    style: TextStyle(
    fontSize: 16,
    color: Theme.of(context).colorScheme.primary,
    ),
    ),

    const SizedBox(height: 10),

    Divider(color: Theme.of(context).colorScheme.primary),

    const SizedBox(height: 10),

    Text('Add-ons',
    style: TextStyle(
    fontSize: 16,
    color: Theme.of(context).colorScheme.inversePrimary,
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(height: 10),

    //addons
    Container(
    decoration: BoxDecoration(
    border: Border.all(
    color: Theme.of(context).colorScheme.primary,
    ),
    borderRadius: BorderRadius.circular(10),
    ),
    child: ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding:  EdgeInsets.zero,
    itemCount: widget.food.availableAddons.length,
    itemBuilder: (context, index) {
    //get individual addon
    Addon addon = widget.food.availableAddons[index];
    // return addon checkbox UI
    return CheckboxListTile(
    title: Text(addon.name),
    subtitle: Text('Ksh ${addon.price}',
    style: TextStyle(
    color: Theme.of(context).colorScheme.primary,
    ),
    ),
    value: widget.selectedAddons[addon],
    onChanged: (bool? value) {
    setState(() {
    widget.selectedAddons[addon] = value!;
    });
    },
    );
    },

    ),
    ),

    ],
    ),
    ),
    //button -> add to cart
    SizedBox(
    width: 150,
    height: 50,
    child: MyButton(
    onTap: () => addToCart(widget.food, widget.selectedAddons),
    child:Text( "Add to cart",
    // style: TextStyle(
    //   fontSize: 16,
    // ),
    textAlign: TextAlign.center,
    ),
    ),
    ),


    const SizedBox(height: 10),
    ],
    ),
    ),
    ),

       //back button
       SafeArea(
         child: Opacity(
           opacity: 1,
           child: Container(
             margin: const EdgeInsets.only(left: 25),
             decoration: BoxDecoration(
               color: Theme.of(context).colorScheme.secondary,
               shape: BoxShape.circle,
             ),
             child: IconButton(
                 onPressed: () => Navigator.pop(context),
                 icon:const Icon(Icons.arrow_back_rounded),
             ),
           ),
         ),
       )
     ],
   );
  }
}
