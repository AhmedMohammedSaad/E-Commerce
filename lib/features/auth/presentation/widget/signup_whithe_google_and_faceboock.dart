// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// //import 'package:advanced_app/core/StringImage/string_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// class SingUPWhitheGoogleandFaceBook extends StatelessWidget {
//   const SingUPWhitheGoogleandFaceBook({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // SingUP with Google
//         // Container(
//         //   width: double.infinity,
//         //   height: 45,
//         //   alignment: Alignment.center,
//         //   decoration: BoxDecoration(
//         //     // color: Colors.white, // Background color
//         //     border: Border.all(color: Colors.grey), // Border color
//         //     borderRadius: BorderRadius.circular(8), // Rounded corners
//         //   ),
//         //   child: Row(
//         //     mainAxisAlignment: MainAxisAlignment.center,
//         //     children: [
//         //       Image(
//         //         image: AssetImage(
//         //           StringImage.googleIcon,
//         //         ),
//         //         width: 22,
//         //       ),
//         //       SizedBox(width: 8), // Space between icon and text
//         //       Text(
//         //         "SignUp with Google",
//         //         style: TextStyle(
//         //           color: Colors.black, // Text color
//         //           fontSize: 14, // Text size
//         //           fontWeight: FontWeight.bold, // Text weight
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ).animate().fadeIn(duration: 540.ms).then(delay: 180.ms).slide(
//         //       begin: const Offset(1.0, 1.0), // Start from the right
//         //       end: Offset.zero, // End at the original position
//         //       duration: 800.ms,
//         //     ),
//         SizedBox(height: 16), // Space between buttons

//         //! SingUP with Facebook
//         Container(
//           width: double.infinity,
//           height: 48,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             // color: Colors.white, // Background color
//             border: Border.all(color: Colors.grey), // Border color
//             borderRadius: BorderRadius.circular(8), // Rounded corners
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.facebook, // Facebook icon
//                 color: Colors.blue,
//                 size: 20,
//               ),
//               SizedBox(width: 8), // Space between icon and text
//               Text(
//                 "SignUp with Facebook",
//                 style: TextStyle(
//                   color: Colors.black, // Text color
//                   fontSize: 14, // Text size
//                   fontWeight: FontWeight.bold, // Text weight
//                 ),
//               ),
//             ],
//           ),
//         ).animate().fadeIn(duration: 600.ms).then(delay: 200.ms).slide(
//               begin: const Offset(-1.0, -1.0), // Start from the right
//               end: Offset.zero, // End at the original position
//               duration: 800.ms,
//             ),
//       ],
//     );
//   }
// }
