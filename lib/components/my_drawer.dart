import 'package:brew_crew/components/my_list_tile.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/firestore.dart';


class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});



  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final AuthService _auth = AuthService();
  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //drawer header:logo
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: Center(
                  child:  Container(
                    width: 180,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Image.asset("assets/mobile-shopping.png",
                      fit: BoxFit.cover,
                      ),

                  ),
                  // child: Icon(
                  //   Icons.shopping_bag,
                  //   size: 80,
                  //   color: Theme.of(context).colorScheme.inversePrimary,
                  // ),
                ),
              ),

              const SizedBox(height: 20.0),

              //shop tile
              MyListTile(
                text: 'Shop',
                icon: Icons.local_mall,
                onTap: () => Navigator.pushNamed(context, '/shop_page'),
                // onTap: () => Navigator.pop(context),

              ),
              //cart tile
              MyListTile(
                text: 'Cart',
                icon: Icons.shopping_cart,
                onTap: () {
                  Navigator.pop(context);

                  //cart page
                  Navigator.pushNamed(context, '/cart_page');

                },
              ),

              MyListTile(
                text: 'Home',
                icon: Icons.home,
                onTap: () => Navigator.pushNamed(context, '/wrapper'),
                //onTap: () => Navigator.pop(context),

              ),
              MyListTile(
                text: 'Settings',
                icon: Icons.settings,
                onTap: () {
                  Navigator.pop(context);

                  //cart page
                  Navigator.pushNamed(context, '/settings');

                },
                //onTap: () => Navigator.pop(context),

              ),

            ],
          ),

          // const Spacer(),


          //exit
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              text: 'Logout',
              icon: Icons.logout,
              onTap: () async{
                await _auth.signOut();
              },
            ),
            // TextButton.icon(
            //   onPressed: () async{
            //     await _auth.signOut();
            //     debugPrint("User signed out");
            //
            //   },
            //   icon: Icon(Icons.person_2_rounded),
            //   label: Text('Logout'),
            //
            // ),
          ),
        ]
      ),
    );
  }
}
