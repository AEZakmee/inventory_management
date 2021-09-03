import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

// Row(
//   crossAxisAlignment: CrossAxisAlignment.end,
//   children: [
//     Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: kBorderRadiusLite,
//           border: Border.all(color: kMainColorAccent),
//         ),
//         // child: Padding(
//         //   padding: EdgeInsets.symmetric(
//         //     horizontal: getProportionateScreenWidth(5),
//         //   ),
//         //   child: DropdownButtonHideUnderline(
//         //     child: DropdownButton<Resource>(
//         //       value: prov.selectedResource,
//         //       hint: Text('Select resource'),
//         //       selectedItemBuilder: ,
//         //       icon: Icon(Icons.arrow_downward),
//         //       iconSize: getProportionateScreenHeight(25),
//         //       elevation: 17,
//         //       style: TextStyle(
//         //         color: kMainColor,
//         //         fontSize: getProportionateScreenWidth(17),
//         //       ),
//         //       onChanged: (Resource newValue) {
//         //         prov.selectedResource = newValue;
//         //       },
//         //       items: snapshot.data != null
//         //           ? snapshot.data
//         //               .map<DropdownMenuItem<Resource>>(
//         //                   (value) {
//         //               return DropdownMenuItem<Resource>(
//         //                 value: value,
//         //                 child: Text(value.name),
//         //               );
//         //             }).toList()
//         //           : SizedBox(height: 0.0),
//         //     ),
//         //   ),
//         // ),
//       ),
//     ),
//     SizedBox(
//       width: getProportionateScreenWidth(10),
//     ),
//     Expanded(
//       child: CustomTextField(
//         textController: prov.quantityController,
//         field: ProductField.Quantity,
//         hintText: "Enter quantity",
//         label: "Quantity",
//         prov: prov,
//       ),
//     ),
//   ],
// ),
