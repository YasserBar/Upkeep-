// // import 'package:flutter/material.dart';
// // class MyDropDown extends StatefulWidget {
// //   @override
// //   _MyDropDownState createState() => _MyDropDownState();
// // }
// //
// // class _MyDropDownState extends State<MyDropDown> {
// //   String _selectedCity = 'دمشق';
// //
// //   List<String> _cities = ['دمشق', 'اللاذقية', 'حمص'];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         DropdownButton(
// //
// //           value: _selectedCity,
// //           items: _cities.map((String city) {
// //             return DropdownMenuItem(
// //               value: city,
// //               child: Text(city),
// //             );
// //           }).toList(),
// //          onChanged: (String ? newValue) {
// //             setState(() {
// //               _selectedCity = newValue!;
// //             });
// //           },
// //         borderRadius: BorderRadius.all(Radius.circular(22)),
// //         ),
// //         // AnimatedContainer(
// //         //   duration: Duration(microseconds: 300),
// //         //   height: _selectedCity == 'دمشق' ? 100.0 : 200.0,
// //         //   width: 200.0,
// //         //
// //         // ),
// //       ],
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
//
// class DropdownButtonExample extends StatefulWidget {
//   @override
//   _DropdownButtonExampleState createState() => _DropdownButtonExampleState();
// }
//
// class _DropdownButtonExampleState extends State<DropdownButtonExample> {
//   String selectedCity = "دمشق";
//   List<String> cities = ["دمشق", "اللاذقية", "حمص"];
//   bool isExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         InkWell(
//           onTap: () {
//             setState(() {
//               isExpanded = !isExpanded;
//             });
//           },
//           child: Container(
//             height: 50,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white),
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: 16),
//                   child: Text(selectedCity),
//                 ),
//                 Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
//               ],
//             ),
//           ),
//         ),
//         AnimatedContainer(
//           duration: Duration(milliseconds: 100),
//           height: isExpanded ? cities.length * 50.0 : 0,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.white),
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.white,
//           ),
//           child: ListView.builder(
//             itemCount: cities.length,
//             itemBuilder: (context, index) {
//               return InkWell(
//                 onTap: () {
//                   setState(() {
//                     selectedCity = cities[index];
//                     isExpanded = false;
//                   });
//                 },
//                 child: Container(
//                   height: 50,
//                   alignment: Alignment.centerLeft,
//                   padding: EdgeInsets.only(left: 16),
//                   child: Text(cities[index]),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatefulWidget {
  final List<dynamic> s;
  final String title;
  final Color bColor;
  final Color titleColor;
  final Function(String)? onChanged;

  const DropdownButtonWidget(
      {super.key,
      required this.s,
      required this.title,
      this.bColor = Colors.white,
      this.titleColor = Colors.black,
      this.onChanged});

  @override
  // ignore: library_private_types_in_public_api
  _DropdownButtonWidgetState createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              )),
          contentPadding: EdgeInsets.all(10)
        ),
        hint: Text(
          widget.title,
          style: TextStyle(color: widget.titleColor),
        ),
        value: selectedCity,
        onChanged: (value) {
          setState(() {
            selectedCity = value as String?;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(selectedCity!);
          }
        },
        items: widget.s.map((city) {
          return DropdownMenuItem(
            value: city,
            child: Text(
              city,
              style: TextStyle(color: widget.titleColor),
            ),
          );
        }).toList(),
      ),
    );
  }
}
