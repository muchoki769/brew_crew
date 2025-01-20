import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[200],
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 80.0,
        ),
    ),
    );
    // return Scaffold(
    //     backgroundColor: Colors.blue[900],
    //     body: Center(
    //     // child: SpinKitFadingCircle(
    //
    //     child: SpinKitChasingDots(
    //     color: Colors.white,
    //     size: 80.0,
    // ) ,
    // ),
    // );
  }
}
