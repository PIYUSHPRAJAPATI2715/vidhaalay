import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
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
        padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 37,
              child: TextField(
                maxLines: 1,
                controller: searchController,
                style: const TextStyle(fontSize: 17),
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) => {},
                decoration: InputDecoration(
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Get.to(const SearchScreenData());
                        // FocusManager.instance.primaryFocus!
                        //     .unfocus();
                        // print(homeSearchController
                        //     .searchController);
                        // Get.toNamed(
                        //     SearchScreenData.searchScreen);
                      },
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.green,
                        size: 30,
                      ),
                    ),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                            Radius.circular(8))),
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 4),
                    hintText: 'Search Your Groceries',
                    hintStyle: const TextStyle(
                        fontSize:14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('Learning that fits',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: subjects.map((subject) {
                return Chip(
                  label: Text(subject),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('Featured Lectures',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20
              ),
            ),

            ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 140,
                          color: Colors.red,
                        ),
                        Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white
                                        )
                                    ),
                                    child: Icon(Icons.play_arrow,color: Colors.white,)),
                              ],
                            )
                        ),
                        Positioned(
                            right: 10, top: 10,
                            child: Icon(Icons.favorite_border,size: 18,color: Colors.white)
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Our Animal Friends Kids...'),
                        Text('₹ 280'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Rosie David'),
                        Text('Subject - Hindi'),
                      ],
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}



