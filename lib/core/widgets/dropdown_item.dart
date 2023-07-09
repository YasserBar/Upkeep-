import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatefulWidget {
  final List<String> s;
  final String title;
  final Color bColor;
  final Color titleColor;
  final Function(String)? onChanged;
  final String? selectedValue;

  const DropdownButtonWidget({
    Key? key,
    required this.s,
    required this.title,
    this.bColor = Colors.white,
    this.titleColor = Colors.black,
    this.onChanged,
    this.selectedValue,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DropdownButtonWidgetState createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    selectedCity = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: widget.bColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            hint: Text(
              widget.title,
              style: TextStyle(color: widget.titleColor),
            ),
            value: selectedCity,
            onChanged: (value) {
              setState(() {
                selectedCity = value;
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
        ),
      ),
    );
  }
}
