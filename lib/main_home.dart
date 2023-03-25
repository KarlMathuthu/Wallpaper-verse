// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_verse/pages/explore_page.dart';
import 'package:wallpaper_verse/pages/home_page.dart';
import 'package:wallpaper_verse/pages/settings_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_verse/theme/model.dart';
import 'package:wallpaper_verse/theme/theme_colors.dart';

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
    ExplorePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ThemeModel themeNotifier, child) {
        return Scaffold(
          //Body
          body: _pages[currentPage],
          //BottonNavigationBar.
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: themeNotifier.isDark
                ? DarkTheme().bottomNavColor
                : LightTheme().bottomNavColor,
            onTap: onPageChange,
            items: [
              //Home item
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/home_icon.svg',
                    fit: BoxFit.none,
                    color: themeNotifier.isDark
                        ? DarkTheme().iconColor
                        : LightTheme().iconColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/active_home.svg',
                    fit: BoxFit.none,
                    color: Colors.blue,
                  ),
                  label: 'Home'),
              //Downloads item
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/explore.svg',
                    fit: BoxFit.none,
                    color: themeNotifier.isDark
                        ? DarkTheme().iconColor
                        : LightTheme().iconColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/active_explore.svg',
                    fit: BoxFit.none,
                    color: Colors.lightBlue,
                  ),
                  label: 'Explore'),
              //Settings Item
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/settings_icon.svg',
                    fit: BoxFit.none,
                    color: themeNotifier.isDark
                        ? DarkTheme().iconColor
                        : LightTheme().iconColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/active_settings.svg',
                    fit: BoxFit.none,
                    color: Colors.lightBlue,
                  ),
                  label: 'Settings'),
            ],
          ),
        );
      }),
    );
  }
}
