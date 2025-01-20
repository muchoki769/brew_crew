import 'package:brew_crew/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';

class BrewList extends StatelessWidget {
  const BrewList({super.key});

  @override
  Widget build(BuildContext context) {
    // final brews = Provider.of<QuerySnapshot?>(context);
    final brews = Provider.of<List<Brew>>(context);
    // print(brews);

   //  if (brews == null) {
   //    return const Center(child: CircularProgressIndicator());
   //  }
   //
   // for (var doc in brews.docs) {
   //   print(doc.data());
   // }
   // return Container();


   //  if (brews == null) {
      // return const Center(child: CircularProgressIndicator());
    // }

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      //   final brewData = brews.docs[index].data() as Map<String, dynamic>;
      //   return ListTile(
      //     leading: CircleAvatar(
      //       radius: 25.0,
      //       backgroundColor: Colors.brown[brewData['strength'] ?? 100],
      //
      //     ),
      //     title: Text(brewData['name'] ?? 'Unknown'),
      //     subtitle: Text('Takes: ${brewData['sugars'] ?? '0'}sugar(s)'),
      //     //
      //     // title: Text(brewData['name'] ?? 'Unknown'),
      //     // subtitle: Text('Strength: ${brewData['strength'] ?? 'N/A'}'),
      //   );
      },
    );

  }
}
