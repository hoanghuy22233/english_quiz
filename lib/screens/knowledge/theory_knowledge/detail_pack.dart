// // ignore: import_of_legacy_library_into_null_safe
// import 'package:utils_libs/utils_libs.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class DetailPack extends StatefulWidget {
//   @override
//   _DetailPackState createState() => _DetailPackState();
// }
//
// class _DetailPackState extends State<DetailPack> {
//
//   @override
//   Widget build(BuildContext context) {
//     DataMode dataMode = Get.arguments;
//     return DetailContainer(
//       child: Column(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 AppValue.vSpaceTiny,
//                 Image.asset(IMAGES.BACK_GOURD_HEADER),
//                 AppValue.vSpaceSmall,
//                 Text(
//                   MESSAGES.MODE + ": ${dataMode.modeName ?? MESSAGES.NO_DATA}",
//                   style: AppStyle.DEFAULT_MEDIUM_BOLD,
//                 ),
//                 AppValue.vSpaceSmall,
//                 WitgetRowList(
//                   title: MESSAGES.AMOUNT_OF_MONEY ?? MESSAGES.NO_DATA,
//                   subTitle: Handle.choosePrice(),
//                   isCheckSubTitle: true,
//                 ),
//                 AppValue.vSpaceSmall,
//                 Text(
//                   dataMode.description ?? MESSAGES.NO_DATA,
//                   style: AppStyle.DEFAULT_MEDIUM,
//                 ),
//               ],
//             ),
//           ),
//           Button(
//             onTap: () => AppNavigator.navigateCheckPermission(),
//             child: WitgetButton(width: 329, height: 39, title: MESSAGES.FIND_WASHING_MACHINE),
//           ),
//           AppValue.vSpace(27)
//         ],
//       ),
//     );
//   }
// }
