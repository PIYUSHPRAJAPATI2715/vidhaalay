import 'package:flutter/material.dart';
import '../../widgets/appTheme.dart';


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
            side:  const BorderSide(
              color:  AppThemes.primaryColor,
            ), backgroundColor: backgroundColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                )),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                color: Colors.white,
              ),
            ),
          ),        )
            : Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.white,
          ),
        ));
  }
}
class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool? expandedValue;
  final Color? textColor;

  const CommonButton(
      {Key? key,
        required this.title,
        this.onPressed,
        this.textColor,
        this.expandedValue = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(

            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                )), backgroundColor: AppThemes.primaryColor,
            // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppThemes.white,
            )),
        onPressed: onPressed,
        child: expandedValue == true ? SizedBox(
          width: double.maxFinite,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),        )
            : Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.white,
          ),
        ));
  }
}
