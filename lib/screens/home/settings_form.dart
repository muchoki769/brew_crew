// import 'dart:ffi';

import 'package:brew_crew/services/firestore.dart';
import 'package:brew_crew/shared/loading.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:brew_crew/models/user.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  // final UserData? userData;
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey= GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];
  // late TextEditingController _nameController;
     final TextEditingController textController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();


  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;
  // bool _isInitialized = false;

  // @override
  // void initState(){
  //   super.initState();
  //   _textController = TextEditingController();
    // _nameController = TextEditingController(text: widget.userData?.name ?? "");
    // _currentSugars = widget.userData?.sugars ?? "0";
    // _currentStrength = widget.userData?.strength ?? 100;

    //
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     _nameController.text= widget.userData?.name ?? "";
    //     _currentSugars = widget.userData?.sugars ?? "0";
    //   });
    // });
  // }

  //prevents memory leaks
  // @override
  // void dispose() {
  //   textController.dispose(); //properly dispose the controller
  //   super.dispose();
  // }


  // void _initializeForm(UserData userData) {
  //   if(_nameController.text.isEmpty) {
  //     //   if(_currentName == null){
  //     _nameController.text = userData.name;
  //     _currentSugars ??= userData.sugars;
  //     _currentStrength ??= userData.strength;
  //
  //   }
  // }
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
    final user = Provider.of<UserApp?>(context);
    // final user = Provider.of<User?>(context);
    debugPrint("User UID: ${user?.uid}");
    if (user == null) {
      return const Center(child:Text("No User Found "));
    }
    // return FutureBuilder(
    //   future:Future.delayed(Duration(seconds: 1)),
    //   builder: (context,snapshot) {
        return StreamBuilder<UserData?>(
          // stream: DatabaseServices(uid: user!.uid).userData,
          stream: DatabaseServices(uid: user.uid).getUserData(user.uid),
          builder: (context, snapshot) {
            // if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                debugPrint("Loading user data..");
                return const Loading();
              }
              // Handle error or no data state
              if (snapshot.hasError) {
                debugPrint("Error loading user data: ${snapshot.error}");
                return const Center(child: Text("Error loading user data"));
              }

        //handling empty/error state
              if (  snapshot.hasData || snapshot.data != null) {



        //if data exists update the form
        //     if(snapshot.hasData){
              UserData userData = snapshot.data!;
              // snapshot.data!;
              debugPrint("User data snapshot: ${userData.name}, ${userData
                  .sugars}, ${userData.strength}");
              // _initializeForm(userData);

              // if(_nameController.text.isEmpty) {
              // //   if(_currentName == null){
              // if(_nameController.text.isEmpty){
              //   _nameController.text = userData.name;
              // }
              //   _currentSugars ??= userData.sugars;
              //   _currentStrength ??= userData.strength;
              // if(!_isInitialized){
              //   textController.text = userData.name;
              //   _currentSugars ??= userData.sugars;
              //   _currentStrength ??= userData.strength;
              //   _isInitialized = true;
              // }




              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Update your brew settings.',
                      style: TextStyle(fontSize: 18.0),

                    ),
                    const SizedBox(height: 20.0),

                    TextFormField(
                      // initialValue: _currentName ??  userData.name,
                     controller: textController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) =>
                      val == null || val.isEmpty
                      // val!.isEmpty
                          ? 'Please Enter a  name' : null,
                      // onChanged: (value) {
                       // _currentName = value;
                        // setState(() => _currentName = value);
                        // setState(() { _currentName = val;
                        //   debugPrint("Name changed to: $_currentName");
                        // });

                      // },

                    ),
                    const SizedBox(height: 20.0),

                    // DropdownButtonFormField<String>(value: sugars.first,
                    DropdownButtonFormField<String>(
                      // value: (sugars.contains(_currentSugars) ? _currentSugars :
                      //        sugars.contains(userData.sugars) ? userData.sugars : sugars.first
                      // ),
                      value: _currentSugars ?? userData.sugars,
                      // value: sugars.contains(_currentSugars) ? _currentSugars : userData.sugars,
                      // value: _currentSugars ?? userData.sugars,
                      items: sugars.toSet().map((sugar) {
                      // items: sugars.map((sugar) {
                        return DropdownMenuItem<String>(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _currentSugars = value);
                      },
                      decoration: InputDecoration(
                        labelText: 'Sugars',
                        border: OutlineInputBorder(),
                      ),

                    ),

                    // DropdownButtonFormField(
                    //   value: _currentSugars ?? '0',
                    //   decoration: InputDecoration(
                    //     labelText: 'Sugars',
                    //     border: OutlineInputBorder(),
                    //   ), items: [],
                    // )
                    Slider(
                      min: 100,
                      max: 900,
                      divisions: 8,
                      activeColor: Colors.brown[_currentStrength ?? 100],
                      inactiveColor: Colors.brown[100],
                      // value: (_currentStrength ?? (userData.strength as int))
                      //     .toDouble(),
                      value: (_currentStrength ?? userData.strength)
                          .toDouble(),


                      onChanged: (val) {
                        setState(() => _currentStrength = val.round());
                      },
                    ),
                    //update button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: Text(
                        'update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        // print(_currentName);
                        // print(_currentSugars);
                        // print(_currentStrength);
                        // final navigator = Navigator.of(context);
                        if (_formKey.currentState!.validate()) {
                          await DatabaseServices(uid: user.uid).updateUserData(

                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength,
                            // _currentStrength ?? (userData.strength as int),

                          );
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      }

                      //     Navigator.pop(context);
                      //   }
                      // }

                        // } else {
                        //   print("Form is not valid");
                        // }

                        // Navigator.pop(context);
                        // if (mounted){
                        //   navigator.pop();
                        //   }
                      //   if (context.mounted) {
                      //     Navigator.pop(context);
                      //   }
                      // },
                      // child: const Text(
                      //   'Update',
                      //   style: TextStyle(color: Colors.white),
                      // ),
                    ),
                  ],
                ),
              );
              } else {
                return const Center(child: Text("No User Found"));
                  // return Loading();
              }


              // return Form(
              //   key: _formKey,
              //   child: Column(
              //     children: <Widget> [
              //       Text(
              //           'Update your brew settings.',
              //         style: TextStyle(fontSize: 18.0),
              //
              //       ),
              //       SizedBox(height: 20.0),
              //
              //       TextFormField(
              //         decoration: InputDecoration(
              //           labelText: 'Name',
              //           border: OutlineInputBorder(),
              //         ),
              //         validator:  (val) => val == null || val.isEmpty ? 'Please Enter a  name' :null,
              //         onChanged: (val) {
              //           setState(() => _currentName = val);
              //         },
              //
              //       ),
              //       SizedBox(height: 20.0),
              //
              //       // DropdownButtonFormField<String>(value: sugars.first,
              //        DropdownButtonFormField(
              //          value: _currentSugars ?? '0',
              //         items: sugars.map((sugar) {
              //           return DropdownMenuItem(
              //             value: sugar,
              //             child: Text('$sugar sugars'),
              //           );
              //
              //         }).toList(),
              //         onChanged: (value) {
              //           setState(() => _currentSugars = value);
              //
              //         },
              //         decoration: InputDecoration(
              //           labelText: 'Sugars',
              //           border: OutlineInputBorder(),
              //         ),
              //
              //       ),
              //
              //       // DropdownButtonFormField(
              //       //   value: _currentSugars ?? '0',
              //       //   decoration: InputDecoration(
              //       //     labelText: 'Sugars',
              //       //     border: OutlineInputBorder(),
              //       //   ), items: [],
              //       // )
              //       Slider(
              //         min: 100,
              //         max: 900,
              //         divisions: 8,
              //         activeColor: Colors.brown[_currentStrength ?? 100],
              //         inactiveColor: Colors.brown[100],
              //         value: (_currentStrength ?? 100).toDouble(),
              //         onChanged: (val) {
              //           setState(() => _currentStrength = val.round());
              //         },
              //       ),
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.blueAccent,
              //         ),
              //         child: Text(
              //           'update',
              //           style: TextStyle(color: Colors.white),
              //         ),
              //         onPressed: () async {
              //           print(_currentName);
              //           print(_currentSugars);
              //           print(_currentStrength);
              //         }
              //
              //       )
              //     ],
              //   ),
              // );
            }
          );
      }
    // );
  // }
}
