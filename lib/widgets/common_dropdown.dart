

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CommonDropDownButton extends StatefulWidget {

  final List<DropdownMenuItem> items;
  final value;
  final ValueChanged onChanged;
  final double width;
  final Color? backgroundColor;


  const CommonDropDownButton({super.key,required this.items, required this.value, required this.onChanged, required this.width, this.backgroundColor = null});

  @override
  State<CommonDropDownButton> createState() => _CommonDropDownButtonState();
}

class _CommonDropDownButtonState extends State<CommonDropDownButton> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value:  widget.value,
        // icon: Icon(Icons.keyboard_arrow_down,color: Colors.white),
        dropdownStyleData: DropdownStyleData(
          maxHeight: size.height * 0.28,
          width: widget.width,
          // size.width * 0.55,
          padding: EdgeInsets.symmetric(horizontal: 5),
          isOverButton: false,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: widget.backgroundColor == null ? Colors.white70 : widget.backgroundColor,
          ),
          offset: const Offset(-10, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 45,
          padding: EdgeInsets.only(left: 10, right: 10),
        ),
        // dropdownColor: Colors.white70,
        items: widget.items,
        onChanged: widget.onChanged
      ),
    );

  }
}