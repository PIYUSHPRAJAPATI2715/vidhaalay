import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vidhaalay_app/models/TeacherModel/create_event_model.dart';
import 'package:vidhaalay_app/screen/student_screen/assignment_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/attendance_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/home_screen.dart';
import 'package:vidhaalay_app/screen/teacher_flow/create_event_screen.dart';

class BottomPractise extends StatefulWidget{
  @override
  State<BottomPractise> createState() => _BottomPractiseState();
}

class _BottomPractiseState extends State<BottomPractise> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static List<Widget> _widgetAppBar = <Widget>[
    Text('Home'),
    Text('Category'),
    Text('Account'),
  ];

  static List<Widget> _widgetBody = <Widget>[
    const CreateEventScreen(),
    const CreateEventScreen(),
    const CreateEventScreen(),
  ];

  void onItemTapped(BuildContext context,int index) {
    setState(() {
      if(index == 2) {
        // _scaffoldKey.currentState?.openDrawer();
        Scaffold.of(context).openDrawer();
      } else {
        _selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Navigation Drawer',
        ),
        backgroundColor: const Color(0xff764abc),
      ),
      endDrawer: Container(
        width: MediaQuery.of(context).size.width * 0.6, //<-- SEE HERE
        child: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader( // <-- SEE HERE
                decoration: BoxDecoration(color: const Color(0xff764abc)),
                accountName: Text(
                  "Pinkesh Darji",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  "pinkesh.earth@gmail.com",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: FlutterLogo(),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Page 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.train,
                ),
                title: const Text('Page 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: _widgetAppBar.elementAt(_selectedIndex),
      //   // actions: [
      //   //   IconButton(
      //   //       onPressed: () async {
      //   //         await FastCachedImageConfig.clearAllCachedImages();
      //   //         // setState(() => log = 'All cached images deleted');
      //   //         // await Future.delayed(
      //   //         //     const Duration(seconds: 2), () => setState(() => log = null));
      //   //       },
      //   //       icon: Icon(Icons.delete))
      //   // ],
      // ),
      body: _widgetBody.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill,size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled,size: 30),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          if(value == 2) {
            print("Tap");
            // _scaffoldKey.currentState?.openDrawer();
            _scaffoldKey.currentState?.openEndDrawer();
            // Scaffold.of(context).openDrawer();
          } else {
            _selectedIndex = value;
          }
        },
        // onItemTapped(context,_selectedIndex),
      ),

    );
  }
}