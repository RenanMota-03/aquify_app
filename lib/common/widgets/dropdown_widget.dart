import 'package:flutter/material.dart';

class DropdownMenuWidget extends StatefulWidget {
  final List<String> list;
  final TextEditingController? controller;
  final String? hintText;
  const DropdownMenuWidget({
    super.key,
    required this.list,
    this.controller,
    this.hintText,
  });

  @override
  State<DropdownMenuWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      controller: widget.controller,
      hintText: widget.hintText,
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          widget.list.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
    );
  }
}
