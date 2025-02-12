import 'package:brew_crew/components/my_button.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/firestore.dart';
import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatelessWidget {
   Home({super.key});

  final AuthService _auth = AuthService();
  // final user = FirebaseAuth.instance.currentUser!;
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController textController = TextEditingController();

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
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffee Shop'),
          backgroundColor: Colors.lightBlue[200],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async{
                await _auth.signOut();
                debugPrint("User signed out");

              },
              icon: Icon(Icons.person_2_rounded),
              label: Text('Logout'),

            ),
            TextButton.icon(
              onPressed: () => showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text('settings'),

            ),
          ],

        ),

        // body: BrewList(),
        body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getNotesStream(),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              List noteList = snapshot.data!.docs;

              return ListView.builder(
                itemCount: noteList.length,
                  itemBuilder: (context, index){
                    //get  each individual document
                    DocumentSnapshot document  = noteList[index];
                    String docID = document.id;

                    //get note from each doc
                    Map<String, dynamic> data=
                        document.data() as Map<String, dynamic>;
                    String noteText = data['note'];

                    //display as a list tile
                    return ListTile(
                      title: Text(noteText),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //update button
                          IconButton(
                        onPressed: () => openNoteBox(context, docID: docID),
                        icon: Icon(Icons.edit_note),
                      ),

                      //delete button
                      // onLongPress: () => firestoreService.deleteNote(docID),
                      IconButton(
                      onPressed: () => firestoreService.deleteNote( docID),
                      icon: const Icon(Icons.delete),
                      )
                    ],
                      )
                    );
                  },
              );
            }
            else{
              return const Text ('No notes found...');
              // return Center(
              //     // const Text ('No notes found'),
              //     child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MyButton(
              onTap: () => Navigator.pushNamed(context, '/shop_page'),
            child:FloatingActionButton(
              heroTag: 'uniqueTag1',
              onPressed: (){
                Navigator.pushNamed(context, '/shop_page');

              },
              // onPressed:openNoteBox,
              backgroundColor: Colors.lightBlue[200],
              child: Icon(
                  Icons.shopping_cart,

              ),
            ),
            ),
            SizedBox(width: 16),
            FloatingActionButton(
              heroTag: 'uniqueTag2',
              onPressed: (){

              },
              // onPressed:openNoteBox,
              backgroundColor: Colors.lightBlue[200],
              child: Icon(Icons.add_box_outlined),
            )

          ],
        ),


        // child: Text('home'),
      ),

    );
  }
}


