// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_verse/pages/categories/animals_page.dart';
import 'package:wallpaper_verse/pages/categories/anime_page.dart';
import 'package:wallpaper_verse/pages/categories/nature_page.dart';
import 'package:wallpaper_verse/pages/categories/sport_cars.dart';
import 'package:wallpaper_verse/widgets/container_widget.dart';
import 'package:wallpaper_verse/widgets/item_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //for getting the device width.
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.grey[100],
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          //Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Find wallpaper...',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(
                      'assets/icons/search_icon.svg',
                      color: Colors.grey,
                      fit: BoxFit.none,
                    ),
                  )
                ],
              ),
            ),
          ),
          //Best of the month Text
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
                child: Text(
                  'Best of the month',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          //Stream Builder.
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Slider images')
                .snapshots(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return //Best of the month Carousel Slider [From the package]
                    CarouselSlider.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index, realIndex) {
                    return ContainerWidget(
                      imageUrl: snapshot.data!.docs[index]['imageUrl'],
                    );
                  }),
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 210,
                    autoPlayAnimationDuration: Duration(
                      milliseconds: 1000,
                    ),
                  ),
                );
              } else {
                //return empty container.
                return Container();
              }
            }),
          ),

          //Categories text.
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          //I did not use gridview because it does not allow custom height and width.
          //Categories rows.
          //first row.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //item one.
              ItemContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NaturePage(),
                    ),
                  );
                },
                title: 'Nature',
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/wallpaper-verse.appspot.com/o/Categories%20Images%2Fnature.jpg?alt=media&token=f00a7dea-6e4f-439a-b324-c4a000122c7d',
              ),
              //item two.
              ItemContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SportCarsPage(),
                    ),
                  );
                },
                title: 'Sport Cars',
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/wallpaper-verse.appspot.com/o/Categories%20Images%2Fsport%20car.jpg?alt=media&token=0e332cea-b9cc-4f1c-ae0a-e1c4ad3c7cd0',
              ),
            ],
          ),
          //second row.

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //item one.
              ItemContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimalsPage(),
                    ),
                  );
                },
                title: 'Animals',
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/wallpaper-verse.appspot.com/o/Categories%20Images%2Fanimal.jpg?alt=media&token=a97ca88d-5cae-4557-a8ac-8161f90e128f',
              ),
              //item two.
              ItemContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimePage(),
                    ),
                  );
                },
                title: 'Anime',
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/wallpaper-verse.appspot.com/o/Categories%20Images%2Fanime.jpg?alt=media&token=654c0510-ac74-4cf0-9261-ce74b50e69dc',
              ),
            ],
          )
        ],
      ),
    );
  }
}
