
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class CommonDialog{

  void imageViewer(BuildContext context,String url) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        var size = MediaQuery.of(context).size;
        return AlertDialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: size.height * .25,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: url.toString(),
                fit: BoxFit.fill,
                // width: size.width,
                // height: size.height * .16,
                errorWidget: (__, _, ___) =>
                    Image.asset(
                      AppAssets.collageImg,
                      fit: BoxFit.cover,
                      width: size.width,
                      height: size.height * .16,
                    ),
                placeholder: (__, _) =>
                const Center(
                    child: CircularProgressIndicator()),
              ),
            ),
          ),
        );
      },
    );
  }
}