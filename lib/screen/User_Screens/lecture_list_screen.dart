import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LectureListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
                Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined,color: Colors.black,)
        ),
        title:  Text('All Lectures',style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18
        ),),
      ),
      body: Column(

      ),
    );
  }

}