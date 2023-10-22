import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resourses/size.dart';
import '../../widgets/appTheme.dart';


class CommonProgressIndicator extends StatelessWidget {
  const CommonProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Platform.isAndroid ? const CircularProgressIndicator(color: AppThemes.primaryColor,):
        CupertinoActivityIndicator(color: AppThemes.primaryColor,radius: AddSize.size20, )
    );
  }
}
