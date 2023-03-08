// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallpaper_verse/pages/bookmarks_page.dart';
import 'package:wallpaper_verse/pages/home_page.dart';
import 'package:wallpaper_verse/pages/settings_page.dart';
import 'package:permission_handler/permission_handler.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int currentPage = 0;
  void onPageChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  final List _pages = [
    HomePage(),
    BookMarksPage(),
    SettingsPage(),
  ];
  //Ask permissions [package:permission_handler]
  checkPermissions() async {
    //Permissions
    var manageExternalStorage = await Permission.manageExternalStorage.status;
    var storage = await Permission.storage.status;
    var photos = Permission.photos;

    //Check if its allowed.

    if (manageExternalStorage.isDenied) {
      //Ask permission.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.manageExternalStorage,
      ].request();
    } else if (storage.isDenied) {
      //Ask permission.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    } else if (await photos.isDenied) {
      //Ask permission.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.photos,
      ].request();
    } else if (manageExternalStorage.isRestricted) {
      //Ask permission.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.manageExternalStorage,
      ].request();
    } else if (storage.isRestricted) {
      //Ask permission
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    } else if (await photos.isRestricted) {
      //Ask permission.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.photos,
      ].request();
    } else {
      //Return nothing.
    }
  }

  
  @override
  void initState() {
    //Check permissions first.
    checkPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Body
      body: _pages[currentPage],
      //BottonNavigationBar.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        onTap: onPageChange,
        items: [
          //Home item
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home_icon.svg',
                fit: BoxFit.none,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/home_icon.svg',
                fit: BoxFit.none,
                color: Colors.lightBlue,
              ),
              label: 'Home'),
          //Downloads item
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/bookmark_icon.svg',
                fit: BoxFit.none,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/bookmark_icon.svg',
                fit: BoxFit.none,
                color: Colors.lightBlue,
              ),
              label: 'Downloads'),
          //Settings Item
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/settings_icon.svg',
                fit: BoxFit.none,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/settings_icon.svg',
                fit: BoxFit.none,
                color: Colors.lightBlue,
              ),
              label: 'Settings'),
        ],
      ),
    );
  }
}
