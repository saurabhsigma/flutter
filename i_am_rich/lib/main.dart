import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('I am Rich'),
//           backgroundColor: Colors.blueGrey[900],
//         ),
//         backgroundColor: Colors.blueGrey,
//         body: Center(
//           child: Image.asset('assets/images/me.jpeg'),
//         ),
//       ),
//     ),
//   );
// }

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('I am poor'),
          backgroundColor: Colors.blueGrey[900],
        ),
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Image(image: AssetImage('assets/images/me.jpeg'),
          ),
        ),
      ),
    ),
  );
}