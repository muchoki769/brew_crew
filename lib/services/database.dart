import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';

class DatabaseServices {
  final String? uid;//property
  DatabaseServices({required this.uid});//this is a constructor

final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

Future<void> updateUserData(String sugars,String name,int strength) async {
  return await brewCollection.doc(uid).set({
    'sugars': sugars,
    'name': name,
    'strength': strength,
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
        sugars: data['sugars'] ?? '',
        strength: data['strength'] ?? 0,
      );

  }).toList();

}
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

//get user doc stream
Stream<DocumentSnapshot> get userData {
  return brewCollection.doc(uid).snapshots();
}
}
