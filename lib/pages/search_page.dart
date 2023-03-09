// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_verse/pages/image_preview.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;
  late String search_text = '';

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Find wallpaper',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    search_text = value;
                  });
                },
                decoration: InputDecoration(hintText: 'Search somthing...'),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //Stream Builder.
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('All wallpapers')
                .snapshots(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                //return emptry container.
                return Container();
              } else {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        var name = FirebaseFirestore.instance
                            .collection('All wallpapers')
                            .get() as Map<String, dynamic>;

                        if (name['name']
                            .toString()
                            .toLowerCase()
                            .contains(search_text)) {
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
                        } else {
                          return Container();
                        }
                      }),
                    ),
                  ),
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
