import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void  showSettingsPanel() {
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
                print("User signed out");

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
        body: BrewList(),
        // child: Text('home'),
      ),
    );
  }
}


