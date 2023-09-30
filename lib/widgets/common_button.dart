import 'package:flutter/material.dart';
import 'package:vidhaalay_app/widgets/resources.dart';


class CustomOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final bool? expandedValue;
  final Color? textColor;

  const CustomOutlineButton(
      {Key? key,
        required this.title,
        this.onPressed,
        required this.backgroundColor,
        this.textColor,
        this.expandedValue = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            side:  BorderSide(
              color:  AppTheme.primaryColor,
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                )),
            primary: backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            )),
        onPressed: onPressed,
        child: expandedValue == true ? SizedBox(
          width: double.maxFinite,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: textColor,
              ),
            ),
          ),        )
            : Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: textColor,
          ),
        ));
  }
}
