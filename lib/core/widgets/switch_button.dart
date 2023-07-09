import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key, required this.onValueChanged});
  final Function(bool) onValueChanged;
  @override
  // ignore: library_private_types_in_public_api
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: const Color(0xff0CDC5F),
      value: _isSwitched,
      onChanged: (bool value) {
        setState(() {
          _isSwitched = value;
        });
        widget.onValueChanged.call(value);
      },
    );
  }
}
