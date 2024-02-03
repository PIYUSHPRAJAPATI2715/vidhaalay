
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

Widget commonProfileImageCircle({
  required BuildContext context,
  required bool isProfileImageLoading,
  required bool isProfileExist,
  required String? image,
  double radius = 17,
}) {
  return CircleAvatar(
    radius: radius,
    backgroundColor: Colors.transparent,
    child: ClipOval(
      child: isProfileImageLoading
          ? Shimmer.fromColors(
        // ignore: sort_child_properties_las t
        child: CircleAvatar(
            radius: 18, backgroundColor: Colors.grey),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[400]!,
      )
          :
      isProfileExist
          ? CachedNetworkImage(
        imageUrl: image.toString(),
        fit: BoxFit.fill,
        errorWidget: (__, _, ___) =>   Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage( AppAssets.studentImg,),
              fit: BoxFit.fill,
            ),
          ),
        ),
        // Image.asset(
        //   AppAssets.collageImg,
        //   fit: BoxFit.cover,
        //   width: double.maxFinite,
        // ),
        imageBuilder: (context, imageProvider) =>
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        placeholder: (context, url) =>
            Shimmer.fromColors(
              // ignore: sort_child_properties_last
              child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey),
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[400]!,
            ),
      )
      // Image.network(getProfileController.networkProfileImage.toString(),fit: BoxFit.fill)
          :
      // Container(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage( AppAssets.studentImg,),
      //       fit: BoxFit.fill,
      //     ),
      //   ),
      // ),
      Image.asset(
        AppAssets.studentImg,
        fit: BoxFit.cover,
        // height: 35,
      ),
    ),
  );
}