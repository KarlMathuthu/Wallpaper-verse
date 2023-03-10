// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_verse/pages/image_preview.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Find more wallpapers',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          //Masonry GridView [from package].
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('All wallpapers')
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
  }
}
