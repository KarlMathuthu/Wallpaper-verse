// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper_verse/widgets/loader.dart';

class ImagePreviewer extends StatefulWidget {
  final String imageUrl;
  const ImagePreviewer({
    super.key,
    required this.imageUrl,
  });

  @override
  State<ImagePreviewer> createState() => _ImagePreviewerState();
}

class _ImagePreviewerState extends State<ImagePreviewer> {
  downloadImage() async {
    try {
      await GallerySaver.saveImage(widget.imageUrl,
          toDcim: true, albumName: 'Wallpaper-verse');
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to download.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    Fluttertoast.showToast(
        msg: "Wallaper downloaded",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(widget.imageUrl),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/bookmark_icon.svg',
                    color: Colors.white,
                    fit: BoxFit.none,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                IconButton(
                  onPressed: () {
                    downloadImage();
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/downloads_icon.svg',
                    color: Colors.white,
                    fit: BoxFit.none,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
