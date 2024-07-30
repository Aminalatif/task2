//
// import 'package:flutter/material.dart';
//
// class Weatheritem extends StatelessWidget {
//   final int value;
//   final String unit;
//   final String imageUrl;
//   final String text;
//
//   const Weatheritem({
//     super.key,
//     required this.value,
//     required this.unit,
//     required this.imageUrl,
//     required this.text,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Flexible(
//           child: Text(
//             text,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//             ),
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(10),
//           height: 60,
//           width: 60,
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             borderRadius: BorderRadius.circular(17),
//           ),
//           child: Image.asset(imageUrl),
//         ),
//         const SizedBox(
//           height: 8.0,
//         ),
//         Flexible(
//           child: Text(
//             '$value$unit',
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';

class Weatheritem extends StatelessWidget {
  final int value;
  final String unit;
  final String imageUrl;
  final String text;

  const Weatheritem({
    super.key,
    required this.value,
    required this.unit,
    required this.imageUrl,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(17),
          ),
          child: Image.asset(imageUrl),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          '$value$unit',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
