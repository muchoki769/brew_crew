import 'package:brew_crew/components/my_button.dart';
import 'package:brew_crew/components/my_current_location.dart';
import 'package:brew_crew/components/my_description_box.dart';
import 'package:brew_crew/components/my_drawer.dart';
import 'package:brew_crew/components/my_food_tile.dart';
import 'package:brew_crew/components/my_sliver_app_bar.dart';
import 'package:brew_crew/components/my_tab_bar.dart';
import 'package:brew_crew/models/food.dart';
import 'package:brew_crew/models/restaurant.dart';
import 'package:brew_crew/screens/home/food_page.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/screens/home/shop_page.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/firestore.dart';
import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatefulWidget {
   const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  final AuthService _auth = AuthService();

  // final user = FirebaseAuth.instance.currentUser!;
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController= TabController(length: FoodCategory.values.length, vsync: this);
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  //sort out and return a list of food items that belong to a specific category
List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu){
    return fullMenu.where((food)=> food.category == category).toList();
}
List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
          //get individual food
          final food = categoryMenu[index];
          // return food tile UI
          return  FoodTile
            (food: food,
              onTap: ()=> Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodPage(food: food),
                ),
              )

          );
          //   ListTile(
          //   title: Text(categoryMenu[index].name),
          // );

          }
      );
    }).toList();
}

  void openNoteBox(BuildContext context, {String? docID}){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content:TextField(
            controller: textController
        ),
        actions: [
          ElevatedButton(
            onPressed: (){
              // firestoreService.addNote(textController.text);

              //add a note
              if (docID == null) {
                firestoreService.addNote(textController.text);
              }
              //update a note
              else {
                firestoreService.updateNote(docID, textController.text);
              }

              textController.clear();

              Navigator.pop(context);

            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      showSettingsPanel() {
      showModalBottomSheet(context: context, builder:(context)
      {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );

      });
    }


    // return StreamProvider<List<Map<String, dynamic>>>.value(
        // value: DatabaseServices(uid: '').brews,
        // initialData: const [],
    // return StreamProvider<QuerySnapshot>.value(
    //   value:DatabaseServices(uid: '').brews,
      // value:DatabaseServices(uid: '').brews,
    // return StreamProvider<QuerySnapshot?>(
    //   create: (_) => DatabaseServices(uid: '').brews,
       return StreamProvider<List<Brew>>(
         create: (_) => DatabaseServices(uid: '').brews,
      initialData: const [],
      child: Scaffold(
        // backgroundColor: Colors.brown[50],
        backgroundColor: Theme.of(context).colorScheme.surface,
        // appBar: AppBar(
        //   title: Text('Coffee Shop'),
        //   backgroundColor: Colors.lightBlue[200],
        //   elevation: 0.0,
        //   actions: <Widget>[
        //     TextButton.icon(
        //       onPressed: () async{
        //         await _auth.signOut();
        //         debugPrint("User signed out");
        //
        //       },
        //       icon: Icon(Icons.person_2_rounded),
        //       label: Text('Logout'),
        //
        //     ),
        //     TextButton.icon(
        //       onPressed: () => showSettingsPanel(),
        //       icon: Icon(Icons.settings),
        //       label: Text('settings'),
        //
        //     ),
        //   ],
        //
        // ),
        drawer: const MyDrawer(),
        // backgroundColor: Theme.of(context).colorScheme.surface,

        body:NestedScrollView(
            headerSliverBuilder: ( context , innerBoxIsScrolled) => [
              MySliverAppBar(
                title: MyTabBar(tabController: _tabController),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Divider(
                      indent: 25,
                      endIndent: 25,
                      // thickness: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                   //my current location
                    const MyCurrentLocation(),

                    //description box

                   const  MyDescriptionBox(),

                    //
                  ],
                ),
              ),

            ],

            body: Consumer<Restaurant>(
              builder: (context, restaurant, child) => TabBarView(
                controller: _tabController,
                  children: getFoodInThisCategory(restaurant.menu)
            ),

            // body:TabBarView(
            //   controller: _tabController,

              // children: [
              //
              //   ListView.builder(
              //       itemCount: 5,
              //       itemBuilder: (context, index) => Text("hello")
              //   ),
              //   ListView.builder(
              //       itemCount: 5,
              //       itemBuilder: (context, index) => Text("am")
              //   ),
              //   ListView.builder(
              //       itemCount: 5,
              //       itemBuilder: (context, index) => Text("David")
              //   ),
              //   ListView.builder(
              //       itemCount: 5,
              //       itemBuilder: (context, index) => Text("David")
              //   ),
              //   ListView.builder(
              //       itemCount: 5,
              //       itemBuilder: (context, index) => Text("David")
              //   ),
              // ]
            ),

        ),

        // body: BrewList(),
        // body: StreamBuilder<QuerySnapshot>(
        //   stream: firestoreService.getNotesStream(),
        //   builder: (context, snapshot){
        //     if (snapshot.hasData) {
        //       List noteList = snapshot.data!.docs;
        //
        //       return ListView.builder(
        //         itemCount: noteList.length,
        //           itemBuilder: (context, index){
        //             //get  each individual document
        //             DocumentSnapshot document  = noteList[index];
        //             String docID = document.id;
        //
        //             //get note from each doc
        //             Map<String, dynamic> data=
        //                 document.data() as Map<String, dynamic>;
        //             String noteText = data['note'];
        //
        //             //display as a list tile
        //             return ListTile(
        //               title: Text(noteText),
        //               trailing: Row(
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   //update button
        //                   IconButton(
        //                 onPressed: () => openNoteBox(context, docID: docID),
        //                 icon: Icon(Icons.edit_note),
        //               ),
        //
        //               //delete button
        //               // onLongPress: () => firestoreService.deleteNote(docID),
        //               IconButton(
        //               onPressed: () => firestoreService.deleteNote( docID),
        //               icon: const Icon(Icons.delete),
        //               )
        //             ],
        //               )
        //             );
        //           },
        //       );
        //     }
        //     else{
        //       return const Text ('No notes found...');
        //       // return Center(
        //       //     // const Text ('No notes found'),
        //       //     child: CircularProgressIndicator());
        //     }
        //   },
        // ),

        // floatingActionButton: Row(
        //   // mainAxisSize: MainAxisSize.min,
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     MyButton(
        //       onTap: () => Navigator.pushNamed(context, '/shop_page'),
        //     child:FloatingActionButton(
        //       heroTag: 'uniqueTag1',
        //       onPressed: (){
        //         Navigator.pushNamed(context, '/shop_page');
        //
        //       },
        //       // onPressed:openNoteBox,
        //       backgroundColor: Colors.lightBlue[200],
        //       child: Icon(
        //           Icons.shopping_cart,
        //
        //       ),
        //     ),
        //     ),
        //     SizedBox(width: 16),
        //     FloatingActionButton(
        //       heroTag: 'uniqueTag2',
        //       onPressed: (){
        //
        //       },
        //       // onPressed:openNoteBox,
        //       backgroundColor: Colors.lightBlue[200],
        //       child: Icon(Icons.add_box_outlined),
        //     )
        //
        //   ],
        // ),
        //

        // child: Text('home'),
      ),

    );
  }
}


