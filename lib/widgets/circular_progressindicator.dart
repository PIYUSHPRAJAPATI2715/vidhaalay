import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../resourses/size.dart';
import '../../widgets/appTheme.dart';


class CommonProgressIndicator extends StatelessWidget {
  const CommonProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      height: size.height,
      width: size.width,
      top: 0,
      left: 0,
      child: Material(
        color: AppThemes.primaryColor.withOpacity(0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.threeArchedCircle(color: AppThemes.primaryColor, size: AddSize.size40),
          ],
        ),
      ),
    );
      /*Center(
        child: Platform.isAndroid ? const CircularProgressIndicator(color: AppThemes.primaryColor,):
        CupertinoActivityIndicator(color: AppThemes.primaryColor,radius: AddSize.size20, )
    )*/;
  }
}
