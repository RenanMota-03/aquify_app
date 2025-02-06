import 'package:flutter/material.dart';

class DropdownMenuWidget extends StatefulWidget {
  final List<String> list;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? label;
  final EdgeInsetsGeometry? padding;
  const DropdownMenuWidget({
    super.key,
    required this.list,
    this.controller,
    this.hintText,
    this.label,
    this.padding,
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
    return Padding(
      padding:
          widget.padding ??
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: DropdownMenu<String>(
        width: MediaQuery.of(context).size.width,
        label: widget.label,
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
      ),
    );
  }
}
