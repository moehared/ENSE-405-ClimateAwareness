import 'package:flutter/material.dart';

class AllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('all screen'),
      ),
    );
  }
}

// List<Widget> getData() {
//   List<Widget> item = [];
//   newList.forEach((e) {
//     if (e != null) {
//       item.add(
//         Column(
//           children: [
//             Text('Type: ${e.type}'),
//             Text('User choice: ${e.userChoice}')
//           ],
//         ),
//       );
//     }
//
//     setState(() {
//       data = item;
//     });
//   });
//   return item;
// }
