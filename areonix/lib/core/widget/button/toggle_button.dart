// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../core/constants/index.dart';
// import '../../../views/member/profile_member/provider/profile_provider.dart';

// class ToggleButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProfileProvider>(
//       builder: (context, profileProvider, child) {
//         return Switch(
//           value: profileProvider.isSwitched,
//           onChanged: (value) {
//             profileProvider.toggleSwitch(value);
//           },
//           activeColor: TColor.pink,
//           inactiveThumbColor: TColor.black,
//           trackOutlineColor: WidgetStateProperty.resolveWith<Color>(
//             (Set<WidgetState> states) {
//               if (states.contains(WidgetState.selected)) {
//                 return TColor.pink;
//               }
//               return TColor.black;
//             },
//           ),
//         );
//       },
//     );
//   }
// }
