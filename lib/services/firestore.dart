import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';


class FirestoreService {
  final CollectionReference notes = FirebaseFirestore.instance.collection(
      'notes');
  //create a note
  Future<void> addNote(String note)  {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }
  //READ a note
Stream<QuerySnapshot> getNotesStream() {
    final notesStream = notes.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
}
//update notes
Future<void> updateNote(String docID, String newNote){
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });

}

//deleting a note given in a document ID
Future<void> deleteNote(String docID){
    return notes.doc(docID).delete();
}

}
class DatabaseServices {
  final String? uid; //property
  DatabaseServices({required this.uid}) {
    debugPrint("UID passed: $uid"); // Debug print to check UID
  }

  final CollectionReference brewCollection = FirebaseFirestore.instance
      .collection('brews');



  Future <void>updateUserData(String name, String strength, int sugars) async {
    return await brewCollection.doc(uid).set({
      'name': name,
      'strength': strength,
      'sugars': sugars,
      'timestamp':Timestamp.now(),
    });
  }


// brew list from snapshot
//   List<Map<String, dynamic>> _brewListFromSnapshot(QuerySnapshot snapshot)
  List <Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    // return snapshot.docs.map((doc) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Brew(
        name: data['name'] ?? '',
        strength: data['strength'] ?? 0,
        sugars: data['sugars'] ?? '',
      );
    }).toList();
  }

  // Convert firestore DocumentSnapshot to UserData
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    // String sugars = data['sugars'].toString();//ensures sugars is always a string
    return UserData(
      uid: snapshot.id,
      name: data['name'] ?? '',
      strength: data['strength'] ?? 100,
      sugars: data['sugars'] ?.toString() ?? '0',
      // sugars: sugars,

    );
  }

  // user data from snapshots
  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   var data = snapshot.data() as Map<String, dynamic>;
  //   return UserData(
  //       uid: snapshot.id,
  //       name: data['name'] ?? '',
  //       sugars: data['sugars'] ?? '0',
  //       strength: data['strength'] ?? 100,
  //   );
  // }


//get brews stream
  Stream<List<Brew>> get brews {
//   Stream<QuerySnapshot> get brews {
// Stream<QuerySnapshot<Object?>> get brews {
    // return brewCollection.snapshots().map(_brewListFromSnapshot);
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

// List<Map<String, dynamic>> _brewListFromSnapshot(QuerySnapshot snapshot)
// {
//   return snapshot.docs.map((doc) {
//     return {
//       'name': doc['name'] ?? '',
//       'sugars': doc['sugars'] ?? '',
//       'strength': doc['strength'] ?? 0,
//     };
//   }).toList();

// }

// get user doc stream
  Stream<UserData?> getUserData(String uid) {
    print("Fetching data for UID: $uid");
    return brewCollection.doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        print("Document data: ${snapshot.data()}");
        // int sugars = snapshot.data()!['sugars'];
        return _userDataFromSnapshot(snapshot);
      } else {
        throw Exception('User not found');
      }
    });
  }





// Stream<UserData?>getUserData(String uid) {
//
//     return FirebaseFirestore.instance.collection('brews').doc(uid).snapshots().map((snapshot){
//       if(!snapshot.exists){
//         return null;
//       }
//       return UserData(
//         uid: snapshot.id,
//         name: snapshot.data()?['name'] ?? '',
//         sugars: snapshot.data()?['sugars'] ?? '0',
//         strength: snapshot.data()?['strength'] ?? 100,
//       );
//
//     });
// }
  // Stream<UserData> getUserData() {
  //   return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  // }

}
