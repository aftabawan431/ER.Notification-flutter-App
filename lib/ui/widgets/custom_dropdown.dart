import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropdownButtonWidget extends StatefulWidget {
  DropdownButtonWidget(
      {required this.hint,
        required this.selected,
        required this.onChange,
        required this.list,

        Key? key})
      : super(key: key);
  String? selected;
  final String hint;
  String? Function(String?)? onChange;
  List<String> list;

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.5),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            hint: Text(widget.hint),
            isExpanded: true,
            value: widget.selected,
            items: widget.list
                .map((e) => DropdownMenuItem(
              child: Text(e),
              value: e,
            ))
                .toList(),
            onChanged: widget.onChange),
      ),
    );
  }
}
