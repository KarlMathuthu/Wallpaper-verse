// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_verse/pages/image_preview.dart';
import 'package:wallpaper_verse/theme/model.dart';

import '../../theme/theme_colors.dart';

class SportCarsPage extends StatefulWidget {
  const SportCarsPage({super.key});

  @override
  State<SportCarsPage> createState() => _SportCarsPageState();
}

class _SportCarsPageState extends State<SportCarsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ThemeModel themeNotifier, child) {
        return Scaffold(
          backgroundColor: themeNotifier.isDark
              ? DarkTheme().scafforldColor
              : LightTheme().scafforldColor,
          appBar: AppBar(
            backgroundColor: themeNotifier.isDark
                ? DarkTheme().scafforldColor
                : LightTheme().scafforldColor,
            scrolledUnderElevation: 0,
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Sport Cars',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Sport car')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          //return text.
                          return Text(
                            '${snapshot.data!.docs.length} wallpapers available',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          );
                        } else {
                          //return text with no wallpapers.
                          return Text(
                            'No wallpapers available',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              //Masonry GridView [from package].
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Sport car')
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MasonryGridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 6,
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => ImagePreviewer(
                                        imageUrl: snapshot.data!.docs[index]
                                            ['imageUrl'])),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  snapshot.data!.docs[index]['imageUrl'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  } else {
                    //return shimmer.
                    return Container();
                  }
                }),
              )
            ],
          ),
        );
      }),
    );
  }
}
