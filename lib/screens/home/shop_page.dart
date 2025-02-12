import 'package:brew_crew/components/my_drawer.dart';
import 'package:brew_crew/components/my_product_tile.dart';
import 'package:brew_crew/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    //access products in shop
    final products = context.watch<Shop>().shop;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Shop page'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart_page'),
            icon: const Icon(Icons.shopping_cart),
          ),
          ],

      ),
      drawer: MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: ListView(
        children: [
          const SizedBox(height: 25.0),
          Center(
            child: Text(
              'Products',
              // style: Theme.of(context).textTheme.headlineMedium,
              style: TextStyle (
                  color:Theme.of(context).colorScheme.inversePrimary
              ),
            ),
          ),
         SizedBox(
          height: 550,
          child: ListView.builder(
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(12.0),
            itemBuilder: (context, index) {
              //get each individual product from shop
              final product = products[index];

              //return as a product tile UI
              return MyProductTile(product: product);
            },
          ),
        ),
      ],
      ),
    );
  }
}
