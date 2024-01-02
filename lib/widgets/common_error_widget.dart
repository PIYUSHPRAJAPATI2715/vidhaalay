import 'package:flutter/material.dart';
import '../../widgets/appTheme.dart';
import 'common_button.dart';



class CommonErrorWidget extends StatelessWidget {
  final String errorText;
  final VoidCallback onTap;
  const CommonErrorWidget({Key? key, required this.errorText, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorText,
          ),
          const SizedBox(
            height: 20,
          ),

          CustomOutlineButton(
            title: "Refresh",
            backgroundColor: Colors.white,
            onPressed: onTap,
            textColor: AppThemes.primaryColor,
          )
        ],
      ),
    );
  }
}
