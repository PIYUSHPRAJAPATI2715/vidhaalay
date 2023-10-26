import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';


class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final TextEditingController searchController = TextEditingController();
  List<String> subjects = [
    'Arts',
    'Commerce',
    'Economics',
    'Maths',
    'Business Studies',
    'Hindi',
    'English',
    'French',
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: const[
            Icon(Icons.location_pin,color: AppThemes.primaryColor,size: 20,),
            SizedBox(width: 4,),
            Text('2282 Lakewood Drive',
              style: TextStyle(
                  color: AppThemes.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15
              ),),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipOval(
                  child: Image.asset(AppAssets.studentImg,height: 35,),
                )
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrSPl7WFavKZSVP0vwZtZya-eCngrz-Rk0XA&usqp=CAU",width: size.width,height: 500,)
         //    Container(
         //      decoration: BoxDecoration(
         //        borderRadius: BorderRadius.circular(50),
         //        boxShadow: [
         //          BoxShadow(
         //            color: Colors.black.withOpacity(0.2),
         //            spreadRadius: 1,
         //            blurRadius: 2,
         //            offset: const Offset(0, 2),
         //          ),
         //        ],
         //      ),
         //      height: 44,
         //      child: TextField(
         //        maxLines: 1,
         //        controller: searchController,
         //        style: const TextStyle(fontSize: 17),
         //        textAlignVertical: TextAlignVertical.center,
         //        textInputAction: TextInputAction.search,
         //        onSubmitted: (value) => {},
         //        decoration: InputDecoration(
         //            filled: true,
         //            suffixIcon: IconButton(
         //              onPressed: () {
         //                // Get.to(const SearchScreenData());
         //                // FocusManager.instance.primaryFocus!
         //                //     .unfocus();
         //                // print(homeSearchController
         //                //     .searchController);
         //                // Get.toNamed(
         //                //     SearchScreenData.searchScreen);
         //              },
         //              icon: const Icon(
         //                Icons.search_rounded,
         //                color: AppThemes.black,
         //                size: 19,
         //              ),
         //            ),
         //            border: const OutlineInputBorder(
         //                borderSide: BorderSide.none,
         //                borderRadius: BorderRadius.all(
         //                    Radius.circular(50))),
         //            fillColor: Colors.white,
         //            contentPadding:
         //            const EdgeInsets.symmetric(
         //                horizontal: 20),
         //            hintText: 'Search',
         //            hintStyle: const TextStyle(
         //                fontSize:14,
         //                color: Colors.black,
         //                fontWeight: FontWeight.w400)),
         //      ),
         //    ),
         //    const SizedBox(
         //      height: 28,
         //    ),
         //    Image.asset(AppAssets.teacherImg),
         //    const SizedBox(
         //      height: 15,
         //    ),
         //     Text('Learning that fits',
         //      style: GoogleFonts.poppins(
         //          fontWeight: FontWeight.w500,
         //          fontSize: 20
         //      ),
         //    ),
         //    const SizedBox(
         //      height: 20,
         //    ),
         //    Wrap(
         //      spacing: 4.0,
         //      runSpacing: 7,
         //      children: subjects.map((subject) {
         //        return Container(
         //          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
         //          decoration: BoxDecoration(
         //            border: Border.all(
         //              color: AppThemes.textGray,
         //            ),
         //            borderRadius: BorderRadius.circular(50)
         //          ),
         //          child: Text(subject,
         //          style: const TextStyle(
         //            fontSize: 11,
         //            fontWeight: FontWeight.w300,
         //            color: AppThemes.textGray
         //          ),
         //          ),
         //        );
         //      }).toList(),
         //    ),
         //    const SizedBox(
         //      height: 15,
         //    ),
         //     Text('Featured Lectures',
         //      style: GoogleFonts.poppins(
         //          fontWeight: FontWeight.w500,
         //          fontSize: 20
         //      ),
         //    ),
         // const SizedBox(
         //    height: 8,
         //  ),
         //    ListView.builder(
         //      itemCount: 2,
         //      shrinkWrap: true,
         //      itemBuilder: (context, index) {
         //        return Column(
         //          children: [
         //            Stack(
         //              children: [
         //                SizedBox(
         //                  height: 140,
         //                  width: double.maxFinite,
         //                  child: Image.asset(AppAssets.videoImg,fit: BoxFit.cover,),
         //                ),
         //                Positioned(
         //                    top: 0,
         //                    bottom: 0,
         //                    left: 0,
         //                    right: 0,
         //                    child: Column(
         //                      mainAxisAlignment: MainAxisAlignment.center,
         //                      children: [
         //                        Container(
         //                            alignment: Alignment.center,
         //                            padding: EdgeInsets.all(2),
         //                            decoration: BoxDecoration(
         //                                shape: BoxShape.circle,
         //                                border: Border.all(
         //                                    color: Colors.white
         //                                )
         //                            ),
         //                            child: Icon(Icons.play_arrow,color: Colors.white,)),
         //                      ],
         //                    )
         //                ),
         //                Positioned(
         //                    right: 10, top: 10,
         //                    child: Icon(Icons.favorite_border,size: 18,color: Colors.white)
         //                ),
         //              ],
         //            ),
         //            const SizedBox(
         //              height: 4,
         //            ),
         //            Row(
         //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
         //              children: [
         //                Text('Our Animal Friends Kids...',
         //                  style: GoogleFonts.poppins(
         //                    color: AppThemes.textBlackColor,
         //                    fontWeight: FontWeight.w600,
         //                    fontSize: 14
         //                  ),
         //                ),
         //                Text('₹ 280',
         //                  style: GoogleFonts.poppins(
         //                      color: AppThemes.primaryColor,
         //                      fontWeight: FontWeight.w600,
         //                      fontSize: 14
         //                  ),
         //                ),
         //              ],
         //            ),
         //            SizedBox(
         //              height: 2,
         //            ),
         //            Row(
         //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
         //              children: [
         //                Row(
         //                  children: [
         //                    ClipRRect(
         //                      borderRadius: BorderRadius.circular(50),
         //                      child:  Image.asset(AppAssets.studentImg,height: 14,),
         //                    ),
         //                   const SizedBox(
         //                      width: 4,
         //                    ),
         //                    Text('Rosie David',
         //                      style: GoogleFonts.poppins(
         //                          color: Colors.orange,
         //                          fontWeight: FontWeight.w600,
         //                          fontSize: 10
         //                      ),
         //                    ),
         //                  ],
         //                ),
         //                Text('Subject - Hindi',
         //                  style: GoogleFonts.poppins(
         //                      color: AppThemes.textGray,
         //                      fontWeight: FontWeight.w600,
         //                      fontSize: 10
         //                  ),
         //                ),
         //              ],
         //            ),
         //           const SizedBox(
         //              height: 18,
         //            )
         //          ],
         //        );
         //      },
         //    )
          ],
        ),
      ),
    );
  }
}



